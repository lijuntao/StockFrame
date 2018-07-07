//
//  UserChangePassword.m
//  MasterDataManager
//
//  Created by 姚晨峰 on 16/8/29.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "UserChangePassword.h"

@implementation UserChangePassword
@synthesize dict = _dict;

- (id)initWithUserID:(NSString *)phone
              oriPwd:(NSString *)strOriPwd
              newPwd:(NSString *)strNewPwd
            verified:(BOOL)isVerified
{
    self = [super init];
    if (self)
    {
        self.pt = EnumPacketPT_UserChangePassword;
        self.seq = [JPacketSendBase getSeqIncreased];
        _phone = phone;
        _orgpwd = strOriPwd;
        _pwd = strNewPwd;
        _isVerified = isVerified;
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        
        [dict setObject:phone forKey:@(3)];
        if (strOriPwd)
        {
            [dict setObject:strOriPwd forKey:@(4)];
        }
        [dict setObject:strNewPwd forKey:@(5)];
        if (isVerified == true) {
            [dict setObject:@(isVerified) forKey:@(6)];
        }
        
        _dict = (NSDictionary *)dict;
    }
    return self;
}

- (NSString *)description
{
    NSMutableString *strRet = [NSMutableString new];
    [strRet appendString:@"{\n\t"];
    [strRet appendFormat:@"pt: ChangeUserPassword (%d)\n\t", EnumPacketPT_UserChangePassword];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
    
    [strRet appendFormat:@"user: %@\n\t", _phone];
    [strRet appendFormat:@"orgpwd: %@\n\t", _orgpwd];
    [strRet appendFormat:@"pwd: %@\n\t", _pwd];
    [strRet appendFormat:@"isVerified: %@\n\t", @(_isVerified)];
    
    [strRet appendString:@"\n}\n"];
    
    return strRet;
}
@end
