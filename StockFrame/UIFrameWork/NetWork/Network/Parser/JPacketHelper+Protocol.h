//
//  JPacketHelper+Protocol.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import <Foundation/Foundation.h> 

@class JPacketReceiveBase;

@interface JPacketHelper (Protocol)

- (JPacketReceiveBase *)makeProtocol:(NSDictionary *)dictData;
@end
