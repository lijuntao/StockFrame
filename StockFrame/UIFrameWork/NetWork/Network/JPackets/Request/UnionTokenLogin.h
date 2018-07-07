//
//  UnionTokenLogin.h
//  MasterDataManager
//
//  Created by FDT14009Mac on 2016/1/27.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "JPacketSendBase.h"

@interface UnionTokenLogin : JPacketSendBase

@property (nonatomic, assign, readonly) NSString *token;

- (id)initWithToken:(NSString *)token;
@end
