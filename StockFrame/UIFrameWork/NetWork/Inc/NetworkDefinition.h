//
//  NetworkDefinition.h
//  StockFrame
//
//  Created by fdt on 2018/7/4.
//  Copyright © 2018年 ljt. All rights reserved.
//

#ifndef NetworkDefinition_h
#define NetworkDefinition_h

#import "DLog.h"

#define LogDebug(format ...) do {\
NSString *message = [NSString stringWithFormat:format];\
[DLog logDebug:message];\
} while(0);

#define LogInfo(format ...) do {\
NSString *info = [NSString stringWithFormat:@"%s 方法:%s 行号:%d 信息:",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __FUNCTION__, __LINE__];\
NSString *message = [NSString stringWithFormat:format];\
NSString *debugInfo = [NSString stringWithFormat:@"%@%@",info,message];\
[DLog logInfo:debugInfo];\
} while(0);

#define ERROR_DISCONNECT                            @"You were disconnected."
#define ERROR_ALL_SERVICE_DOWN                      @"All Service Connect Fail."
#define ERROR_CANNOT_GET_SERVICE_LIST               @"Cannot Get AppSvc List."
#define ERROR_NETWORKING_DIDCONNECT                 @"Network is not available."

typedef NS_ENUM(NSInteger, ServerType)
{
    ENUM_LOGINSERVER       = 0,
    ENUM_QUOTESERVER       = 1,
    ENUM_TRADESERVER       = 2
};

typedef NS_ENUM(NSInteger, ConnectionServerStage) {
    ConnectionServerStage_ByServerLoc   = 1,
    ConnectionServerStage_ByUserID      = 2,
};


typedef enum
{
    NetworkStatus_Connecting = 6100,
    NetworkStatus_Connected = 6101,
    NetworkStatus_DisConnect = 6102,
    NetworkStatus_ConnectedWithGuestToken = 6103,
    NetworkStatus_DisConnectWihtReachedMaxCount = 6104,
    NetworkStatus_AllServiceDown = 6105,
} Network_Status;

typedef enum
{
    
    Timeout_Login = 4001,
    Timeout_SetAlert = 4002,
    Timeout_Register = 4003,
    Timeout_NotifyList = 4004,
    Timeout_NotifyUnReach = 4005,
    Timeout_OrderMatch = 4006,
    Timeout_OrderList = 4007,
    Timeout_StopLoss = 4008,
    Timeout_HistoryRec = 4009,
    NetworkIsNotReach = 4020,
    
    SystemCannotGetAppSvcList = 4021,
    SystemAllServiceConnectError = 4022,
    NetworkRetryReachMax = 4023,
    
    PopupAlert = 5000,
    PopupAttributedAlert = 5001,
    PopupToast = 5002,
    
} SysErrorStatus;


typedef NS_ENUM(NSInteger, FDTNetworkFrequency)
{
    FDTNetworkFrequencyHigh       = 0,
    FDTNetworkFrequencyNormal     = 1,
    FDTNetworkFrequencyLow        = 2
};

@protocol NetworkConnectStatusDelegate <NSObject>

-(void) handleConnectStatus:(Network_Status)status obj:(id)obj sender:(id) sender;
-(void) handleDisconnectedSender:(id) sender;
@end

#endif /* NetworkDefinition_h */
