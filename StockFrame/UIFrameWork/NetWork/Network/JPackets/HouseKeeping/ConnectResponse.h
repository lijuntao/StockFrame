//
//  ConnectResponse.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/10/3.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketSendBase.h"

@interface ConnectResponse : JPacketSendBase

//@property (nonatomic, assign) NSInteger seq;
@property (nonatomic, strong) NSData *randomByte;
@property (nonatomic, assign) NSInteger snapshot;
@property (nonatomic, assign) NSInteger log;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *lang;

- (id)initWithRandomBytes:(NSData *)dataRandomByte
                 snapshot:(NSNumber *)numSnapShot
                  country:(NSString *)strCountry
                     lang:(NSString *)strLanguage;
@end
