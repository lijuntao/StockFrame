//
//  WmCancelOrder.h
//  MasterDataManager
//
//  Created by FDT14009Mac on 2016/6/17.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "JPacketSendBase.h"

@interface WmCancelOrder : JPacketSendBase

//@property (nonatomic, assign, readonly) NSInteger seq;
@property (nonatomic, strong, readonly) NSString *Id;
@property (nonatomic, strong, readonly) NSString *txid;

- (id)initWithId:(NSString *)Id
            txid:(NSString *)txid;

@end
