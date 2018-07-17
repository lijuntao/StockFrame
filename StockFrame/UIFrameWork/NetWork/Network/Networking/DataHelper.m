//
//  DataHelper.m
//  StockFrame
//
//  Created by fdt on 2018/7/4.
//  Copyright © 2018年 ljt. All rights reserved.
//

#import "DataHelper.h"
#import "JPacketHelper.h"
#import "BDRSACryptor.h"
#import "NSData+Encrypt.h"
#import "JPacketDef.h"
#import "JPacketSendBase.h"
#import "JPacketReceiveBase.h"
//数据包
#import "Suspend.h"
#import "Resume.h"
#import "Alive.h"
#import "Connect.h"
#import "ConnectResponse.h"
#import "ConnectChallenge.h"
#import "EncryptPacket.h"


#define MAX_PACKET_NUMBER 255
@interface DataHelper ()<PacketTimeoutHandler>

@property (nonatomic, weak) id<ResponseDataHandler> delegate;
@property (nonatomic, assign) SecKeyRef thePrivateKey;
@property (nonatomic, strong) Networking *networkRT;
@property (nonatomic, strong) JPacketHelper *jPacketHelper;
@property (nonatomic, assign) dispatch_queue_t dataSerialQueue;
@property (nonatomic, strong) NSMutableDictionary *dictJPacketSeq;
@property (nonatomic, assign) unsigned short nExpectPacketNumber;
@end

@implementation DataHelper

- (dispatch_queue_t) getDataSerialQueue
{
    static dispatch_queue_t _dataQueue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dataQueue = dispatch_queue_create("DataHelper", NULL);
    });
    
    return _dataQueue;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [_networkRT disconnectWithKeepRunning:NO resetHost:YES];
    _networkRT = nil;
    
    LogDebug(@"dealloc : Data Helper");
}

-(id)initWithDataMgr:(id<ResponseDataHandler>)dataMgr {
    self = [super init];
    if (self) {
        _delegate = dataMgr;
        _networkRT = nil;
        _jPacketHelper = [JPacketHelper new];
        _dataSerialQueue = [self getDataSerialQueue];
        _nExpectPacketNumber = 0;
        _timerAlive = nil;
        _nAliveCheck = 0;
        _dictJPacketSeq = [[NSMutableDictionary alloc] initWithCapacity:5];
        [self initRSAKey];
    }
    return self;
}

-(void) initRSAKey
{
    // RSA
    // Load Private Key
    NSData *privateKey = nil;
//    NSString *prePath = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"GlobalResource/Authentication"];
//    NSString *filePath = [NSString stringWithFormat:@"%@/%@", prePath, @"private_key.pem"];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"private_key" ofType:@"pem"];
    privateKey = [NSData dataWithContentsOfFile:filePath];
    
    NSString *strPrivateKey = [[NSString alloc] initWithData:privateKey encoding:NSUTF8StringEncoding];
    BDRSACryptor *bdCryptor = [BDRSACryptor new];
    _thePrivateKey = [bdCryptor getKeyRefWithPrivateKey:strPrivateKey error:nil];
    if (_thePrivateKey == nil) {
        NSAssert(false, @"PrivateKey error");
    }
}

-(void)setIsUsing:(BOOL)isUsing
{
    _isUsing = isUsing;
    _networkRT.isUsing = isUsing;
}

- (void)connectToRTServer:(NSString *)strRTHost onPort:(int)nPort connectionStage:(ConnectionServerStage)stage
{
    
    // Disconnect the old one
    if (_networkRT != nil)
    {
        if ([_networkRT isSocketConnected]) {
            return;
        }
        
        if (![_networkRT isReachableViaWiFi] && ![_networkRT isReachableViaWWAN]) {
            return;
        }
        [_networkRT resetParameter];
    }
    if (_networkRT == nil) {
        _networkRT = [[Networking alloc] initWithServerStage:stage delegate:self];
        _networkRT.delegateNetworkConnect = self;
        _networkRT.delegateNetworkServerInfo = self;
    }
    
    [_networkRT setRTNotifier:strRTHost];
    [_networkRT connectToRTServer:strRTHost onPort:nPort connectionStage:stage];
    
}

