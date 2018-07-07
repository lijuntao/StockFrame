//
//  GetPriceAlert.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketSendBase.h"

@interface GetPriceAlert : JPacketSendBase

//@property (nonatomic, assign, readonly) NSInteger seq;
@property (nonatomic, strong, readonly) NSString *user;
@property (nonatomic, assign, readonly) EnumQueryPriceAlertType type;
@property (nonatomic, strong, readonly) NSString *txid;

- (id)initWithUserID:(NSString *)strUser
                type:(EnumQueryPriceAlertType)type
                txid:(NSString *)strTXID
               token:(NSString *)token;
@end
