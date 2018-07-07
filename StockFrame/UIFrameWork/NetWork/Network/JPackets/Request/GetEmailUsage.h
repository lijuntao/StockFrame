//
//  GetEmailUsage.h
//  MasterDataManager
//
//  Created by jiangnan on 15/11/24.
//  Copyright © 2015年 HKFDT. All rights reserved.
//

#import "JPacketSendBase.h"

@interface GetEmailUsage : JPacketSendBase

@property (nonatomic, copy) NSString* txid;
@property (nonatomic, copy) NSString* email;

-(instancetype)initWithTxid:(NSString *)txid email:(NSString*)email;

@end
