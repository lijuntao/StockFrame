//
//  JPacketBase.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/10/3.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JPacketDef.h"
#import "JPacketPTMap.h"

@interface JPacketBase : NSObject

@property (nonatomic, assign) EnumPacketPT pt;
@property (nonatomic, assign) NSInteger seq;
@property (nonatomic, strong) id tag;

-(id) nullFilter:(id)obj;
@end
