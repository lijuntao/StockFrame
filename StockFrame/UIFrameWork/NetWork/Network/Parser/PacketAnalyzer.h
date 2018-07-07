//
//  PacketAnalyzer.h
//  MasterDataManager
//
//  Created by Rick on 2014/5/6.
//  Copyright (c) 2014年 FDT. All rights reserved.
//

#import <Foundation/Foundation.h> 

@interface PacketAnalyzer : NSObject

- (NSData *)composePack:(NSData * )content withVer:(Byte)ver;


@end
