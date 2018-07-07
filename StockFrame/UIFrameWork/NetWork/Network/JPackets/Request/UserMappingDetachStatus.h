//
//  UserMappingDetachStatus.h
//  MasterDataManager
//
//  Created by Jamison Huang on 2015/5/29.
//  Copyright (c) 2015年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"

@interface UserMappingDetachStatus : JPacketReceiveBase

@property (nonatomic, strong) NSString *err;
@property (nonatomic, strong) NSString *msg;
@end
