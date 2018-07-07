//
//  LookUpSymbol.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketSendBase.h"

@interface LookUpSymbol : JPacketSendBase

//@property (nonatomic, assign, readonly) NSInteger seq;
@property (nonatomic, strong, readonly) NSString *market;
@property (nonatomic, strong, readonly) NSString *txid;
@property (nonatomic, strong, readonly) NSArray *d;
@property (nonatomic, assign, readonly) EnumSymbolLanguageType qtype;

- (id)initWithSymbolIDs:(NSArray *)arrSymbolID
                 market:(NSString *)strMarket
                   txid:(NSString *)strTXID
                  qtype:(EnumSymbolLanguageType)qtype;
@end
