////
////  DataManager.h
////  StockFrame
////
////  Created by fdt on 2018/7/4.
////  Copyright © 2018年 ljt. All rights reserved.
////
//
//#import <Foundation/Foundation.h>
//#import "NetworkDefinition.h"
//#import "DataHelper.h"
//
//@class JPacketReceiveBase;
//@class JPacketSendBase;
//
//
//@protocol ResponseDataHandler <NSObject>
//
//- (void)handleJPacket:(JPacketReceiveBase *)packet sender:(id) sender;
//- (void)handleJPacketTimeout:( JPacketSendBase *)packet sender:(id) sender;
//
//@end
//
//@protocol DataManagerDelegate <NSObject>
//
//- (NSString *)getServerHost;
//- (NSString *)getServerPort;
//- (NSString *)getQuoteServerHost;
//- (NSString *)getQuoteServerPort;
//
//@end
//
//@interface DataManager1 : NSObject<ResponseDataHandler, NetworkConnectStatusDelegate, DataHelperServerInfoDelegate>
//
//@property (nonatomic,weak) id<DataManagerDelegate> delegate;
//- (Network_Status)getNetworkStatus;
//- (FDTNetworkFrequency)getNetworkFrequency;
//- (BOOL)isReachableViaWWAN;
//- (BOOL)isReachableViaWiFi;
//- (BOOL)isNetworkAvailable;
//
//- (DataHelper *)getDataHelper;
//- (DataHelper *)getQuoteDataHelper;
//@end
