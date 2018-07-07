//
//  SetPriceAlert.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketSendBase.h"

@interface SetPriceAlert : JPacketSendBase

//@property (nonatomic, assign, readonly) NSInteger seq;
@property (nonatomic, strong, readonly) NSString *user;
@property (nonatomic, strong, readonly) NSString *sym;
@property (nonatomic, assign, readonly) EnumSetPriceAlertType type;
@property (nonatomic, strong, readonly) NSDecimalNumber *price;
@property (nonatomic, strong, readonly) NSString *txid;
@property (nonatomic, strong, readonly) NSString *msgid;
@property (nonatomic, strong, readonly) NSDecimalNumber *upper;
@property (nonatomic, strong, readonly) NSDecimalNumber *downper;
@property (nonatomic, assign, readonly) NSInteger version;
@property (nonatomic, strong, readonly) NSString *behalf;

- (id)initWithUserID:(NSString *)strUser
            symbolID:(NSString *)strSymbolID
                type:(EnumSetPriceAlertType)type
               price:(NSDecimalNumber *)numPrice
                txid:(NSString *)strTXID
               msgid:(NSString *)strMsgID
               upper:(NSDecimalNumber *)numUpper
             downper:(NSDecimalNumber *)numDownper
             version:(NSInteger)version
              behalf:(NSString*)strBehalf
               token:(NSString *)token;
@end
