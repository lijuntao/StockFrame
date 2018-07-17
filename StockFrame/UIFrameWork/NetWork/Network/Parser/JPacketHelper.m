//
//  JPacketHelper.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketHelper.h"
#import "JPacketHelper+Protocol.h"
#import "JPacketDef.h"
#import "FDUtility.h"
#import "GZIP.h"
#import "JPacketSendBase.h"
#import "JPacketReceiveBase.h"
#import "QuoteUpdate.h"
#define PRINT_MsgPackPacket_Worker 0

#define VERSION_Support_MsgPack 0x01

const static Byte MP_NULL = (Byte)0xc0;
const static Byte MP_TRUE = (Byte)0xc3;
const static Byte MP_FALSE = (Byte)0xc2;

const static Byte MP_FIXNUM = (Byte)0x00;
const static Byte MP_INT8 = (Byte)0xd0;
const static Byte MP_INT16 = (Byte)0xd1;
const static Byte MP_INT_OTHER = (Byte)0xd2;

const static Byte MP_LONG = (Byte)0xd3;
const static Byte MP_FLOAT = (Byte)0xca;
const static Byte MP_DOUBLE = (Byte)0xcb;

const static Byte MP_FIXSTR = (Byte)0xb0;
const static int MP_FIXSTR_INT = 0xb0;
const static Byte MP_STR16 = (Byte)0xd8;
const static Byte MP_STR32 = (Byte)0xd9;

const static Byte MP_FIXARRAY = (Byte)0x90;//last 4 bits is size
const static int MP_FIXARRAY_INT = 0x90;
const static Byte MP_ARRAY16 = (Byte)0xdc;
const static Byte MP_ARRAY32 = (Byte)0xdd;

const static Byte MP_FIXMAP = (Byte)0x80;//last 4 bits is size
const static int MP_FIXMAP_INT = 0x80;
const static Byte MP_MAP16 = (Byte)0xde;
const static Byte MP_MAP32 = (Byte)0xdf;

const static Byte MP_FIXRAW = (Byte)0xa0;//last 5 bits is size
const static int MP_FIXRAW_INT = 0xa0;
const static Byte MP_RAW16 = (Byte)0xda;
const static Byte MP_RAW32 = (Byte)0xdb;

@implementation JPacketHelper
- (id)init
{
    self = [super init];
    if (self)
    {
        _dictPacketMapping = @{@(EnumPacketPT_ConnectChallenge):@"ConnectChallenge",
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
//                               @(EnumPacketPT_SymbolListGroupsUpdate):@"SymbolListGroupsUpdate",
//                               @(EnumPacketPT_SymbolChangedUpdate):@"SymbolChangedUpdate",
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
        
        _handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain
                                                                          scale:10
                                                               raiseOnExactness:NO
                                                                raiseOnOverflow:NO
                                                               raiseOnUnderflow:NO
                                                            raiseOnDivideByZero:NO];
    }
    return self;
}

- (JPacketReceiveBase *)doUnPackData:(NSData *)data withHeader:(BOOL)bHeader outPacketNumber:(unsigned short *)pOutPno
{
    NSDictionary *dicContentData = nil;
    unsigned short length = 0;
    Byte ver = 0;
    Byte pno = 0;
    
    do {
        
        int pos = 0;
        Byte *byData = (Byte *)[data bytes];
        if (byData == NULL)
            break;
        
        if (bHeader)
        {
            // <0x02><length><ver><p_no><packet 內容><0x03>
            
            // Head/Tail
            if (byData[0] != 0x02 || byData[[data length] - 1] != 0x03)
                break;
            pos++;
            
            // Length (2bytes)
            memcpy(&length, &byData[pos], sizeof(short));
            length = [FDUtility swapShortEndian:length];
            pos += 2;
            
            // ver (1byte)
            ver = byData[pos];
            pos++;
        
            // pno (1byte 0 ~ 255)
            pno = byData[pos];
            pos++;
            
            // Content
            NSData *dataContent = [NSData dataWithBytes:(const void *)&byData[pos] length:[data length] - pos - 1];
            dicContentData = [self parseMsgPackContent:dataContent andVer:ver];
        }
        else
        {
            // Content
            NSData *dataContent = [NSData dataWithBytes:(const void *)&byData[pos] length:[data length]];
            dicContentData = [self parseMsgPackContent:dataContent andVer:ver];
        }
        
    } while (0);
    
    JPacketReceiveBase *base = nil;
    if (dicContentData && [dicContentData count] > 0)
        base = [self makeProtocol:dicContentData];
    
    if (bHeader)
    {
#if DEBUG
        NSLog(@"received (%d %@): %@", base.pt, [base class], dicContentData);
#endif
        *pOutPno = pno;
    }
    else
    {
#if DEBUG
        NSLog(@"received (%d %@): %@", base.pt, [base class], dicContentData);
//        NSLog(@"dicContentData: %@", dicContentData);
#endif
    }
    return base;
}

