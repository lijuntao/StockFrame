//
//  SearchSymbol.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketSendBase.h"

@interface SearchSymbol : JPacketSendBase

//@property (nonatomic, assign, readonly) NSInteger seq;
@property (nonatomic, strong, readonly) NSString *user;
@property (nonatomic, assign, readonly) EnumSymbolLanguageType qtype;
@property (nonatomic, strong, readonly) NSString *market;
@property (nonatomic, strong, readonly) NSString *keyword;
@property (nonatomic, strong, readonly) NSNumber *page;
@property (nonatomic, strong, readonly) NSNumber *sympage;
@property (nonatomic, strong, readonly) NSString *txid;
@property (nonatomic, assign, readonly) EnumSearchSymbolCat category;

- (id)initWithUserID:(NSString *)strUserID
               qtype:(EnumSymbolLanguageType)qtype
              market:(NSString *)strMarket
             keyword:(NSString *)strKeyword
                page:(NSNumber *)numPage
             sympage:(NSNumber *)numPerPage
                txid:(NSString *)strTXID
            category:(EnumSearchSymbolCat)cat;
@end
