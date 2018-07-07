
//
//  Networking.m
//  MasterDataManager
//
//  Created by Rick on 2014/5/8.
//  Copyright (c) 2014年 FDT. All rights reserved.
//

#import "Networking.h"
#import "GCDAsyncSocket.h"
#import "Reachability.h"
#import "PacketAnalyzer.h"
#import "GZIP.h"
#import "FDUtility.h"
#import "JPacketSendBase.h"


#define RECONNECT_Interval 1
#define AUTOCHANGEMODE 0
#define CONNECT_TO_HOST_TIMEOUT 10

@interface Networking (Private) <GCDAsyncSocketDelegate>
{
    
}
@end

@implementation Networking

@synthesize delegate = _delegate;

- (id)initWithServerStage:(ConnectionServerStage)serverStage delegate:(__weak id<PacketDataProtocol>)delegate
{
    self = [super init];
    if (self)
    {
        _serverStage = serverStage;
        _delegate = delegate;
        
        // GCD Queue
        _socketQueue = dispatch_queue_create("Socket TCP Queue", nil);
        _delegateQueue = dispatch_queue_create("Socket Delegate Queue", nil);
        _serialQueue = dispatch_queue_create("DataHelperSerialQueue", nil);
        
        _socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:_delegateQueue socketQueue:_socketQueue];
        [_socket setIPv4PreferredOverIPv6:false];
        _bAuthDone = NO;
        
        // Packet Analyzer
        _analyzer = [[PacketAnalyzer alloc] init];
        
        // Params init.
        _bWorking = NO; // Waiting for connect action
        _fReConnectInterval = RECONNECT_Interval;
        _statusRTConnection = NetworkStatus_DisConnect;
        self.nRetryTimes = 0;
        _isUsing = true;
        _buffer = [NSMutableData new];
    }
    
    return self;
    
}

- (void)dealloc
{
    LogDebug(@"dealloc: Networking");
    
    _analyzer = nil;
    _buffer = nil;
    
    if (_reachabilty)
    {
        [_reachabilty stopNotifier];
        _reachabilty = nil;
        [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
    }
}

- (void)setRTNotifier:(NSString *)host
{
    if (host && _reachabilty == nil)
    {
        // Reachability
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
        _reachabilty = [Reachability reachabilityForInternetConnection];
        [_reachabilty startNotifier];
    }
}

- (void)connectToRTServer:(NSString *)strRTHost onPort:(int)nPort connectionStage:(ConnectionServerStage)stage
{
    _serverStage = stage;
    _bWorking = YES;
    self.strRTHost = strRTHost;
    self.nRTPort = nPort;
    
    [self connectWithHost:self.strRTHost onPort:self.nRTPort printSName:nil];
}

- (void)connectWithHost:(NSString *)host onPort:(uint16_t)port printSName:(NSString *)strSName
{
    
    if (_socket == nil)
    {
        _socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:_delegateQueue socketQueue:_socketQueue];
    }
    
    NSError *error = nil;
    //    [FDTOnlineLogger log:[NSString stringWithFormat:@"Socket Connect to \"%@\" on port %d ...", host, port] withCategory:ONLINE_LOGGER_INFO];
    
    
    _statusRTConnection = NetworkStatus_Connecting;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.delegateNetworkConnect handleConnectStatus:NetworkStatus_Connecting obj:@(_serverStage) sender:self];
    });
    
    if (![_socket connectToHost:host onPort:port withTimeout:CONNECT_TO_HOST_TIMEOUT error:&error])
    {
        [self errorLogger:error];
    }
    else
    {
        LogDebug(@"connecttohost");
        
        if (_socket.isConnected) {
            LogDebug(@"isConnected so change status to connected");;
            _statusRTConnection = NetworkStatus_Connected;
        }
        LogDebug(@"isConnected so read data");;
        [_socket readDataWithTimeout:-1 tag:0];
    }
    
    
}
- (void)doReConnect
{
    if (_socket.isConnected) {
        LogDebug(@"doReconnect but socket is connected, so do nothing");
        return;
    }
    
    _statusRTConnection = NetworkStatus_DisConnect;
    LogDebug(@"Networking - ReConnecting...");
    
    if (self.strRTHost == nil || self.nRTPort < 0)
    {
        self.strRTHost = [self.delegateNetworkServerInfo nt_getServerHostSender:self];
        self.nRTPort = [[self.delegateNetworkServerInfo nt_getServerPortSender:self] intValue];
    }
    
    NSString *host = self.strRTHost;
    int nPort = self.nRTPort;
    
    [self connectWithHost:host onPort:nPort printSName:nil];
}
-(void) resetParameter
{
    self.nRetryTimes = 0;
    self.strRTHost = nil;
    self.nRTPort = -1;
}

- (void)disconnectWithKeepRunning:(BOOL)bKeepRunning resetHost:(BOOL)bReset
{
    _bWorking = bKeepRunning;
    self.nRetryTimes = 0;
    
    if (bReset)
    {
        [self resetParameter];
    }
    
    // When Disconnect, func. will check _bWorking to see if we need to do the reconnection
    [_socket disconnect];
}

