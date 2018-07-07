//
//  WmCancelOrder.m
//  MasterDataManager
//
//  Created by FDT14009Mac on 2016/6/17.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "WmCancelOrder.h"

@implementation WmCancelOrder

@synthesize dict = _dict;

- (id)initWithId:(NSString *)Id
            txid:(NSString *)txid{
    self = [super init];
    if (self){
        self.pt = EnumPacketPT_WmCancelOrder;
        self.seq = [JPacketSendBase getSeqIncreased];
        _Id = Id;
        _txid = txid;
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        [dict setObject:self.Id forKey:@(3)];
        [dict setObject:self.txid forKey:@(4)];
        
        _dict = (NSDictionary *)dict;
    }
    return self;
}

- (NSString *)description
{
    NSMutableString *strRet = [NSMutableString new];
    [strRet appendString:@"{\n\t"];
    [strRet appendFormat:@"pt: WmCancelOrder (%d)\n\t", EnumPacketPT_WmCancelOrder];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
    [strRet appendFormat:@"Id: %@\n\t", _Id];
    [strRet appendFormat:@"txid: %@\n\t", _txid];
    [strRet appendString:@"\n}\n"];
    
    return strRet;
}

@end
