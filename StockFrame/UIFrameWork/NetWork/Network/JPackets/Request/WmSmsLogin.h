//
//  WmSmsLogin.h
//  MasterDataManager
//
//  Created by 姚晨峰 on 2017/5/15.
//  Copyright © 2017年 HKFDT. All rights reserved.
//

#import "JPacketSendBase.h"
@interface WmSmsLogin : JPacketSendBase
//@property (nonatomic, assign) NSInteger seq;
@property (nonatomic, strong, readonly) NSString *phone;
@property (nonatomic, strong, readonly) NSString *sms_code;
@property (nonatomic, strong, readonly) NSString *country;
@property (nonatomic, strong, readonly) NSString *language;
@property (nonatomic, strong, readonly) NSString *device;
@property (nonatomic, copy, readonly) NSString * app_ver;
@property (nonatomic, assign, readonly) NSInteger client;

- (id)initWithPhone:(NSString *)phone
            sms_code:(NSString *)sms_code
             country:(NSString *)strCountry
            language:(NSString *)strLang
              device:(NSString *)device
     appver:(NSString *)appver
              client:(NSInteger) client;
@end
