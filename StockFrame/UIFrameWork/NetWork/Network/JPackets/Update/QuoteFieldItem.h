//
//  QuoteFieldItem.h
//  MasterDataManager
//
//  Created by Rick on 2014/5/27.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JPacketDef.h"
@interface QuoteFieldItem : NSObject <NSCopying,NSCoding>

@property (nonatomic, strong) NSString *text;
@property (nonatomic, assign) BOOL valid;

- (id)initWithText:(NSString *)strText;
@end