- (NSData *)doPackWithPacket:(JPacketSendBase *)packet
{
    NSMutableData *data = [NSMutableData new];
    // Append Compression Code <Always no compression>
    Byte b[1] = {0};
    [data appendBytes:b length:1];
    
    // Content Part
    [data appendData:[self makeMsgPackDataByCheckClass:packet.dict]];
    
    return data;
}





- (NSDictionary *)parseMsgPackContent:(NSData *)data andVer:(Byte)ver
{
    if (data == nil)
        return nil;
    
    NSMutableDictionary * resDictionary = [[NSMutableDictionary alloc] init];
    
    Byte *bytes = (Byte *)[data bytes];
    int nPos = 0;
    
    if (ver == VERSION_Support_MsgPack || ver == 0x00)
    {
        BOOL bIsCompression = (bytes[0] == 0x01) ? YES : NO;
        nPos++;
        
        if (bIsCompression == NO)
        {
            // Content
            Byte *bytes = (Byte *)[data bytes];
//            int nDataSize = [data length];
//            while (nPos < nDataSize)
            {
                resDictionary = [self parseMsgPackValue:bytes+nPos withPosition:&nPos];
            }
        }
        else
        {
            // Decode it
            Byte *bytes = (Byte *)[data bytes];
            NSData *dataGZip = [NSData dataWithBytes:bytes+nPos length:[data length] - 1];
            NSData *dataDecoded = [dataGZip gunzippedData];
            
            // Content
            bytes = (Byte *)[dataDecoded bytes];
//            int nDataSize = [dataDecoded length];
            nPos = 0;
//            while (nPos < nDataSize)
            {
                resDictionary = [self parseMsgPackValue:bytes+nPos withPosition:&nPos];
            }
            
        }
        
    }
    else
    {
        NSLog(@"This MsgPack Version is not support :%x", ver);
    }
    
    return resDictionary;
}

