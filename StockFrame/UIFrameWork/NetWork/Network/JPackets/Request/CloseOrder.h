//
//  CloseOrder.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketSendBase.h"

@interface CloseOrder : JPacketSendBase

//@property (nonatomic, assign, readonly) NSInteger seq;
@property (nonatomic, strong, readonly) NSString *account;
@property (nonatomic, strong, readonly) NSString *symbol;
@property (nonatomic, strong, readonly) NSString *txid;

- (id)initWithAccount:(NSString *)strAccount
             symbolID:(NSString *)strSymbolID
                 txid:(NSString *)strTXID;
@end
