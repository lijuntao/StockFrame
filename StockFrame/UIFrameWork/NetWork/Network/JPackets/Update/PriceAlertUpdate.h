//
//  PriceAlertUpdate.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"

@interface PriceAlertUpdateCore : NSObject

@property (nonatomic, strong) NSString *msgid;
@property (nonatomic, strong) NSString *datetime;
@property (nonatomic, strong) NSString *user;
@property (nonatomic, strong) NSString *sym;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) NSInteger type;
@end

@interface PriceAlertUpdate : JPacketReceiveBase

@property (nonatomic, strong) NSString *txid;
@property (nonatomic, strong) NSString *user;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSArray *d;
@property (nonatomic, strong) NSString *errMsgid;
@property (nonatomic, strong) NSString *err;
@property (nonatomic, strong) NSString *msg;

@end