- (id)parseMsgPackValue:(Byte *)data withPosition:(int *)pos
{
    int nPos = 0;
    id retVal;
    Byte value = data[nPos];
    
    switch ((Byte)value)
    {
        case MP_NULL:
            nPos++;
            retVal = [NSNull new];
            break;
        case MP_TRUE:
            nPos++;
            retVal = @1;
            break;
        case MP_FALSE:
            nPos++;
            retVal = @0;
            break;
        case MP_INT8:   // 0 ~ 255
        {
            nPos++;
            
            short v;
            memset(&v, 0, sizeof(short));
            memcpy(&v, &data[nPos], sizeof(char));
            retVal = [NSNumber numberWithShort:v];
            nPos += sizeof(char);
        }
            break;
        case MP_INT16:
        {
            nPos++;
            
            short v;
            memcpy(&v, &data[nPos], sizeof(short));
            retVal = [NSNumber numberWithShort:[FDUtility swapShortEndian:v]];
            nPos += sizeof(short);
        }
            break;
        case MP_INT_OTHER:
        {
            nPos++;
            
            int v;
            memcpy(&v, &data[nPos], sizeof(int));
            retVal = [NSNumber numberWithInteger:[FDUtility swapIntEndian:v]];
            nPos += sizeof(int);
        }
            break;
            
        case MP_LONG:
        {
            nPos++;
            
            long long v;
            memcpy(&v, &data[nPos], sizeof(long long));
            retVal = [NSNumber numberWithLongLong:[FDUtility swapLongLongEndian:v]];
            nPos += sizeof(long long);
        }
            break;
            
        case MP_FLOAT:
        {
            nPos++;
            
            float f;
            memcpy(&f, &data[nPos], sizeof(float));
            retVal = [NSDecimalNumber numberWithFloat:[FDUtility swapFloatEndian:f]];
            nPos += sizeof(float);
        }
            break;
        case MP_DOUBLE:
        {
            nPos++;
            
            double f;
            memcpy(&f, &data[nPos], sizeof(double));
            double ff = [FDUtility swapDoubleEndian:f];
            retVal = [[NSDecimalNumber alloc] initWithDouble:ff];
            retVal = [retVal decimalNumberByRoundingAccordingToBehavior:_handler];
            nPos += sizeof(double);
        }
            break;
            
        case MP_ARRAY16:
        {
            nPos++;
            // Read Short (MP_ARRAY16)
            NSNumber *numLen = @0;
            {
                unsigned short v;
                memcpy(&v, &data[nPos], sizeof(unsigned short));
                numLen = [NSNumber numberWithShort:[FDUtility swapShortEndian:v]];
                nPos += sizeof(unsigned short);
            }
            
            retVal = [NSMutableArray new];
            for (int i = 0; i < [numLen intValue]; i++)
            {
                nPos += [self parseMsgPackArrayWithBytes:&data[nPos] ToArr:retVal];
            }
            
        }
            break;
        case MP_ARRAY32:
        {
            nPos++;
            // Read int (MP_ARRAY32)
            NSNumber *numLen = @0;
            {
                int v;
                memcpy(&v, &data[nPos], sizeof(int));
                numLen = [NSNumber numberWithInteger:[FDUtility swapIntEndian:v]];
                nPos += sizeof(int);
            }
            
            retVal = [NSMutableArray new];
            for (int i = 0; i < [numLen intValue]; i++)
            {
                nPos += [self parseMsgPackArrayWithBytes:&data[nPos] ToArr:retVal];
            }
            
        }
            break;
        case MP_MAP16:
        {
            nPos++;
            // Read Short (MP_MAP16)
            NSNumber *numLen = @0;
            {
                unsigned short v;
                memcpy(&v, &data[nPos], sizeof(unsigned short));
                numLen = [NSNumber numberWithShort:[FDUtility swapShortEndian:v]];
                nPos += sizeof(unsigned short);
            }
            
            retVal = [NSMutableDictionary new];
            for (int i = 0; i < [numLen intValue]; i++)
            {
                nPos += [self parseMsgPackDictWithBytes:&data[nPos] ToDic:retVal];
            }
            
        }
            break;
        case MP_MAP32:
        {
            nPos++;
            // Read int (MP_MAP32)
            NSNumber *numLen = @0;
            {
                int v;
                memcpy(&v, &data[nPos], sizeof(int));
                numLen = [NSNumber numberWithInteger:[FDUtility swapIntEndian:v]];
                nPos += sizeof(int);
            }
            
            retVal = [NSMutableDictionary new];
            for (int i = 0; i < [numLen intValue]; i++)
            {
                nPos += [self parseMsgPackDictWithBytes:&data[nPos] ToDic:retVal];
            }
            
        }
            break;
        case MP_RAW16:
        {
            nPos++;
            // Read Short (MP_RAW16)
            NSNumber *numLen = @0;
            {
                unsigned short v;
                memcpy(&v, &data[nPos], sizeof(unsigned short));
                numLen = [NSNumber numberWithShort:[FDUtility swapShortEndian:v]];
                nPos += sizeof(unsigned short);
            }
            
            Byte *bytes = malloc(sizeof(Byte) * [numLen intValue]);
            memcpy(bytes, &data[nPos], [numLen intValue]);
            retVal = [[NSData alloc] initWithBytes:bytes length:[numLen intValue]];
            free(bytes);
            
            nPos += [numLen intValue];
        }
            break;
        case MP_RAW32:
        {
            nPos++;
            // Read int (MP_RAW32)
            NSNumber *numLen = @0;
            {
                int v;
                memcpy(&v, &data[nPos], sizeof(int));
                numLen = [NSNumber numberWithShort:[FDUtility swapIntEndian:v]];
                nPos += sizeof(int);
            }
            
            Byte *bytes = malloc(sizeof(Byte) * [numLen intValue]);
            memcpy(bytes, &data[nPos], [numLen intValue]);
            retVal = [[NSData alloc] initWithBytes:bytes length:[numLen intValue]];
            free(bytes);
            
            nPos += [numLen intValue];
        }
            break;
        case MP_STR16:
        {
            nPos++;
            // Read Short (MP_STR16)
            NSNumber *numLen = @0;
            {
                unsigned short v;
                memcpy(&v, &data[nPos], sizeof(unsigned short));
                numLen = [NSNumber numberWithShort:[FDUtility swapShortEndian:v]];
                nPos += sizeof(unsigned short);
            }
            
            Byte *bytes = malloc(sizeof(Byte) * [numLen unsignedShortValue]);
            memcpy(bytes, &data[nPos], [numLen unsignedShortValue]);
            retVal = [[NSString alloc] initWithBytes:bytes length:[numLen unsignedShortValue] encoding:NSUTF8StringEncoding];
            free(bytes);
            
            nPos += [numLen unsignedShortValue];
        }
            break;
        case MP_STR32:
        {
            nPos++;
            // Read int (MP_STR32)
            NSNumber *numLen = @0;
            {
                int v;
                memcpy(&v, &data[nPos], sizeof(int));
                numLen = [NSNumber numberWithInteger:[FDUtility swapIntEndian:v]];
                nPos += sizeof(int);
            }
            
            Byte *bytes = malloc(sizeof(Byte) * [numLen intValue]);
            memcpy(bytes, &data[nPos], [numLen intValue]);
            retVal = [[NSString alloc] initWithBytes:bytes length:[numLen intValue] encoding:NSUTF8StringEncoding];
            free(bytes);
            
            nPos += [numLen intValue];
        }
            break;
            
            // As 0 ~ 127
        default:
        {
            // List size <= 15 (4bit)
            if (value >= MP_FIXARRAY_INT && value <= MP_FIXARRAY_INT + 15)
            {
                nPos++;
                int nLen = value - MP_FIXARRAY_INT;
                retVal = [NSMutableArray new];
                for (int i = 0; i < nLen; i++)
                {
                    nPos += [self parseMsgPackArrayWithBytes:&data[nPos] ToArr:retVal];
                }
            }
            
            // Map size <= 15 (4bit)
            else if (value >= MP_FIXMAP_INT && value <= MP_FIXMAP_INT + 15)
            {
                nPos++;
                int nLen = value - MP_FIXMAP_INT;
                
                retVal = [NSMutableDictionary new];
                for (int i = 0; i < nLen; i++)
                {
                    nPos += [self parseMsgPackDictWithBytes:&data[nPos] ToDic:retVal];
                }
            }
            
            // bytes length <= 15 (4bit)
            else if (value >= MP_FIXRAW_INT && value <= MP_FIXRAW_INT + 15)
            {
                nPos++;
                int nLen = value - MP_FIXRAW_INT;
                
                Byte *bytes = malloc(sizeof(Byte) * nLen);
                memcpy(bytes, &data[nPos], nLen);
                retVal = [[NSData alloc] initWithBytes:bytes length:nLen];
                free(bytes);
                
                nPos += nLen;
            }
            
            // String length <= 15 (4bit)
            else if (value >= MP_FIXSTR_INT && value <= MP_FIXSTR_INT + 15)
            {
                nPos++;
                int nLen = value - MP_FIXSTR_INT;
                
                Byte *str = malloc(sizeof(char) * nLen);
                memcpy(str, &data[nPos], nLen);
                retVal = [[NSString alloc] initWithBytes:str length:nLen encoding:NSUTF8StringEncoding];
                free(str);
                
                nPos += nLen;
                
            }
            // 0 <= Integer <= 127(7bit)
            else if (value <= 127 && value >= 0)
            {
                Byte b;
                memcpy(&b, &data[nPos], sizeof(Byte));
                retVal = [NSNumber numberWithInt:b];
                nPos += sizeof(Byte);
            }
            else
                NSLog(@"Input contains invalid type value");
            
        }
            break;
    }
    
    
    *pos += nPos;
    return retVal;
}

