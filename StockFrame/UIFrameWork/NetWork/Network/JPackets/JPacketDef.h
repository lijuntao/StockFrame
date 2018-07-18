//
//  JPacketDef.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#ifndef MasterDataManager_JPacketDef_h
#define MasterDataManager_JPacketDef_h

#define JPacket_INVALID -1
#define JPacket_SendTimeout 10
#define JPacket_INVALID_STRING @"-"

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

typedef NS_ENUM(NSUInteger, EnumEncryptType) {
    EnumEncryptType_RSA = 0x00,
    EnumEncryptType_AES = 0x01
};

//-------分割线----------

typedef enum
{
    EnumLoginType_Account = 0,
    EnumLoginType_Email = 1,
    EnumLoginType_Phone = 2,
    EnumLoginType_Token = 3,
} EnumLoginType;

typedef enum
{
    EnumOrderSide_None = 0,
    EnumOrderSide_Buy = 1,
    EnumOrderSide_Sell = 2
    
} EnumOrderSide;

typedef enum
{
    EnumOrderType_None = 0,
    EnumOrderType_Market = 1,
    EnumOrderType_Limit = 2,
    //    EnumOrderType_Stop = 3,
    //    EnumOrderType_StopLimit = 4
} EnumOrderType;

typedef enum
{
    EnumOrderStrategy_None = 0,
    EnumOrderStrategy_SDMA = 1,
    EnumOrderStrategy_STOP = 2
    
} EnumOrderStrategy;

typedef enum
{
    EnumEnterOrderReason_Normal = 0,
    EnumEnterOrderReason_Close = 1
    
} EnumEnterOrderReason;

typedef enum
{
    EnumUserRoleType_INVALID = -1,
    EnumUserRoleType_Admin = 0,
    EnumUserRoleType_Normal = 1,
    EnumUserRoleType_Support = 2,
    EnumUserRoleType_Trader = 3,
    // ---
    EnumUserRoleType_FB = 50,
    EnumUserRoleType_QQ = 51,
    EnumUserRoleType_Wechat = 52,       // wechat openid
    //    EnumUserRoleType_Twitter = 53,
    EnumUserRoleType_WXUnionId = 54,      // wechat unionid
    EnumUserRoleType_FBUnionId = 55,      // facebook unionid
    
    // ---
    EnumUserRoleType_Test = 101,
    EnumUserRoleType_GroupUser = 102,
    
    // --- for user login refactor
    EnumUserRoleType_Phone = 200,
    EnumUserRoleType_Email = 201
} EnumUserRoleType;

typedef enum
{
    EnumAccountState_Normal = 0,
    EnumAccountState_Frozen = 1,
    EnumAccountState_Terminated = 2,
    
} EnumAccountState;

typedef enum
{
    EnumTickType_Line = 1,
    EnumTickType_K = 2
    
} EnumTickType;

typedef enum
{
    EnumSymbolLanguageType_EN = 1,
    EnumSymbolLanguageType_CN = 2,
    EnumSymbolLanguageType_TW = 3
    
} EnumSymbolLanguageType;

typedef enum
{
    EnumSearchSymbolCat_None = 0,
    EnumSearchSymbolCat_All = 1,
    EnumSearchSymbolCat_Volatile = 2,
    EnumSearchSymbolCat_Popular = 3,
    EnumSearchSymbolCat_NightTrade = 4
    
} EnumSearchSymbolCat;

typedef enum
{
    EnumQuoteStale_None = 0,
    EnumQuoteStale_Invalid = 1
    
} EnumQuoteStale;


typedef enum
{
    EnumQuoteStatus_Normal = 0,
    EnumQuoteStatus_StopWithCancel = 8,
    EnumQuoteStatus_Stop = 9,
    EnumQuoteStatus_NotReady = 99
    
} EnumQuoteStatus;

typedef NS_ENUM(NSInteger, EnumWMOrderType) {
    EnumWMOrderType_Buy = 0,
    EnumWMOrderType_Sell = 1,
};

typedef NS_ENUM(NSInteger, EnumWMOrderStatus) {
    EnumWMOrderStatus_Pending = 1,
    EnumWMOrderStatus_PartialCompleted = 2,
    EnumWMOrderStatus_Completed = 3,
    EnumWMOrderStatus_Cancelled = 4,
    EnumWMOrderStatus_Inactive = 5,
    EnumWMOrderStatus_Checked = 6,
    EnumWMOrderStatus_Confirmed = 7,
    EnumWMOrderStatus_Rejected = -1,
    
    
    EnumWMOrderStatus_PendingChange = 5464,
    EnumWMOrderStatus_PendingCancel = 2121,
};

/**
 *  下單單別
 */
