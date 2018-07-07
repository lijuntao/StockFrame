//
//  SubscribeQuote.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketSendBase.h"

@interface SubscribeQuote : JPacketSendBase

//@property (nonatomic, assign, readonly) NSInteger seq;
@property (nonatomic, strong, readonly) NSArray *refSymbolIDs;
@property (nonatomic, strong, readonly) NSArray *unrefSymbolIDs;
@property (nonatomic, assign, readonly) BOOL clearAll;
@property (nonatomic, assign, readonly) NSInteger FS;
@property (nonatomic, assign, readonly) NSInteger ch;

- (id)initWithRefSymbolIDs:(NSArray *)arrRefSymbolID
            unrefSymbolIDs:(NSArray *)arrUnrefSymbolID
                  clearAll:(BOOL)bClearAll
                        fs:(NSInteger)nFS
                        ch:(NSInteger)nCH;
@end