- (NSInteger)parseMsgPackDictWithBytes:(Byte *)data ToDic:(NSMutableDictionary *)dicResult
{
    int nPos = 0;
    NSNumber  *numKey;
    id  value;
    
    numKey = [self parseMsgPackValue:data+nPos withPosition:(&nPos)];
    if([numKey isKindOfClass:[NSString class]])
    {
        numKey = @([numKey intValue]);
    }
    
    value = [self parseMsgPackValue:data+nPos withPosition:(&nPos)];
    if (numKey && value)
        [dicResult setObject:value forKey:numKey];
    
    return nPos;
}

- (NSInteger)parseMsgPackArrayWithBytes:(Byte *)data ToArr:(NSMutableArray *)arrResult
{
    int nPos = 0;
    id  val;
    
    val = [self parseMsgPackValue:data+nPos withPosition:(&nPos)];
    if (val)
        [arrResult addObject:val];
    
    return nPos;
}





- (NSMutableData *)makeMsgPackDataByCheckClass:(id)value
{
    NSMutableData *data = [NSMutableData new];
    
    // C1. The Number
    if ([value isKindOfClass:[NSNumber class]])
    {
        NSData *dataValue = [self makeMsgPackNumberData:value];
        [data appendData:dataValue];
    }
    else if ([value isKindOfClass:[NSDecimalNumber class]])
    {
        NSData *dataValue = [self makeMsgPackNumberData:value];
        [data appendData:dataValue];
    }
    
    // C2. The String
    else if ([value isKindOfClass:[NSString class]])
    {
        NSData *dataValue = [self makeMsgPackStringData:value];
        [data appendData:dataValue];
    }
    
    // C3. The Byte
    else if ([value isKindOfClass:[NSData class]])
    {
        NSData *dataValue = [self makeMsgPackByteData:value];
        [data appendData:dataValue];
    }
    
    // C4. The Array
    else if ([value isKindOfClass:[NSArray class]])
    {
        NSData *dataValue = [self makeMsgPackArrayData:value];
        [data appendData:dataValue];
    }
    
    // C5. The Dictionary
    else if ([value isKindOfClass:[NSDictionary class]])
    {
        NSData *dataValue = [self makeMsgPackObjectData:value];
        [data appendData:dataValue];
    }
    
    return data;
}


