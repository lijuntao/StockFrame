//
//  UserMappingListStatus.h
//  MasterDataManager
//
//  Created by Jamison Huang on 2015/6/4.
//  Copyright (c) 2015年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"

@interface UserMappingListStatus : JPacketReceiveBase

@property (nonatomic, strong) NSString *err;
@property (nonatomic, strong) NSString *msg;
@end
