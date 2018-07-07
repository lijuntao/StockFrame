//
//  GlobalSettingUpdate.h
//  MasterDataManager
//
//  Created by FDT14009Mac on 2015/12/21.
//  Copyright © 2015年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"

@interface GlobalSettingUpdate : JPacketReceiveBase

@property (nonatomic, strong) NSString *market;
@property (nonatomic, strong) NSDecimalNumber *initac;
@property (nonatomic, strong) NSDecimalNumber *mgntimes;
@property (nonatomic, strong) NSDecimalNumber *mgncut;
@property (nonatomic, strong) NSDecimalNumber *mgncall;
@property (nonatomic, strong) NSDecimalNumber *cdpartial;


//For default qty and min qty
@property (nonatomic, strong) NSString *appset;

@end
