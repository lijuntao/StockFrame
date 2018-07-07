//
//  GetExrightInfo.h
//  MasterDataManager
//
//  Created by fdt on 2017/12/26.
//  Copyright © 2017年 HKFDT. All rights reserved.
//

#import "JPacketSendBase.h"

@interface GetExrightInfo : JPacketSendBase

@property (nonatomic, strong) NSString *symbol;

-(instancetype)initWithSymbol:(NSString *)symbol;

@end
