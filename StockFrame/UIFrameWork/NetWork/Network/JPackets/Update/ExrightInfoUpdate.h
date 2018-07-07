//
//  ExrightInfoUpdate.h
//  MasterDataManager
//
//  Created by fdt on 2017/12/26.
//  Copyright © 2017年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"

@interface ExrightInfoUpdate : JPacketReceiveBase

@property (nonatomic, strong) NSString *symbol;
@property (nonatomic, strong) NSArray *d;

@end
