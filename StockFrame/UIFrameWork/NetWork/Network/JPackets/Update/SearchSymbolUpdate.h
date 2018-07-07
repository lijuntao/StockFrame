//
//  SearchSymbolUpdate.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"

@interface SearchSymbolUpdateCore : NSObject

@property (nonatomic, strong) NSString *sym;
@property (nonatomic, strong) NSString *en_name;
@property (nonatomic, strong) NSString *cn_name;
@property (nonatomic, strong) NSString *tw_name;
@property (nonatomic, strong) NSString *type_name;
@property (nonatomic, strong) NSString *st_name;
@property (nonatomic, strong) NSString *sub_name;
@property (nonatomic, strong) NSString *type_desc;
@property (nonatomic, strong) NSString *type_symbol;
@property (nonatomic, strong) NSNumber *night_trade;    // Optional, 此商品是否有夜盤，0: 無、1: 有
@property (nonatomic, strong) NSString *section;    // 商品細類別

@end

@interface SearchSymbolUpdate : JPacketReceiveBase

@property (nonatomic, strong) NSString *market;
@property (nonatomic, strong) NSString *txid;
@property (nonatomic, strong) NSString *keyword;
@property (nonatomic, assign) EnumSearchSymbolType type;
@property (nonatomic, strong) NSNumber *page;
@property (nonatomic, strong) NSNumber *sympage;
@property (nonatomic, strong) NSNumber *totalpage;
@property (nonatomic, strong) NSString *err;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSArray *d;
@property (nonatomic, assign) EnumSearchSymbolCat cat;
@property (nonatomic, strong) NSString *symbolType;
@end
