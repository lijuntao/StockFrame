//
//  QuoteUpdate.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"

@interface QuoteUpdate : JPacketReceiveBase

@property (nonatomic, strong) NSString *err;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, assign) NSInteger tdate;
@property (nonatomic, strong) NSDictionary *d;  // FiledID (int) -> FieldValue (string)
@property (nonatomic, assign) EnumQuoteStale stale;
@property (nonatomic, assign) EnumQuoteStatus status;

@property (nonatomic, assign) BOOL append;  // 是否在收到更新时，将此数据补至Chart数据中
 
@end
