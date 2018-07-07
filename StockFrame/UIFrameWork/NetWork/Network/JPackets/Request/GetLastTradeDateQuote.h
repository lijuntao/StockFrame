//
//  GetLastTradeDateQuote.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketSendBase.h"

@interface GetLastTradeDateQuote : JPacketSendBase

//@property (nonatomic, assign, readonly) NSInteger seq;
@property (nonatomic, strong, readonly) NSString *market;
@property (nonatomic, strong, readonly) NSString *sym;
@property (nonatomic, strong, readonly) NSString *sesname;

- (id)initWithMarket:(NSString *)strMarket symbolID:(NSString *)symbolID sesname:(NSString *)strSesname;
@end
