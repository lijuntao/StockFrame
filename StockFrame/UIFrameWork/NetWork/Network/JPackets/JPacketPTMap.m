//
//  JPacketPTMap.m
//  StockFrame
//
//  Created by fdt on 2018/7/18.
//  Copyright © 2018年 ljt. All rights reserved.
//

#import "JPacketPTMap.h"
#import "JPacketDef.h"

@interface JPacketPTMap()

@property (nonatomic, strong) NSDictionary *dictReceivePacketMapping;
@property (nonatomic, strong) NSDictionary *dictSendReceiveMapping;

@end

@implementation JPacketPTMap

static JPacketPTMap *sharedInstance = nil;

+ (instancetype) sharedInstance {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (NSString *)getPacketReceiveClassName:(NSNumber *)numPT {
    return [self.dictReceivePacketMapping objectForKey:numPT];
}
- (instancetype) init {
    if (self == [super init]) {
        _dictReceivePacketMapping = @{
                                @(EnumPacketPT_ConnectChallenge):@"ConnectChallenge",
                                @(EnumPacketPT_ConnectStatus):@"ConnectStatus",
                                @(EnumPacketPT_AliveStatus):@"AliveStatus",
                                @(EnumPacketPT_DisconnectStatus):@"DisconnectStatus",
                                @(EnumPacketPT_ErrorStatus):@"ErrorStatus",
                                @(EnumPacketPT_ResumeStatus):@"ResumeStatus",
                                @(EnumPacketPT_GuestTokenUpdate):@"GuestTokenUpdate",
                                @(EnumPacketPT_SubscribeStatus):@"SubscribeStatus",
                                @(EnumPacketPT_OrderStatus):@"OrderStatus",
                                @(EnumPacketPT_MarketStatusUpdate):@"MarketStatusUpdate",
                                @(EnumPacketPT_UserStatus):@"UserStatus",
                                @(EnumPacketPT_AccountStatus):@"AccountStatus",
                                @(EnumPacketPT_AlertStatus):@"AlertStatus",
                                @(EnumPacketPT_SymbolStatus):@"SymbolStatus",
                                @(EnumPacketPT_UserMappingStatus):@"UserMappingStatus",
                                @(EnumPacketPT_UserMappingDetachStatus):@"UserMappingDetachStatus",
                                @(EnumPacketPT_UserMappingListStatus):@"UserMappingListStatus",
                                @(EnumPacketPT_QuoteUpdate):@"QuoteUpdate",
                                @(EnumPacketPT_ChartUpdate):@"ChartUpdate",
                                @(EnumPacketPT_ChartUpdate2):@"ChartUpdate2",
                                @(EnumPacketPT_OrderUpdate):@"OrderUpdate",
                                @(EnumPacketPT_ProfitUpdate):@"ProfitUpdate",
                                @(EnumPacketPT_UserUpdate):@"UserUpdate",
                                @(EnumPacketPT_ClosedPositionUpdate):@"ClosedPositionUpdate",
                                @(EnumPacketPT_AccountSettingUpdate):@"AccountSettingUpdate",
                                @(EnumPacketPT_TokenUpdate):@"TokenUpdate",
                                @(EnumPacketPT_CloseOrderUpdate):@"CloseOrderUpdate",
                                @(EnumPacketPT_ChangeUserPasswordUpdate):@"ChangeUserPasswordUpdate",
                                @(EnumPacketPT_UserChangePasswordUpdate):@"UserChangePasswordUpdate",
                                @(EnumPacketPT_LastTradeDateQuoteUpdate):@"LastTradeDateQuoteUpdate",
                                @(EnumPacketPT_LastTradeDateUpdate):@"LastTradeDateUpdate",
                                @(EnumPacketPT_TradeAlertUpdate):@"TradeAlertUpdate",
                                @(EnumPacketPT_PriceAlertUpdate):@"PriceAlertUpdate",
                                @(EnumPacketPT_SymbolListUpdate):@"SymbolListUpdate",
                                @(EnumPacketPT_SearchSymbolUpdate):@"SearchSymbolUpdate",
                                @(EnumPacketPT_TickTableUpdate):@"TickTableUpdate",
                                @(EnumPacketPT_AccountResetUpdate):@"AccountResetUpdate",
                                @(EnumPacketPT_UserMappingUpdate):@"UserMappingUpdate",
                                @(EnumPacketPT_UserMappingDetachUpdate):@"UserMappingDetachUpdate",
                                @(EnumPacketPT_UserMappingListUpdate):@"UserMappingListUpdate",
                                @(EnumPacketPT_AccountStateUpdate):@"AccountStateUpdate",
                                @(EnumPacketPT_PhoneUsageUpdate):@"PhoneUsageUpdate",
                                @(EnumPacketPT_UseCoinUpdate):@"UseCoinUpdate",
                                @(EnumPacketPT_ExrightInfoUpdate):@"ExrightInfoUpdate",
                                //待删
//                                @(EnumPacketPT_SymbolListGroupsUpdate):@"SymbolListGroupsUpdate",
//                                @(EnumPacketPT_SymbolChangedUpdate):@"SymbolChangedUpdate",
                                //new 自选
                                @(EnumPacketPT_FavoriteSymbolUpdate):@"FavoriteSymbolUpdate",

                                @(EnumPacketPT_Encrypt):@"EncryptPacket",
                                @(EnumPacketPT_MaxOrderQtyAllowUpdate):@"MaxOrderQtyAllowUpdate",
                                @(EnumPacketPT_GlobalSettingUpdate):@"GlobalSettingUpdate",
                                @(EnumPacketPT_UnionTokenUpdate):@"UnionTokenUpdate",

                                @(EnumPacketPT_WmUnionLogin):@"WmUnionLogin",
                                @(EnumPacketPT_WmUnionTokenLogin):@"WmUnionTokenLogin",
                                @(EnumPacketPT_WmEnterOder):@"WmEnterOder",
                                @(EnumPacketPT_WmAmendOrder):@"WmAmendOrder",
                                @(EnumPacketPT_WmCancelOrder):@"WmCancelOrder",
                                @(EnumPacketPT_WmCalculateOrder):@"WmCalculateOrder",
                                @(EnumPacketPT_WmCalculateOrderUpdate):@"WmCalculateOrderUpdate",
                                @(EnumPacketPT_WmGetOrder):@"WmGetOrder",
                                @(EnumPacketPT_WmGetTrade):@"WmGetTrade",
                                @(EnumPacketPT_WmGetQuoteAndRank):@"WmGetQuoteAndRank",
                                @(EnumPacketPT_WmWmGetJson):@"WmGetJson",
                                @(EnumPacketPT_GetUserPhone):@"GetUserPhone",



                                @(EnumPacketPT_WmOrderUpdate):@"WmOrderUpdate",
                                @(EnumPacketPT_WmTradeUpdate):@"WmTradeUpdate",
                                @(EnumPacketPT_WmQuoteAndRankUpdate):@"WmQuoteAndRankUpdate",
                                @(EnumPacketPT_LightWeightRankUpdate):@"LightWeightRankUpdate",
                                @(EnumPacketPT_WmExchangeRateUpdate):@"WmExchangeRateUpdate",
                                @(EnumPacketPT_SearchItemUpdate):@"SearchItemUpdate",


                                @(EnumPacketPT_WmProfitUpdate):@"WmProfitUpdate",
                                @(EnumPacketPT_WmJsonUpdate):@"WmJsonUpdate",
                                @(EnumPacketPT_UserPhoneUpdate):@"UserPhoneUpdate",

                                @(EnumPacketPT_WmExchangeOrderUpdate):@"WmExchangeOrderUpdate",

                                @(EnumPacketPT_WmWmGetOrderHistory):@"WmGetOrderHistory",
                                @(EnumPacketPT_WmWmGetOrderHistoryUpdate):@"WmGetOrderHistoryUpdate",

                                @(EnumPacketPT_WmWmGetTradeHistory):@"WmGetTradeHistory",
                                @(EnumPacketPT_WmWmGetTradeHistoryUpdate):@"WmGetTradeHistoryUpdate",

                                @(EnumPacketPT_WmSmsLogin):@"WmSmsLogin",
                                @(EnumPacketPT_WmSmsLoginUpdate):@"WmSmsLoginUpdate",
                            };
        _dictSendReceiveMapping = @{};
    };
    return self;
}
@end
