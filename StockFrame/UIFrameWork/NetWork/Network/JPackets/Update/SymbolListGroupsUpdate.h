//
//  SymbolListGroupsUpdate.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"

@interface SymbolListGroupsUpdateCore : NSObject

@property (nonatomic, strong) NSString *grpID;
@property (nonatomic, strong) NSString *grpName;
@property (nonatomic, assign) NSInteger symCount;
@end

@interface SymbolListGroupsUpdate : JPacketReceiveBase

@property (nonatomic, strong) NSString *user;
@property (nonatomic, strong) NSString *market;
@property (nonatomic, assign) EnumSymbolListGroupType type;
@property (nonatomic, strong) NSString *txid;
@property (nonatomic, strong) NSArray *d;
@property (nonatomic, strong) NSString *err;
@property (nonatomic, strong) NSString *msg;

@end
