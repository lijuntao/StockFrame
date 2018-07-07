//
//  AttachUnionId.h
//  MasterDataManager
//
//  Created by jiangnan on 15/12/29.
//  Copyright © 2015年 HKFDT. All rights reserved.
//

#import "JPacketSendBase.h"

@interface AttachUnionId : JPacketSendBase

@property (nonatomic, copy) NSString* txid;
@property (nonatomic, copy) NSString* openid;
@property (nonatomic, copy) NSString* unionid;
@property (nonatomic, copy) NSString* market;
@property (nonatomic, copy) NSString* language;

- (instancetype)initWithTxid:(NSString*)txid
                      OpenId:(NSString*)openId
                       unionId:(NSString*)unionId
                        market:(NSString*)market
                      language:(NSString*)lang;

@end
