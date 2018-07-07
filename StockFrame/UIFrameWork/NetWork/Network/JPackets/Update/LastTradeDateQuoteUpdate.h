//
//  LastTradeDateQuoteUpdate.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"

@interface LastTradeDateQuoteUpdateCore : NSObject

@property (nonatomic, strong) NSString *trddate;
@property (nonatomic, strong) NSString *symbol;
@property (nonatomic, strong) NSDecimalNumber *lprc;

@end

@interface LastTradeDateQuoteUpdate : JPacketReceiveBase

@property (nonatomic, strong) NSString *market; 
@property (nonatomic, strong) NSArray *d;
@property (nonatomic, strong) NSString *err;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSString *sesname;

@end
