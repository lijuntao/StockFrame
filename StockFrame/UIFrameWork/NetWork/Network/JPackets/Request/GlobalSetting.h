//
//  GlobalSetting.h
//  MasterDataManager
//
//  Created by FDT14009Mac on 2015/12/21.
//  Copyright © 2015年 HKFDT. All rights reserved.
//

#import "JPacketSendBase.h"

@interface GlobalSetting : JPacketSendBase

@property (nonatomic, strong, readonly) NSString *market;

- (id)initWithMarket:(NSString *)market;

@end