- (void)disConnectRTWithKeepRunning:(BOOL)bKeepRunning resetHost:(BOOL)bReset
{
    [_networkRT disconnectWithKeepRunning:bKeepRunning resetHost:bReset];
}

- (void)reconnectNetwork
{
    [_networkRT disconnectWithKeepRunning:YES resetHost:NO];
}

- (Network_Status)getNetworkStatus
{
    return [_networkRT statusRTConnection];
}

- (FDTNetworkFrequency)getNetworkFrequency
{
    // wifi, always return high
    if ([_networkRT isReachableViaWiFi])
    {
        return FDTNetworkFrequencyHigh;
    }
    
   return FDTNetworkFrequencyNormal;
}
-(BOOL) isReachableViaWWAN
{
    return [_networkRT isReachableViaWWAN];
}
-(BOOL) isReachableViaWiFi
{
    return [_networkRT isReachableViaWiFi];
}

- (BOOL)isSocketConnected
{
    return [_networkRT isSocketConnected];
}

- (void)doAlive
{
    Alive *packet = [Alive new];
    NSData *data = [_jPacketHelper doPackWithPacket:packet];
    [self setPacket:packet withSeq:@(packet.seq)];
    [_networkRT sendRequest:data packet:packet authPhrase:NO];
}
- (void)doSuspend
{
    Suspend *packet = [Suspend new];
    NSData *data = [_jPacketHelper doPackWithPacket:packet];
    [_networkRT sendRequest:data packet:packet authPhrase:NO];
}

- (void)doResume
{
    Resume *packet = [Resume new];
    NSData *data = [_jPacketHelper doPackWithPacket:packet];
    [self setPacket:packet withSeq:@(packet.seq)];
    [_networkRT sendRequest:data packet:packet authPhrase:NO];
}

- (void)doAuthConnectWithClientID:(NSString *)strClientID appID:(NSString *)strAppID ver:(NSString *)strVer
{
    Connect *packet = [[Connect alloc] initWithAppID:strAppID cliendID:strClientID ver:strVer];
    [packet setHandlerTimeout:self];
    [self setPacket:packet withSeq:@(packet.seq)];
    
    NSData *data = [_jPacketHelper doPackWithPacket:packet];
    
    NSData *dataSend = [_networkRT sendRequest:data packet:packet authPhrase:YES];;
    
    if (dataSend == nil)
        [self delPacketWithSeq:@(packet.seq)];   // Remove Packet if send failed
}

- (void)doAuthConnectResponse:(JPacketReceiveBase *)base
                      country:(NSString *)strCountry
                         lang:(NSString *)strLanguage
{
    NSData *dataRandomByte = ((ConnectChallenge *)base).randomByte;
    
    FDTNetworkFrequency freq = [self getNetworkFrequency];
    
    ConnectResponse *packet = [[ConnectResponse alloc] initWithRandomBytes:dataRandomByte
                                                                  snapshot:@(freq)
                                                                   country:strCountry
                                                                      lang:strLanguage];
    [packet setHandlerTimeout:self];
    
    NSData *data = [_jPacketHelper doPackWithPacket:packet];
    
    if (_thePrivateKey == nil) {
        NSAssert(NO, @"PrivateKey error");
    }
    
    NSData *dataEncrypt = [data RSA_PKCS1Padding_SignWithPrivateKeyRef:_thePrivateKey];
    
    EncryptPacket *packetEncrypt = [[EncryptPacket alloc] initWithType:EnumEncryptType_RSA
                                                         dataEncrypted:dataEncrypt
                                                        originalPacket:packet];
    NSData *dataSend = [_jPacketHelper doPackWithPacket:(JPacketSendBase *)packetEncrypt];
    [self setPacket:packet withSeq:@(packet.seq)];
    [_networkRT sendRequest:dataSend packet:(JPacketSendBase *)packetEncrypt authPhrase:YES];
}

