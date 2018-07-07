//
//  UseCoinPacket.h
//  MasterDataManager
//
//  Created by FDT14009Mac on 2015/10/1.
//  Copyright © 2015年 HKFDT. All rights reserved.
//

#import "JPacketSendBase.h"

@interface UseCoinPacket : JPacketSendBase

- (id)initWithUserID:(NSString *)user
                feautre:(EnumCoinFeature)feautre
               quantity:(NSNumber *)quantity
               auto_expand:(NSNumber *)auto_expand
                txid:(NSString *)strTXID
              market:(NSString *)market;

//@property (nonatomic, assign, readonly) NSInteger seq;
@property (nonatomic, strong, readonly) NSString *market;
@property (nonatomic, strong, readonly) NSString *txid;
@property (nonatomic, strong, readonly) NSNumber *quantity;
@property (nonatomic, strong, readonly) NSNumber *auto_expand;
@property (nonatomic, strong, readonly) NSString *user;
@property (nonatomic, assign, readonly) EnumCoinFeature feautre;

@end
