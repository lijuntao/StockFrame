//
//  JPacketDef.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#ifndef JPacketDef_h
#define JPacketDef_h

#define JPacket_INVALID -1
#define JPacket_SendTimeout 10

typedef NS_ENUM(NSUInteger, EnumEncryptType) {
    EnumEncryptType_RSA = 0x00,
    EnumEncryptType_AES = 0x01
};

typedef NS_ENUM(NSUInteger, EnumQuoteStale) {
    EnumQuoteStale_None = 0,
    EnumQuoteStale_Invalid = 1
};

typedef NS_ENUM(NSUInteger, EnumQuoteStatus)
{
    EnumQuoteStatus_Normal = 0,
    EnumQuoteStatus_StopWithCancel = 8,
    EnumQuoteStatus_Stop = 9,
    EnumQuoteStatus_NotReady = 99
    
};

typedef NS_ENUM(NSUInteger, EnumSymbolLanguageType) {
    EnumSymbolLanguageType_EN = 1,
    EnumSymbolLanguageType_CN = 2,
    EnumSymbolLanguageType_TW = 3
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
    EnumSearchSymbolCat_None = 0,
    EnumSearchSymbolCat_All = 1,
    EnumSearchSymbolCat_Volatile = 2,
    EnumSearchSymbolCat_Popular = 3,
    EnumSearchSymbolCat_NightTrade = 4
    
} EnumSearchSymbolCat;

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
