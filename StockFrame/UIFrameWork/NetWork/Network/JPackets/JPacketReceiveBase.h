//
//  JPacketReceiveBase.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JPacketBase.h"

@interface JPacketReceiveBase : JPacketBase

- (void)fillData:(NSDictionary *)dict;
@end
