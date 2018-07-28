//
//  QuoteFieldItem.m
//  MasterDataManager
//
//  Created by Joseph on 2014/6/9.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "QuoteFieldItem.h"
#import "NetworkDefinition.h"

@implementation QuoteFieldItem

- (id)init
{
    self = [super init];
    if (self)
    {
        _text = PRICE_INVAID_DASH;
        _valid = NO;
    }
    return self;
}

- (id)initWithText:(NSString *)strText
{
    self = [self init];
    if (self)
    {
        [self setText:strText];
    }
    return self;
    
}
- (void)setText:(NSString *)text
{
    _text = text;
    
    if (!text || [text isEqualToString:PRICE_INVAID_DASH] || [text isEqualToString:PRICE_INVAID_DASH2] || [text isEqualToString:@""])
        _valid = NO;
    else
        _valid = YES;
   
}

- (id)copyWithZone:(NSZone *)zone
{
    QuoteFieldItem *item = [[[self class] allocWithZone:zone] init];
    if (item)
    {
        [item setText:[_text copy]];
        [item setValid:_valid];
    }
    
    return item;
}

-(void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.text forKey:@"text"];
    [encoder encodeBool:self.valid forKey:@"valid"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.text = [decoder decodeObjectForKey:@"text"];
        self.valid = [decoder decodeBoolForKey:@"valid"];
    }
    return self;
}

@end
