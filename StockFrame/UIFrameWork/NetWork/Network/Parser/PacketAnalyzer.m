//
//  PacketAnalyzer.m
//  MasterDataManager
//
//  Created by Rick on 2014/5/6.
//  Copyright (c) 2014年 FDT. All rights reserved.
//

#import "PacketAnalyzer.h" 
//#import "GZIP.h"
//#import "NetworkDefinition.h"

#import "FDUtility.h"

#define FIXHEADERBYTE 6

const Byte PACK_BEGIN = 0x02;
const Byte PACK_END = 0x03;
const Byte PACK_TAG = 0x00;


@implementation PacketAnalyzer

- (unsigned char)getPacketNumber
{
    static unsigned short pno = 0;
    if (pno > 0xff)
        pno = 0;
    
    return pno++;
}

// add <0x02><length><ver><p_no><packet 內容><0x03>
- (NSData *)composePack:(NSData * )content withVer:(Byte)ver
{
    NSMutableData *pack = [NSMutableData new];
    NSMutableData *pnoData = [NSMutableData new];
    NSMutableData *lengthData = [NSMutableData new];
    
    // version (1 byte)
    NSMutableData *verData = [[NSMutableData alloc] initWithBytes:&ver length:1];
    
    
    // pno (1 byte)
    {
        unsigned char packNum = [self getPacketNumber];
        [pnoData appendBytes:&packNum length:1];
    }
    
    // Length (2 bytes)
    {
        short packDataSize = [verData length] + [pnoData length] + [content length];
        short valBig = [FDUtility swapShortEndian:packDataSize];
        [lengthData appendBytes:&valBig length:2];
    }
    
    // <length><ver><p_no><packet 內容>
    [pack appendBytes:&PACK_BEGIN length:1];
    [pack appendData:lengthData];   // 2
    [pack appendData:verData];      // 1
    [pack appendData:pnoData];      // 1
    [pack appendData:content];
    [pack appendBytes:&PACK_END length:1];
    
    return pack;
    
}

@end
