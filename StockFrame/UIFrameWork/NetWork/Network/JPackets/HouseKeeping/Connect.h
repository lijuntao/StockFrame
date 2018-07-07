//
//  Connect.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/10/3.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketSendBase.h"

@interface Connect : JPacketSendBase

//@property (nonatomic, assign) NSInteger seq;
@property (nonatomic, strong) NSString *appid;
@property (nonatomic, strong) NSString *clientid;
@property (nonatomic, strong) NSString *ver;

- (id)initWithAppID:(NSString *)strAppID cliendID:(NSString *)strCliendID ver:(NSString *)strVer;
@end