- (NSData *)makeMsgPackNumberData:(id)num
{
    NSMutableData *data = [NSMutableData new];
    
    if ((strcmp([num objCType], @encode(float))) == 0)
    {
        Byte b[1] = {MP_FLOAT};
        [data appendBytes:b length:sizeof(b)];
        
        float value = [FDUtility swapFloatEndian:[num floatValue]];
        [data appendBytes:&value length:sizeof(float)];
        
    }
    else if ((strcmp([num objCType], @encode(double))) == 0)
    {
        Byte b[1] = {MP_DOUBLE};
        [data appendBytes:b length:sizeof(b)];
        
        double value = [FDUtility swapDoubleEndian:[num doubleValue]];
        [data appendBytes:&value length:sizeof(double)];
    }
    else
    {
        int value = [num intValue];
        if (value >= 0 && value <= 127)	// 0 ~ 127
        {
            Byte *bVal = malloc(sizeof(Byte));
            memset(bVal, value | MP_FIXNUM, sizeof(Byte));
            
            [data appendBytes:bVal length:sizeof(Byte)];
            free(bVal);
        }
        else if (value >= 0 && value <= 32767)	// (15bits)
        {
            Byte b[1] = {MP_INT16};
            [data appendBytes:b length:sizeof(b)];
            
            int valBig = [FDUtility swapShortEndian:value];
            [data appendBytes:&valBig length:2];
        }
        else // (32bits)
        {
            Byte b[1] = {MP_INT_OTHER};
            [data appendBytes:b length:sizeof(b)];
            
            int valBig = [FDUtility swapIntEndian:value];
            [data appendBytes:&valBig length:sizeof(int)];
        }
    }
    
#if PRINT_MsgPackPacket_Worker
    NSLog(@"makeMsgPackNumberData: %@\t%@", data, num);
#endif
    
    return data;
}

