//
//  EncryptPacket.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/10/3.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketBase.h"

@class JPacketSendBase;
@interface EncryptPacket : JPacketBase

//@property (nonatomic, assign) NSInteger seq;
@property (nonatomic, assign) EnumEncryptType type;
@property (nonatomic, strong) NSData *encryptedData;
@property (nonatomic, strong, readonly) NSDictionary *dict;
@property (nonatomic, weak, readonly) JPacketSendBase *oriPacket;

- (id)initWithType:(EnumEncryptType)type dataEncrypted:(NSData *)dataEncrypted originalPacket:(JPacketSendBase *)oriPacket;
- (void)startSendoutTimer;
- (void)stopSendoutTimer;

- (void)fillData:(NSDictionary *)dict;
@end