typedef NS_ENUM(NSInteger, EnumWMInstruct) {
    /**
     *  限價盤LO
     */
    EnumWMInstruct_Limit = 0,
    /**
     *  市價單MO (美股)
     */
    EnumWMInstruct_Market = 1,
    /**
     *  特別限價盤SLO
     */
    EnumWMInstruct_OddLot = 3,
    /**
     *  <#Description#>
     */
    EnumWMInstruct_FillAndKill = 128,
    /**
     *  競價限價盤ALO(不帶價格)
     */
    EnumWMInstruct_Auction = 512,
    EnumWMInstruct_AuctionAfterAmendOrCancel = 544,
    /**
     *  <#Description#>
     */
    EnumWMInstruct_StopLimit = 2048,
};

typedef NS_ENUM(NSInteger, EnumCoinFeature){
    EnumCoinFeature_None = -1,
    EnumCoinFeature_PositionStopLoss = 0,
    EnumCoinFeature_TrailingStop = 1,
    EnumCoinFeature_DailyStopLoss = 2,
    EnumCoinFeature_DayTradeMode = 3,
    
    EnumCoinFeature_ResetAccount = 5,
};

typedef enum
{
    EnumUserStatusType_None = 0,
    EnumUserStatusType_Create = 1,
    EnumUserStatusType_Login = 2,
    EnumUserStatusType_Logout = 3,
    EnumUserStatusType_Duplicate = 4,
    EnumUserStatusType_CreateLogin = 5
    
} EnumUserStatusType;

typedef enum
{
    EnumSearchSymbolType_Code = 0,
    EnumSearchSymbolType_EN = 1,
    EnumSearchSymbolType_CN = 2,
    EnumSearchSymbolType_TW = 3
    
} EnumSearchSymbolType;

typedef enum
{
    EnumQueryPriceAlertType_New = 1,
    EnumQueryPriceAlertType_Modify = 2,
    EnumQueryPriceAlertType_Del = 3,
    EnumQueryPriceAlertType_UnSend = 4,
    EnumQueryPriceAlertType_Send = 5
    
} EnumQueryPriceAlertType;

typedef enum
{
    EnumSymbolListGroupType_None = 0,
    EnumSymbolListGroupType_Get = 1,
    EnumSymbolListGroupType_Set = 2
    
} EnumSymbolListGroupType;

typedef enum
{
    EnumSymbolListType_None = 0,
    EnumSymbolListType_Get = 1,
    EnumSymbolListType_Set = 2,
    EnumSymbolListType_LookUp = 3,
    
} EnumSymbolListType;

typedef enum
{
    EnumSymbolListQtype_EN = 1,
    EnumSymbolListQtype_CN = 2,
    EnumSymbolListQtype_TW = 3,
    
} EnumSymbolListQtype;

typedef enum
{
    EnumOrderActionType_Update = 0,
    EnumOrderActionType_Enter = 1,
    EnumOrderActionType_Amend = 2,
    EnumOrderActionType_Cancel = 3,
    EnumOrderActionType_StopLoss = 4,
    EnumOrderActionType_GetResponse = 5
    
} EnumOrderActionType;

typedef enum
{
    EnumOrderStatus_None = -1,
    EnumOrderStatus_NEW = 0,
    EnumOrderStatus_PARTIALLY_FILLED = 1,
    EnumOrderStatus_FILLED = 2,
    EnumOrderStatus_DONE_FOR_DAY = 3,
    EnumOrderStatus_CANCELED = 4,
    EnumOrderStatus_REPLACED = 5,
    EnumOrderStatus_PENDING_CANCEL = 6,
    EnumOrderStatus_STOPPED = 7,
    EnumOrderStatus_REJECTED = 8,
    EnumOrderStatus_SUSPENDED = 9,
    EnumOrderStatus_PENDING_NEW = 10,
    EnumOrderStatus_CALCULATED = 11,
    EnumOrderStatus_EXPIRED = 12,
    EnumOrderStatus_ACCEPTED_FOR_BIDDING = 13,
    EnumOrderStatus_PENDING_REPLACE = 14
    
} EnumOrderStatus;

typedef enum
{
    EnumOrderReason_Normal = 0,
    EnumOrderReason_ManualClose = 1,
    EnumOrderReason_StopOrder = 2,
    EnumOrderReason_PositionStopLoss_3 = 3,
    EnumOrderReason_MarginCall = 4,
    EnumOrderReason_TrailingStop = 5,
    EnumOrderReason_DayEnd = 6,
    EnumOrderReason_CompanyStopLoss = 7,
    EnumOrderReason_CompanyPositionStopLoss = 8,
    EnumOrderReason_CompanyDailyStopLoss = 9,
    EnumOrderReason_AccountStopLoss = 10,
    EnumOrderReason_DailyStopLoss = 11,
    EnumOrderReason_DayTradingMode = 12,
    EnumOrderReason_PositionStopLoss_13 = 13,
    EnumOrderReason_TradingMode = 14,
    
} EnumOrderReason;
#endif