- (BOOL)isConnected
{
    return [_socket isConnected];
}
- (BOOL)isReachableViaWWAN
{
    return [_reachabilty isReachableViaWWAN];
}
- (BOOL)isReachableViaWiFi
{
    return [_reachabilty isReachableViaWiFi];
}

- (void)setAuthDone
{
    _bAuthDone = YES;
}

- (NSData *)sendRequest:(NSData *)request packet:(JPacketSendBase *)packet authPhrase:(BOOL)bInAuthPhrase
{
    if (!_socket.isConnected )
    {
        // 根本斷線, 去連線
        LogDebug(@"Packet Skiped: %@", packet);
        return nil;
    }
    
    if (_bAuthDone == NO && bInAuthPhrase == NO && _socket.isConnected)
    {
        // 正在交握, 就等等八
        LogDebug(@"Packet Skiped: %@", packet);
//        [DLog logDebug:[NSString stringWithFormat:@"Packet Skiped: %@", packet]];
        return nil;
    }
    
    
    // Compose
    request = [_analyzer composePack:request withVer:0x01];
    
    // Set Timeout Timer
    [packet startSendoutTimer];
#if DEBUG_MODE
    // Send
    LogDebug(@"PacketSend: %@ %@", packet, request);
#endif
    [_socket writeData:request withTimeout:5 tag:0];
    [_socket readDataWithTimeout:-1 tag:0];
    
    return request;
}


#pragma mark -
#pragma mark GCDAsyncSocket Methods

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    //    [FDTOnlineLogger log:[NSString stringWithFormat:@"Socket Connected To %@:%i", host, port] withCategory:ONLINE_LOGGER_INFO];
    
    _fReConnectInterval = RECONNECT_Interval;
    _statusRTConnection = NetworkStatus_Connected;
    self.nRetryTimes = 0;
    [sock readDataWithTimeout:-1 tag:0];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.delegateNetworkConnect handleConnectStatus:NetworkStatus_Connected obj:@(_serverStage) sender:self];
    });
    
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *) err
{
    _bAuthDone = NO;
    
    // Make Sure we consume all buffer data
    @synchronized(self)
    {
        _buffer = [NSMutableData new];
    }
    
    Network_Status prvState = _statusRTConnection;
    _statusRTConnection = NetworkStatus_DisConnect;
    
    
    //    dispatch_async(dispatch_get_main_queue(), ^{
    [self.delegateNetworkConnect handleConnectStatus:NetworkStatus_DisConnect
                                              obj:@[[NSString stringWithFormat:@"%d", NetworkStatus_DisConnect], ERROR_NETWORKING_DIDCONNECT, @(prvState)] sender:self];
    //    });
    
    // 沒在用的連線斷了就算了
    if (!_isUsing) {
        _bWorking = NO;
        self.nRetryTimes = 0;
        [self resetParameter];
        return;
    }
    
    // Go for retry
    if (_bWorking)
    {
        int nRetryConfig = 10;
        BOOL bEnableRetryMax = NO;
//        if (nRetryConfig > 0)
//            bEnableRetryMax = YES;
        
        if (bEnableRetryMax == NO && [_reachabilty isReachable])
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.reConnectTimer invalidate];
                self.reConnectTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(doReConnect) userInfo:nil repeats:NO];
            });
        }
        else
        {
            if (self.nRetryTimes < nRetryConfig &&  [_reachabilty isReachable])
            {
                self.nRetryTimes++;
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self.reConnectTimer invalidate];
                    self.reConnectTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(doReConnect) userInfo:nil repeats:NO];
                });
            }
            else
            {
                if (self.nRetryTimes >= nRetryConfig) {
                    _statusRTConnection = NetworkStatus_DisConnectWihtReachedMaxCount;
                }
                
                [self disconnectWithKeepRunning:NO resetHost:NO];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.delegateNetworkConnect handleConnectStatus:NetworkStatus_DisConnectWihtReachedMaxCount obj:@(_serverStage) sender:self];
                });
            }
        }
        
        
    }
    
    
    //    dispatch_async(dispatch_get_main_queue(), ^{
    //        [_delegate_networkConnect handleConnectStatus:NetworkStatus_DisConnect
    //                                                  obj:@[[NSString stringWithFormat:@"%d", NetworkStatus_DisConnect], ERROR_NETWORKING_DIDCONNECT, @(prvState)]];
    //    });
    
}

-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    if (data != nil)
    {
        @synchronized(self)
        {
            [_buffer appendBytes:data.bytes length:data.length];
            
            //            NSLog(@"PacketRcv: %@", data);
            [self analyzeAsJPacket:_buffer];
        }
        
    }
    
    [_socket readDataWithTimeout:-1 tag:0];
    
}

