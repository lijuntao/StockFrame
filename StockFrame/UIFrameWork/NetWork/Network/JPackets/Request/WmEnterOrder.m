//
//  WmEnterOder.m
//  MasterDataManager
//
//  Created by FDT14009Mac on 2016/6/17.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "WmEnterOrder.h"

@implementation WmEnterOrder
@synthesize dict = _dict;

- (id)initWithSymbolId:(NSString *)strSymbolId
                 otype:(EnumWMOrderType)order_type
                 price:(NSDecimalNumber *)numPrice
                   qty:(NSDecimalNumber *)numQty
                  txid:(NSString *)strTxid
              instruct:(EnumWMInstruct)instruct
         instruct_prc1:(NSDecimalNumber*)instruct_prc1{
    self = [super init];
    if (self) {
        self.pt = EnumPacketPT_WmEnterOder;
        self.seq = [JPacketSendBase getSeqIncreased];
        _sym = strSymbolId;
        _order_type = order_type;
        _price = numPrice;
        _qty = numQty;
        _txid = strTxid;
        _instruct = instruct;
        _instruct_prc1 = instruct_prc1;
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        [dict setObject:self.txid forKey:@(3)];
        [dict setObject:self.sym forKey:@(4)];
        [dict setObject:@(self.order_type) forKey:@(5)];
        [dict setObject:self.price forKey:@(6)];
        [dict setObject:self.qty forKey:@(7)];
        [dict setObject:[NSString stringWithFormat:@"%d",(int)self.instruct] forKey:@(8)];
        if (instruct_prc1) {
            [dict setObject:self.instruct_prc1 forKey:@(9)];
        }

        _dict = (NSDictionary *)dict;


    }
    return self;
}


- (NSString *)description
{
    NSMutableString *strRet = [NSMutableString new];
    [strRet appendString:@"{\n\t"];
    [strRet appendFormat:@"pt: WmEnterOrder (%d)\n\t", EnumPacketPT_WmEnterOder];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
    [strRet appendFormat:@"txid: %@\n\t", _txid];
    [strRet appendFormat:@"sym: %@\n\t", _sym];
    [strRet appendFormat:@"order_type: %ld\n\t", (long)_order_type];
    [strRet appendFormat:@"price: %@\n\t", _price];
    [strRet appendFormat:@"qty: %@\n\t", _qty];
    [strRet appendFormat:@"instruct: %ld\n\t", (long)_instruct];
    if (self.instruct_prc1) {
        [strRet appendFormat:@"instruct: %@\n\t", _instruct_prc1];
    }
    [strRet appendString:@"\n}\n"];
    return strRet;
}

@end
