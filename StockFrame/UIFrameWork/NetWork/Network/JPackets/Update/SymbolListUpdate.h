//
//  SymbolListUpdate.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"

@interface SymbolListUpdateCore : NSObject

@property (nonatomic, strong) NSString *sym;
@property (nonatomic, strong) NSString *en_name;
@property (nonatomic, strong) NSString *cn_name;
@property (nonatomic, strong) NSString *tw_name;
@property (nonatomic, strong) NSString *st_name;
@property (nonatomic, strong) NSString *type_name;
@property (nonatomic, strong) NSString *sub_name;
@property (nonatomic, strong) NSString *ticktable;  // ticktable key name (refer to TickTableUpdate)
@property (nonatomic, strong) NSNumber *lotsz;      // lot size
@property (nonatomic, strong) NSNumber *decimal;    // decimal point
@property (nonatomic, strong) NSDecimalNumber *ppu; // Price Per Unit
@property (nonatomic, strong) NSString *tunit;      // Trading Unit(依qtype決定內容, 目前支援CN, TW, 其餘都回覆EN）
@property (nonatomic, strong) NSNumber *maxlot;     // Optional, maximum lots for limit order (單筆最大可下單數量 -> limit單專用）
@property (nonatomic, strong) NSNumber *maxMlot;     // Optional, maximum lots for market order (單筆最大可下單數量 -> market單專用）
@property (nonatomic, strong) NSNumber *maxhold;    // maximum hold(最大可持倉數量）
@property (nonatomic, strong) NSDecimalNumber *cmsn; // commission rate
@property (nonatomic, strong) NSDecimalNumber *mrate; // margin rate
@property (nonatomic, strong) NSNumber *tradable;    // 可否交易
@property (nonatomic, strong) NSString *sesname;    // 所屬的Session
@property (nonatomic, strong) NSString *symtype;    // Symbol類別
@property (nonatomic, strong) NSString *section;    // 商品細類別
@property (nonatomic, strong) NSNumber *night_trade;    // Optional, 此商品是否有夜盤，0: 無、1: 有
@property (nonatomic, strong) NSNumber *shortsell;  // Optional,此商品可否賣空，0: 不可、1: 可



@end

@interface SymbolListUpdate : JPacketReceiveBase

@property (nonatomic, strong) NSString *user;
@property (nonatomic, strong) NSString *market;
@property (nonatomic, strong) NSString *group;
@property (nonatomic, assign) EnumSymbolListType type;
@property (nonatomic, strong) NSString *txid;
@property (nonatomic, strong) NSString *err;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSArray *d;
@property (nonatomic, assign) EnumSymbolListQtype qtype;

@end
