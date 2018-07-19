//
//  JPacketPTMap.h
//  StockFrame
//
//  Created by fdt on 2018/7/18.
//  Copyright © 2018年 ljt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JPacketPTMap : NSObject
+ (instancetype) sharedInstance;
- (NSString *)getPacketReceiveClassName:(NSNumber *)numPT;
@end

typedef NS_ENUM(NSInteger, EnumPacketPT)
{
    EnumPacketPT_None = -1,
    // HouseKeeping
    EnumPacketPT_Connect = 1,
    EnumPacketPT_ConnectChallenge = 2,
    EnumPacketPT_ConnectResponse = 3,
    EnumPacketPT_ConnectStatus = 4,
    EnumPacketPT_Alive = 5,
    EnumPacketPT_AliveStatus = 6,
    EnumPacketPT_Disconnect = 7,
    EnumPacketPT_DisconnectStatus = 8,
    EnumPacketPT_ErrorStatus = 9,
    EnumPacketPT_Suspend = 10,
    EnumPacketPT_Resume = 11,
    EnumPacketPT_ResumeStatus = 12,
    EnumPacketPT_EnableLog = 13,
    EnumPacketPT_GuestTokenUpdate = 14,
    
    // Subscribe
    EnumPacketPT_SubscribeStatus = 101,
    EnumPacketPT_SubscribeQuote = 102,
    EnumPacketPT_SubscribeChart = 103,
    EnumPacketPT_SubscribeChart2 = 104,
    
    // Request
    EnumPacketPT_GetQuote = 201,
    EnumPacketPT_GetChart = 202,
    EnumPacketPT_GetChart2 = 250,
    EnumPacketPT_EnterOrder = 203,
    EnumPacketPT_AmendOrder = 204,
    EnumPacketPT_CancelOrder = 205,
    EnumPacketPT_OrderStatus = 206,
    EnumPacketPT_GetOrder = 207,
    EnumPacketPT_CreateUser = 208,
    EnumPacketPT_UserLogin = 209,
    EnumPacketPT_UserStatus = 210,
    EnumPacketPT_UserLogout = 211,
    EnumPacketPT_AccountSetting = 212,
    EnumPacketPT_AccountStatus = 213,
    EnumPacketPT_RefreshToken = 214,
    EnumPacketPT_CloseOrder = 215,
    EnumPacketPT_ChangeUserPassword = 216,
    EnumPacketPT_GetAccount = 217,
    EnumPacketPT_GetLastTradeDateQuote = 218,
    EnumPacketPT_GetLastTradeDate = 219,
    EnumPacketPT_GetTradeAlert = 220,
    EnumPacketPT_GetPriceAlert = 221,
    EnumPacketPT_SetPriceAlert = 222,
    EnumPacketPT_AlertStatus = 223,
    EnumPacketPT_GetSymbolList = 224,
    EnumPacketPT_SearchSymbol = 225,
    EnumPacketPT_SetSymbolList = 226,
    EnumPacketPT_SymbolStatus = 227,
    EnumPacketPT_LookupSymbol = 228,
    EnumPacketPT_UserCreateLogin = 229,
    EnumPacketPT_GetTickTable = 230,
    EnumPacketPT_AccountReset = 232,
    EnumPacketPT_GetUserMapping = 234,
    EnumPacketPT_UserMappingStatus = 235,
    EnumPacketPT_UserMappingDetach = 236,
    EnumPacketPT_UserMappingDetachStatus = 237,
    EnumPacketPT_GetUserMappingList = 238,
    EnumPacketPT_UserMappingListStatus = 239,
    EnumPacketPT_GetPhoneUsage = 240,
    EnumPacketPT_UseCoin = 241,
    //new 自选
    EnumPacketPT_GetFavoriteSymbol = 2016,
    EnumPacketPT_EditFavoriteSymbol = 2015,
    
    EnumPacketPT_GlobalSetting = 245,
    EnumPacketPT_GetMaxOrderQtyAllow  = 246,
    EnumPacketPT_GetEmailUsage = 247,
    EnumPacketPT_AttachUnionId = 248,
    EnumPacketPT_UnionTokenLogin = 249,
    EnumPacketPT_UnionCreateUser = 2001,
    EnumPacketPT_UnionLogin = 2002,
    EnumPacketPT_UnionCreateLogin = 2003,
    EnumPacketPT_RefreshUnionToken = 2005,
    
    EnumPacketPT_UserChangePassword = 2009,
    //WM Request
    EnumPacketPT_WmUnionLogin = 2006,
    EnumPacketPT_WmUnionTokenLogin = 501,
    EnumPacketPT_WmEnterOder = 502,
    EnumPacketPT_WmAmendOrder = 503,
    EnumPacketPT_WmCancelOrder = 504,
    EnumPacketPT_WmCalculateOrder = 505,
    EnumPacketPT_WmGetOrder = 506,
    EnumPacketPT_WmGetTrade = 507,
    EnumPacketPT_WmGetQuoteAndRank = 508,
    EnumPacketPT_WmWmGetJson = 509,
    /**
     *  获取历史委托
     */
    EnumPacketPT_WmWmGetOrderHistory = 511,
    /**
     * 获取异动榜单
     */
    EnumPacketPT_GetLightWeightRank = 513,
    /**
     * 涡轮牛熊筛选
     */
    EnumPacketPT_SearchItem = 523,
    /**
     *  历史委托返回包
     */
    EnumPacketPT_WmWmGetOrderHistoryUpdate = 609,
    
    /**
     *  手机验证码登录
     */
    EnumPacketPT_WmSmsLogin = 2011,
    /**
     *  手机验证码登录返回
     */
    EnumPacketPT_WmSmsLoginUpdate = 2012,
    /**
     *  获取历史成交
     */
    EnumPacketPT_WmWmGetTradeHistory = 512,
    /**
     *  历史成交
     */
    EnumPacketPT_WmWmGetTradeHistoryUpdate = 610,
    
    EnumPacketPT_GetUserPhone = 2007,
    
    
    // Update
    EnumPacketPT_MarketStatusUpdate = 301,
    EnumPacketPT_QuoteUpdate = 302,
    EnumPacketPT_ChartUpdate = 303,
    EnumPacketPT_OrderUpdate = 304,
    EnumPacketPT_ProfitUpdate = 305,
    EnumPacketPT_UserUpdate = 306,
    EnumPacketPT_ClosedPositionUpdate = 307,
    EnumPacketPT_AccountSettingUpdate = 308,
    EnumPacketPT_TokenUpdate = 309,
    EnumPacketPT_CloseOrderUpdate = 310,
    EnumPacketPT_ChangeUserPasswordUpdate = 311,
    EnumPacketPT_UserChangePasswordUpdate = 2010,
    EnumPacketPT_LastTradeDateQuoteUpdate = 312,
    EnumPacketPT_LastTradeDateUpdate = 313,
    EnumPacketPT_TradeAlertUpdate = 314,
    EnumPacketPT_PriceAlertUpdate = 315,
    EnumPacketPT_SymbolListUpdate = 316,
    EnumPacketPT_SearchSymbolUpdate = 317,
    EnumPacketPT_TickTableUpdate = 318,
    EnumPacketPT_AccountResetUpdate = 320,
    EnumPacketPT_UserMappingUpdate = 322,
    EnumPacketPT_UserMappingDetachUpdate = 323,
    EnumPacketPT_UserMappingListUpdate = 324,
    EnumPacketPT_AccountStateUpdate = 325,
    EnumPacketPT_PhoneUsageUpdate = 326,
    EnumPacketPT_UseCoinUpdate = 327,
    //待删
    //    EnumPacketPT_SymbolListGroupsUpdate = 328,
    //    EnumPacketPT_SymbolChangedUpdate = 329,
    //new 自选
    EnumPacketPT_FavoriteSymbolUpdate = 2017,
    
    
    EnumPacketPT_GlobalSettingUpdate = 330,
    EnumPacketPT_MaxOrderQtyAllowUpdate = 331,
    EnumPacketPT_AccountLevelUpdate = 334,
    EnumPacketPT_ChartUpdate2 = 335,
    EnumPacketPT_UnionTokenUpdate = 2004,
    
    EnumPacketPT_UserPhoneUpdate = 2008,
    
    //复权
    EnumPacketPT_GetExrightInfo = 519,
    EnumPacketPT_ExrightInfoUpdate = 520,
    // WM Update
    EnumPacketPT_WmOrderUpdate  = 601,
    EnumPacketPT_WmProfitUpdate   = 602,
    EnumPacketPT_WmCalculateOrderUpdate   = 603,
    EnumPacketPT_WmTradeUpdate = 604,
    EnumPacketPT_WmExchangeRateUpdate = 605,
    EnumPacketPT_WmQuoteAndRankUpdate = 606,
    EnumPacketPT_LightWeightRankUpdate = 514,
    EnumPacketPT_SearchItemUpdate = 524,
    
    EnumPacketPT_WmJsonUpdate = 607,
    EnumPacketPT_WmExchangeOrderUpdate = 608,
    //
    EnumPacketPT_Encrypt = 901,
};
