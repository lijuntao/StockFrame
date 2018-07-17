//
//  Networking.h
//  MasterDataManager
//
//  Created by Rick on 2014/5/8.
//  Copyright (c) 2014年 FDT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkDefinition.h"

@class GCDAsyncSocket;
@class Reachability;
@class PacketAnalyzer;
//@class AnalyzedData;
@class JPacketSendBase;
@class Networking;

@protocol  NetworkingServerInfoDelegate <NSObject>

-(nullable NSString *) nt_getServerHostSender:(nonnull id) sender;
-(nullable NSString *) nt_getServerPortSender:(nonnull id) sender;

@end

@protocol PacketDataProtocol

- (void)handleJPacketRawData:(nonnull NSData *)rawData withHeader:(BOOL)bHeader;

@optional
- (void)handleReachabilityChanged:(nonnull Networking*)network;

@end

@protocol NetworkConnectStatusDelegate <NSObject>

-(void) handleConnectStatus:(Network_Status)status obj:(id)obj sender:(id) sender;
-(void) handleDisconnectedSender:(id) sender;
@end

@interface Networking : NSObject
{
//    __weak id<PacketDataProtocol> _delegate;
    Reachability *_reachabilty;
    
    // Status
    BOOL _bWorking;
    BOOL _bAuthDone;
    
    // Queue
    dispatch_queue_t _delegateQueue;
    dispatch_queue_t _socketQueue;
    dispatch_queue_t _serialQueue;
    GCDAsyncSocket * _socket;
    
    // Analyzer
    PacketAnalyzer * _analyzer;
    NSMutableData *_buffer;
    
    // ReConnect
    float _fReConnectInterval;
}
@property (nonatomic, assign) int nRetryTimes;
@property (nonatomic, strong) NSTimer *reConnectTimer;
@property (nonatomic, strong, nullable) NSString *strRTHost;
@property (nonatomic, assign) int nRTPort;

@property (nonatomic, weak) id <PacketDataProtocol> delegate;
@property (nonatomic, weak) id <NetworkingServerInfoDelegate> delegateNetworkServerInfo;
@property (nonatomic, weak) id <NetworkConnectStatusDelegate> delegateNetworkConnect;

@property (nonatomic, assign) Network_Status statusRTConnection;
@property (nonatomic, assign) ConnectionServerStage serverStage;

@property (nonatomic) BOOL isUsing;;

- (id)initWithServerStage:(ConnectionServerStage)serverStage delegate:(__weak id<PacketDataProtocol>)delegate;
- (void)setRTNotifier:(NSString *)host; 
- (void)connectToRTServer:(NSString *)strRTHost onPort:(int)nPort connectionStage:(ConnectionServerStage)stage;

- (void)disconnectWithKeepRunning:(BOOL)bKeepRunning resetHost:(BOOL)bReset;
- (NSData *)sendRequest:(NSData *)request packet:(JPacketSendBase *)packet authPhrase:(BOOL)bInAuthPhrase;
- (BOOL)isConnected;
- (BOOL)isReachableViaWWAN;
- (BOOL)isReachableViaWiFi;
- (void)setAuthDone;

- (BOOL)isSocketConnected;
- (void)resetParameter;

@end
