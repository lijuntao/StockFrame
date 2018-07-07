//
//  FavoriteSymbolUpdate.h
//  MasterDataManager
//
//  Created by ljt on 2017/11/7.
//  Copyright © 2017年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"

@interface FavoriteSymbolUpdateCore : NSObject

@property (nonatomic, strong) NSString *symbol;
@property (nonatomic, strong) NSArray *tags;
@end

@interface FavoriteSymbolUpdate : JPacketReceiveBase

@property (nonatomic, strong) NSString *market;
@property (nonatomic, strong) NSArray *symbols;
@property (nonatomic, strong) NSArray *tags;

@end
