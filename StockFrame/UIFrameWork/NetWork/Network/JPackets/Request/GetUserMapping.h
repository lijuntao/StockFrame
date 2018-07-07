//
//  GetUserMapping.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketSendBase.h"

@interface GetUserMapping : JPacketSendBase

//@property (nonatomic, assign, readonly) NSInteger seq;
@property (nonatomic, strong, readonly) NSString *txid;
@property (nonatomic, strong, readonly) NSString *user;
@property (nonatomic, strong, readonly) NSString *user_3rd;
@property (nonatomic, strong, readonly) NSString *market;
@property (nonatomic, strong, readonly) NSString *language;

- (id)initWithUserID:(NSString *)strUserID
             user3rd:(NSString *)str3rdUserID
              market:(NSString *)strMarket
            language:(NSString *)strLanguage
                txid:(NSString *)strTXID;
@end
