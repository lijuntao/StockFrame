//
//  GetQuote.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketSendBase.h"

@interface GetQuote : JPacketSendBase

//@property (nonatomic, assign, readonly) NSInteger seq;
@property (nonatomic, strong, readonly) NSString *symbolIDs;
@property (nonatomic, strong, readonly) NSString *fields;

- (instancetype)initWithSymbolIDs:(NSString*)symbolIDs fields:(NSString*)fields;

@end
