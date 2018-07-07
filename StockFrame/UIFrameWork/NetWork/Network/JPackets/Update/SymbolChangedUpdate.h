//
//  SymbolChangedUpdate.h
//  MasterDataManager
//
//  Created by Jamison Huang on 2015/9/1.
//  Copyright (c) 2015年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"

@interface SymbolChangedUpdate : JPacketReceiveBase

@property (nonatomic, strong) NSString *market;
@property (nonatomic, strong) NSString *action;

@end
