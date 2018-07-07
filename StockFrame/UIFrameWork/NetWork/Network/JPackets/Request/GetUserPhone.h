//
//  GetUserPhone.h
//  MasterDataManager
//
//  Created by FDT14009Mac on 2016/7/21.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "JPacketSendBase.h"

@interface GetUserPhone : JPacketSendBase
//@property (nonatomic, assign) NSInteger seq;
@property (nonatomic, strong, readonly) NSString *txid;
@property (nonatomic, strong, readonly) NSString *user;

- (id)initWithTxid:(NSString *)txid
              user:(NSString *)user;
@end