- (void)analyzeAsJPacket:(NSMutableData *)dataRaw
{
    
    if (dataRaw.length == 0)
        return;
    
    NSUInteger packetLength = [dataRaw length];
    uint8_t *bytes = (uint8_t *)[dataRaw bytes];
    
    Byte *currentPtr = bytes;
    
    BOOL bStillBytesToWork = NO;
    Byte *ptrPacketStart;
    Byte *ptrPacketEnd;
    int nTotalProcessLength = 0;
    do
    {
        NSMutableData *dataJPacket = [NSMutableData data];
        ptrPacketStart = currentPtr;
        if (*currentPtr != 0x02) // leading Byte
        {
            LogDebug(@"Leading byte error");
            _buffer = [NSMutableData new];  // We have error, Clear the buffer
            break;
        }
        
        currentPtr++;   // 0x02
        packetLength--;
        
        unsigned int length;
        {
            // A. Get Length (2 byte)
            {
                unsigned short v;
                memset(&v, 0, sizeof(unsigned short));
                memcpy(&v, currentPtr, sizeof(unsigned short));
                v = [FDUtility swapShortEndian:v];
                length = v;
                
                currentPtr += 2;
                packetLength -= 2;
            }
            
            // B. Get Content (length)
            NSMutableData * contentData = [NSMutableData data];
            {
                nTotalProcessLength += length + 4;  // 0x02, length(2 bytes), 0x03
                if (nTotalProcessLength > dataRaw.length || *(currentPtr + length) != 0x03) // Ending Byte
                {
                    [_buffer replaceBytesInRange:NSMakeRange(0, ptrPacketStart - bytes) withBytes:NULL length:0];
                    return;
                }
                else if (nTotalProcessLength != dataRaw.length)
                    bStillBytesToWork = YES;
                else
                {
                    bStillBytesToWork = NO;
                    
                }
                [dataJPacket appendBytes:(const void *)ptrPacketStart length:length + 4];
                ptrPacketEnd = ptrPacketStart + 4 + length - 1;
                
                [contentData appendBytes:currentPtr length:length];
                
                currentPtr += length;
            }
        }
        
        
        // E.
        [_delegate handleJPacketRawData:dataJPacket withHeader:YES];
        
        ptrPacketEnd = currentPtr;
        if (bStillBytesToWork)
        {
            currentPtr++;  // To Next Bytes (if any)
        }
        else
            _buffer = [NSMutableData new];  // We have done, Clear the buffer
        
    } while(bStillBytesToWork);
}

#pragma mark -
#pragma mark Reachability
- (void)reachabilityChanged:(NSNotification *) note
{
    Reachability *reach = [note object];
    
    if (!self.isUsing) {
        
        [self disconnectWithKeepRunning:NO resetHost:NO];
        return;
    }
    
    //    [self disconnectWithKeepRunning:NO resetHost:NO];
    
    if ([reach isReachable] == NO)
    {
        [self disconnectWithKeepRunning:NO resetHost:NO];
        return;
    }
    
    if (_socket.isDisconnected && _isUsing) {//無網路切換到有網路
        //        [self disconnectWithKeepRunning:YES resetHost:NO];
        _bWorking = YES;
        self.nRetryTimes = 0;
        [self resetParameter];
        [self socketDidDisconnect:_socket withError:nil];
        return;
    }
}


#pragma mark -
#pragma mark Error Logger
-(NSString *) errorLogger:(NSError *) error
{
    switch (error.code) {
        case GCDAsyncSocketBadConfigError:
            LogDebug(@"ErrorLogger - Invalid configuration.");
            return @"Invalid configuration.";
            break;
        case GCDAsyncSocketBadParamError:
            LogDebug(@"ErrorLogger - Invalid parameter was passed.");
            return @"Invalid parameter was passed.";
            break;
        case GCDAsyncSocketConnectTimeoutError:
            LogDebug(@"ErrorLogger - A connect operation timed out.");
            return @"A connect operation timed out.";
            break;
        case GCDAsyncSocketReadTimeoutError:
            LogDebug(@"ErrorLogger - A read operation timed out.");
            return @"A read operation timed out.";
            break;
        case GCDAsyncSocketWriteTimeoutError:
            LogDebug(@"ErrorLogger - A write operation timed out.");
            return @"A write operation timed out.";
            break;
        case GCDAsyncSocketReadMaxedOutError:
            LogDebug(@"ErrorLogger - Reached set maxLength without completing.");
            return @"Reached set maxLength without completing.";
            break;
        case GCDAsyncSocketClosedError:
            LogDebug(@"ErrorLogger - The remote peer closed the connection.");
            return @"The remote peer closed the connection.";
            break;
        case GCDAsyncSocketOtherError:
            LogDebug(@"ErrorLogger - Description provided in userInfo.");
            return @"Description provided in userInfo.";
            break;
        default:
            return @"";
            break;
    }
}

- (void)writeToFile:(id)data fileName:(NSString *)strFileName
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, strFileName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath])
        [data writeToFile:filePath atomically:YES];
    
    
    if ([[NSFileManager defaultManager] isWritableFileAtPath:filePath]) {
        LogDebug(@"Writable");
    }
    else {
        LogDebug(@"Not Writable");
    }
    
    
}
-(NSString *)description
{
    return [NSString stringWithFormat:@"Connecting to \nIP: %@\nPort: %d",self.strRTHost,self.nRTPort];
}

- (BOOL)isSocketConnected
{
    return _socket.isConnected;
}
@end
