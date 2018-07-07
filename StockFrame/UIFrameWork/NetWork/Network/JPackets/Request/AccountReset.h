//
//  AccountReset.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketSendBase.h"

@interface AccountReset : JPacketSendBase

//@property (nonatomic, assign, readonly) NSInteger seq;
@property (nonatomic, strong, readonly) NSString *txid;
@property (nonatomic, strong, readonly) NSString *userid;
@property (nonatomic, strong, readonly) NSString *account;
@property (nonatomic, strong, readonly) NSString *market;
@property (nonatomic, strong, readonly) NSString *coinid;

- (id)initWithUserID:(NSString *)strUserID
             account:(NSString *)strAccount
              market:(NSString *)strMarket
              coinid:(NSString *)strCoinID
                txid:(NSString *)strTXID;
@end
