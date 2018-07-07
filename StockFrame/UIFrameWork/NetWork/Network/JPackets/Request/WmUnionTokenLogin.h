//
//  WmUnionTokenLogin.h
//  MasterDataManager
//
//  Created by FDT14009Mac on 2016/6/17.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "JPacketSendBase.h"

@interface WmUnionTokenLogin : JPacketSendBase
@property (nonatomic, assign, readonly) NSString *token;

- (id)initWithToken:(NSString *)token;
@end