- (void)handleAuthConnectDone
{
    // Set AuthDone to NetworkSvc, to allow ref packets
    [_networkRT setAuthDone];
}

- (void)handleEncryptPacket:(JPacketBase *)base {
    EncryptPacket *packet = (EncryptPacket *)base;
    if (packet.type == EnumEncryptType_AES)
    {
        // TODO:
        NSData *data = [packet.encryptedData AES128_CBC_NoPadding_DecryptWithKey:self.dataAES_IV IV:self.dataAES_IV];
        
        [self handleJPacketRawData:data withHeader:NO];
    }
    else if (packet.type == EnumEncryptType_RSA)
    {
        // TODO:
        NSData *data = [packet.encryptedData RSA_PKCS1Padding_DecryptWithPrivateKeyRef:[self getPrivateKey]];
        
        [self handleJPacketRawData:data withHeader:NO];
    }
}

- (JPacketReceiveBase *)unpackEncryptPacket:(JPacketBase *)base
{
    EncryptPacket *packet = (EncryptPacket *)base;
    
    NSData *data;
    
    if (packet.type == EnumEncryptType_AES)
    {
        data = [packet.encryptedData AES128_CBC_NoPadding_DecryptWithKey:self.dataAES_IV IV:self.dataAES_IV];
    }
    else if (packet.type == EnumEncryptType_RSA)
    {
        data = [packet.encryptedData RSA_PKCS1Padding_DecryptWithPrivateKeyRef:_thePrivateKey];
        
    }
    return [self getJPacketRawData:data withHeader:NO];
}
#pragma mark PacketTimeoutHandler
- (void)handleJPacketTimeout:(NSTimer *)timer {
    JPacketSendBase *base = timer.userInfo;
    if (base == nil)
        return;
    
    [self delPacketWithSeq:@(base.seq)];
    @WeakObj(self);
    dispatch_async(_dataSerialQueue, ^{
        @StrongObj(self);
        [self.delegate handleJPacketTimeout:base sender:self];
    });
}

#pragma mark NetworkConnectStatusDelegate

- (void)handleConnectStatus:(Network_Status)status obj:(id)obj sender:(id)sender {
    [self.delegateDataHelperConnect handleConnectStatus:status obj:obj sender:self];
}

- (void)handleDisconnectedSender:(id)sender {
    [self.delegateDataHelperConnect handleDisconnectedSender:self];
}


#pragma mark PacketDataProtocol
- (void)handleJPacketRawData:(NSData *)rawData withHeader:(BOOL)bHeader
{
    unsigned short pno = 0;
    JPacketReceiveBase *base = [_jPacketHelper doUnPackData:rawData withHeader:bHeader outPacketNumber:&pno];
    if (base == nil) {
        LogDebug(@"解析失败");
        return;
    }
    // Check Packet Number Skip
    if (bHeader)
    {
        if (_nExpectPacketNumber != pno)
        {
            LogDebug(@"Packet Number Skipped!");
        }
        if (pno == MAX_PACKET_NUMBER)
            _nExpectPacketNumber = 0;
        else
            _nExpectPacketNumber = pno + 1;
    }
    
    // A. Get Teg
    id tag = [self getPacketTagWithSeq:@(base.seq)];
    [base setTag:tag];
    
    // B. Check Seq
    [self delPacketWithSeq:@(base.seq) receivePT:base.pt];
    
    // C. Dispatch to each handler
    dispatch_async(_dataSerialQueue, ^{
        if (self.delegate != nil) {
            [self.delegate handleJPacket:base sender:self];
        }
    });
}

