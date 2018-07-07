//
//  AttachUnionIdUpdate.h
//  MasterDataManager
//
//  Created by jiangnan on 15/12/29.
//  Copyright © 2015年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"

@interface AttachUnionIdUpdate : JPacketReceiveBase

@property (nonatomic, strong) NSString* txid;
@property (nonatomic, strong) NSString* openid;
@property (nonatomic, strong) NSString* unionid;
@property (nonatomic, strong) NSString* market;
@property (nonatomic, strong) NSString* language;
@property (nonatomic, strong) NSString* err;
@property (nonatomic, strong) NSString* msg;

@end
