//
//  GetOrder.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketSendBase.h"

@interface GetOrder : JPacketSendBase

//@property (nonatomic, assign, readonly) NSInteger seq;
@property (nonatomic, strong, readonly) NSString *account;

- (id)initWithAccount:(NSString *)strAccount;
@end
