//
//  CancelOrderOrder.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketSendBase.h"
@interface CancelOrder : JPacketSendBase

//@property (nonatomic, assign, readonly) NSInteger seq;
@property (nonatomic, strong, readonly) NSString *account;
@property (nonatomic, strong, readonly) NSString *orderID;
@property (nonatomic, strong, readonly) NSString *txid;

- (id)initWithAccount:(NSString *)strAccount
              orderID:(NSString *)strOrerID
                 txid:(NSString *)strTXID;
@end
