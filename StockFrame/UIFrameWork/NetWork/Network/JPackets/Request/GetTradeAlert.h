//
//  GetTradeAlert.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketSendBase.h" 

@interface GetTradeAlert : JPacketSendBase

//@property (nonatomic, assign, readonly) NSInteger seq;
@property (nonatomic, strong, readonly) NSString *user;
@property (nonatomic, strong, readonly) NSString *txid;

- (id)initWithUserID:(NSString *)strUser
                txid:(NSString *)strTXID;
@end
