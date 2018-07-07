//
//  GetFavoriteSymbol.h
//  MasterDataManager
//
//  Created by ljt on 2017/11/7.
//  Copyright © 2017年 HKFDT. All rights reserved.
//

#import "JPacketSendBase.h"

@interface GetFavoriteSymbol : JPacketSendBase

- (id)initWithMarket:(NSString *)market;
@end