- (NSData *)makeMsgPackStringData:(NSString *)str
{
    NSMutableData *data = [NSMutableData new];
    
    NSData *dataStr = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    if (dataStr.length <= 15)
    {
        Byte b[1] = {dataStr.length | MP_FIXSTR};
        [data appendBytes:b length:sizeof(b)];
    }
    else if (dataStr.length <= 65535)
    {
        Byte b[1] = {MP_STR16};
        [data appendBytes:b length:sizeof(b)];
        
        int value = (int)dataStr.length;
        unsigned short valBig = [FDUtility swapShortEndian:value];
        [data appendBytes:&valBig length:sizeof(unsigned short)];
    }
    else
    {
        Byte b[1] = {MP_STR32};
        [data appendBytes:b length:sizeof(b)];
        
        int value = (int)dataStr.length;
        int valBig = [FDUtility swapIntEndian:value];
        [data appendBytes:&valBig length:sizeof(int)];
    }
    
    [data appendData:dataStr];
    
#if PRINT_MsgPackPacket_Worker
    NSLog(@"makeMsgPackStringData: %@\t%@", data, str);
#endif
    return data;
}

- (NSData *)makeMsgPackByteData:(NSData *)dataIn
{
    NSMutableData *data = [NSMutableData new];
    
    if (dataIn.length <= 15)
    {
        Byte b[1] = {dataIn.length | MP_FIXRAW};
        [data appendBytes:b length:sizeof(b)];
    }
    else if (dataIn.length <= 65535)
    {
        Byte b[1] = {MP_RAW16};
        [data appendBytes:b length:sizeof(b)];
        
        int value = (int)dataIn.length;
        unsigned short valBig = [FDUtility swapShortEndian:value];
        [data appendBytes:&valBig length:sizeof(unsigned short)];
    }
    else
    {
        Byte b[1] = {MP_RAW32};
        [data appendBytes:b length:sizeof(b)];
        
        int value = (int)dataIn.length;
        int valBig = [FDUtility swapIntEndian:value];
        [data appendBytes:&valBig length:sizeof(int)];
    }
    
    [data appendData:dataIn];
    
#if PRINT_MsgPackPacket_Worker
    NSLog(@"makeMsgPackByteData: %@\t%@", data, dataIn);
#endif
    return data;
}


- (NSData *)makeMsgPackArrayData:(NSArray *)arr
{
    NSMutableData *data = [NSMutableData new];
    
    if (arr.count <= 15)
    {
        Byte b[1] = {arr.count | MP_FIXARRAY};
        [data appendBytes:b length:sizeof(b)];
    }
    else if (arr.count <= 65535)
    {
        Byte b[1] = {MP_ARRAY16};
        [data appendBytes:b length:sizeof(b)];
        
        int value = (int)arr.count;
        unsigned short valBig = [FDUtility swapShortEndian:value];
        [data appendBytes:&valBig length:sizeof(unsigned short)];
    }
    else
    {
        Byte b[1] = {MP_ARRAY32};
        [data appendBytes:b length:sizeof(b)];
        
        int value = (int)arr.count;
        int valBig = [FDUtility swapIntEndian:value];
        [data appendBytes:&valBig length:sizeof(int)];
    }
    for (id value in arr)
    {
        NSData *dataContent = [self makeMsgPackDataByCheckClass:value];
        [data appendData:dataContent];
    }
    
#if PRINT_MsgPackPacket_Worker
    NSLog(@"makeMsgPackArrayData: %@\t%@", data, arr);
#endif
    return data;
}

- (NSData *)makeMsgPackObjectData:(NSDictionary *)dict
{
    NSMutableData *data = [NSMutableData new];
    
    if (dict.count <= 15)
    {
        Byte b[1] = {dict.count | MP_FIXMAP};
        [data appendBytes:b length:sizeof(b)];
    }
    else if (dict.count <= 65535)
    {
        Byte b[1] = {MP_MAP16};
        [data appendBytes:b length:sizeof(b)];
        
        int value = (int)dict.count;
        unsigned short valBig = [FDUtility swapShortEndian:value];
        [data appendBytes:&valBig length:sizeof(unsigned short)];
    }
    else
    {		
        Byte b[1] = {MP_MAP32};
        [data appendBytes:b length:sizeof(b)];
        
        int value = (int)dict.count;
        int valBig = [FDUtility swapIntEndian:value];
        [data appendBytes:&valBig length:sizeof(int)];
    }
    for (id key in dict)
    {
        [data appendData:[self makeMsgPackDataByCheckClass:key]];
        [data appendData:[self makeMsgPackDataByCheckClass:[dict objectForKey:key]]];
    }
    
#if PRINT_MsgPackPacket_Worker
    NSLog(@"makeMsgPackObjectData: %@\t%@", data, dict);
#endif
    return data;
}

@end
