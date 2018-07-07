//
//  EmailUsageUpdate.h
//  MasterDataManager
//
//  Created by jiangnan on 15/11/24.
//  Copyright © 2015年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"

@interface EmailUsageUpdate : JPacketReceiveBase

@property (nonatomic, strong) NSString *txid;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, assign) BOOL is_used;

@end
