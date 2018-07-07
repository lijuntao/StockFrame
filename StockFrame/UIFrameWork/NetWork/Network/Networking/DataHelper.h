//
//  DataHelper.h
//  StockFrame
//
//  Created by fdt on 2018/7/4.
//  Copyright © 2018年 ljt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkDefinition.h"
#import "Networking.h"

@class JPacketHelper;
@class DataHelper;
@class JPacketReceiveBase;
@protocol PacketDataProtocol;
@protocol NetworkConnectStatus;
@protocol NetworkConnectStatusDelegate;

@protocol ResponseDataHandler <NSObject>

- (void)handleJPacket:(nonnull JPacketReceiveBase *)packet sender:(nonnull DataHelper *) sender;
- (void)handleJPacketTimeout:(nullable JPacketSendBase *)packet sender:(nonnull DataHelper *) sender;

@end

@protocol  DataHelperServerInfoDelegate <NSObject>

-(NSString *_Nullable) dh_getServerHostSender:(DataHelper *_Nonnull ) sender;
-(NSString *_Nullable) dh_getServerPortSender:(DataHelper *_Nonnull ) sender;

@end


@interface DataHelper : NSObject<PacketDataProtocol,NetworkConnectStatusDelegate,NetworkingServerInfoDelegate> {
}

@property (nonatomic, readwrite) NSData *dataAESKey;
@property (nonatomic, nullable, readwrite) NSData *dataAES_IV;
@property (nonatomic) BOOL isUsing;
//保活相关
@property (nonatomic, strong, nullable) NSTimer *timerAlive;
@property (nonatomic, assign) int nAliveCheck;

@property (nonatomic, weak, readwrite) id<NetworkConnectStatusDelegate> delegateNetworkConnect;
@property (nonatomic, weak, readwrite) id<DataHelperServerInfoDelegate> dataHelperServerInfoDelegate;

- (id)initWithDataMgr:(id<ResponseDataHandler>)dataMgr;
// Network Connect/Disconnect
- (void)connectToRTServer:(NSString *)strRTHost onPort:(int)nPort connectionStage:(ConnectionServerStage)stage;
- (void)disConnectRTWithKeepRunning:(BOOL)bKeepRunning resetHost:(BOOL)bReset;
- (Network_Status)getNetworkStatus;
- (FDTNetworkFrequency)getNetworkFrequency;
- (BOOL)isReachableViaWWAN;
- (BOOL)isReachableViaWiFi;
- (BOOL)isSocketConnected;

- (void)doAlive;
- (void)doSuspend;
- (void)doResume;

@end
