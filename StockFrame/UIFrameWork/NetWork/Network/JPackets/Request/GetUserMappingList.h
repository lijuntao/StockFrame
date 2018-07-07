//
//  GetUserMappingList.h
//  MasterDataManager
//
//  Created by Jamison Huang on 2015/6/4.
//  Copyright (c) 2015年 HKFDT. All rights reserved.
//

#import "JPacketSendBase.h"

@interface GetUserMappingList : JPacketSendBase

@property (nonatomic, strong, readonly) NSString *txid;
@property (nonatomic, strong, readonly) NSString *user;
@property (nonatomic, strong, readonly) NSString *market;
@property (nonatomic, strong, readonly) NSString *language;

- (id)initWithUserID:(NSString *)strUserID
              market:(NSString *)strMarket
            language:(NSString *)strLanguage
                txid:(NSString *)strTXID;

@end