- (JPacketReceiveBase *)getJPacketRawData:(NSData *)rawData withHeader:(BOOL)bHeader
{
    unsigned short pno = 0;
    JPacketReceiveBase *base = [_jPacketHelper doUnPackData:rawData withHeader:bHeader outPacketNumber:&pno];
    if (base == nil)
        return base;
    
    // Check Packet Number Skip
    if (bHeader)
    {
        if (_nExpectPacketNumber != pno)
        {
            NSLog(@"Packet Number Skipped!");
            //            assert(0);
        }
        if (pno == MAX_PACKET_NUMBER)
            _nExpectPacketNumber = 0;
        else
            _nExpectPacketNumber = pno + 1;
    }
    
    // A. Get Teg
    id tag = [self getPacketTagWithSeq:@(base.seq)];
    [base setTag:tag];
    
    // B. Check Seq
    [self delPacketWithSeq:@(base.seq) receivePT:base.pt];
    
    return base;
}
- (void)setPacket:(JPacketSendBase *)packet withSeq:(NSNumber *)numSeq
{
    @synchronized(_dictJPacketSeq)
    {
        if (packet && numSeq && [numSeq intValue] != JPacket_INVALID)
            [_dictJPacketSeq setObject:packet forKey:numSeq];
    }
}

- (JPacketSendBase *)getPacketTagWithSeq:(NSNumber *)numSeq
{
    @synchronized(_dictJPacketSeq)
    {
        if (numSeq)
        {
            JPacketSendBase *packet = [_dictJPacketSeq objectForKey:numSeq];
            return [packet.tag copy];
        }
    }
    return nil;
}

- (void)delPacketWithSeq:(NSNumber *)numSeq receivePT:(EnumPacketPT)receivePT
{
    @synchronized(_dictJPacketSeq)
    {
        if (numSeq && [numSeq intValue] >= 0)
        {
            JPacketSendBase *packet = [_dictJPacketSeq objectForKey:numSeq];
            if (packet) {
                if (packet.waitingPacket == EnumPacketPT_None || packet.waitingPacket == receivePT) {
                    [packet stopSendoutTimer];
                    [_dictJPacketSeq removeObjectForKey:numSeq];
                }
            }
            
        }
        else
        {
            //numSeq == -1, means it's a update packet
            if (_dictJPacketSeq.allKeys.count > 0) {
                for (id key in _dictJPacketSeq.allKeys) {
                    JPacketSendBase *packet = [_dictJPacketSeq objectForKey:key];
                    if (packet.waitingPacket == receivePT) {
                        [packet stopSendoutTimer];
                        [_dictJPacketSeq removeObjectForKey:key];
                        break;
                    }
                }
            }
        }
    }
}

- (void)delPacketWithSeq:(NSNumber *)numSeq
{
    @synchronized(_dictJPacketSeq)
    {
        if (numSeq && [numSeq intValue] >= 0)
        {
            JPacketSendBase *packet = [_dictJPacketSeq objectForKey:numSeq];
            [packet stopSendoutTimer];
            [_dictJPacketSeq removeObjectForKey:numSeq];
        }
    }
}

- (void)clearPacketQueueWithTriggerTimeout:(BOOL)bTriggerTimeout
{
    @synchronized(_dictJPacketSeq)
    {
        for (NSNumber *numKey in [_dictJPacketSeq allKeys])
        {
            if (bTriggerTimeout)
            {
                JPacketSendBase *packet = [_dictJPacketSeq objectForKey:numKey];
                dispatch_async(_dataSerialQueue, ^{
                    [self.delegate handleJPacketTimeout:packet sender:self];
                });
            }
            [self delPacketWithSeq:numKey];
        }
    }
}

-(SecKeyRef)getPrivateKey
{
    return _thePrivateKey;
}

#pragma mark NetworkingServerInfoDelegate
- (nullable NSString *)nt_getServerHostSender:(nonnull id)sender {
    return [self.dataHelperServerInfoDelegate dh_getServerHostSender:self];
}

- (nullable NSString *)nt_getServerPortSender:(nonnull id)sender {
    return [self.dataHelperServerInfoDelegate dh_getServerPortSender:self];
}

@end
