////
////  DataManager.m
////  StockFrame
////
////  Created by fdt on 2018/7/4.
////  Copyright © 2018年 ljt. All rights reserved.
////
//
//#import "DataManager1.h"
//#import "NSString+FDT.h"
//
//@interface DataManager1 ()
//@property (nonatomic, strong) DataHelper *dataHelper;
//@property (nonatomic, strong) DataHelper *quoteDataHelper;
//
//@property(nonatomic, strong) NSMutableDictionary *rightDic;
//@end
//
//@implementation DataManager1
//
//#pragma mark life circel
//- (void)dealloc
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}
//
//-(instancetype)init {
//    self = [super init];
//    if (self) {
//        [self initDataManager];
//    }
//    return self;
//}
//
//- (void)initDataManager
//{
//    // Managers // TODO: integrate?
//    _dataHelper = [[DataHelper alloc] initWithDataMgr:self];
//    _dataHelper.delegate_networkConnect = self;
//    _dataHelper.dataHelperServerInfoDelegate = self;
//    // Authentication
//    _dataHelper.dataAES_IV = [@"8765432112345678" dataUsingEncoding:NSUTF8StringEncoding];
//    
//    _quoteDataHelper = [[DataHelper alloc] initWithDataMgr:self];
//    _quoteDataHelper.delegate_networkConnect = self;
//    _quoteDataHelper.dataHelperServerInfoDelegate = self;
//    _quoteDataHelper.dataAES_IV = [@"8765432112345678" dataUsingEncoding:NSUTF8StringEncoding];
//    
////    [self initLocalCacheHandler];
//}
//
//- (void)doConnect
//{
//    NSString *ip = [self.delegate getServerHost];
//    int port = [[self.delegate getServerPort] intValue];
//    if (![NSString isNilOrEmpty:ip] && port > 0) {
//        [self.dataHelper connectToRTServer:ip onPort:port connectionStage:ConnectionServerStage_ByServerLoc];
//    }
//    
//    ip = [self.delegate getQuoteServerHost];
//    port = [[self.delegate getQuoteServerPort] intValue];
//    if (![NSString isNilOrEmpty:ip] && port > 0) {
//        [self.quoteDataHelper connectToRTServer:ip onPort:port connectionStage:ConnectionServerStage_ByServerLoc];
//    }
//}
//
//- (void)doDisconnect{
//    [self.dataHelper disConnectRTWithKeepRunning:false resetHost:true];
//    [self.quoteDataHelper disConnectRTWithKeepRunning:false resetHost:true];
//}
//
//- (Network_Status)getNetworkStatus
//{
//    return [_dataHelper getNetworkStatus];
//}
//
//-(BOOL) isReachableViaWWAN
//{
//    return [_dataHelper isReachableViaWWAN];
//}
//
//-(BOOL) isReachableViaWiFi
//{
//    return [_dataHelper isReachableViaWiFi];
//}
//
//-(BOOL) isNetworkAvailable
//{
//    return [self isReachableViaWWAN] || [self isReachableViaWiFi];
//}
//
//- (FDTNetworkFrequency)getNetworkFrequency {
//    return [_dataHelper getNetworkFrequency];
//}
//
//-(DataHelper *)getDataHelper
//{
//    if (self.dataHelper != nil)
//    {
//        return self.dataHelper;
//    }
//    return self.dataHelper;
//}
//
//- (DataHelper *)getQuoteDataHelper
//{
//    if (self.quoteDataHelper != nil)
//    {
//        return self.quoteDataHelper;
//    }
//    return self.dataHelper;
//}
//
//#pragma mark ResponseDataHandler
//- (void)handleJPacket:(JPacketReceiveBase *)packet sender:(id)sender {
////    [self handleJPacket_Cat:packet sender:sender];
//}
//
//- (void)handleJPacketTimeout:(JPacketSendBase *)packet sender:(id)sender {
////    [self handleJPacketTimeout_Cat:packet sender:sender];
//}
//@end
