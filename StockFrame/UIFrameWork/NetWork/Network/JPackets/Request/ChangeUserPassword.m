//
//  ChangeUserPassword.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "ChangeUserPassword.h"

@implementation ChangeUserPassword
@synthesize dict = _dict;

- (id)initWithUserID:(NSString *)strUserID
              oriPwd:(NSString *)strOriPwd
              newPwd:(NSString *)strNewPwd
            verified:(BOOL)isVerified
{
    self = [super init];
    if (self)
    {
        self.pt = EnumPacketPT_ChangeUserPassword;
        self.seq = [JPacketSendBase getSeqIncreased];
        _user = strUserID;
        _orgpwd = strOriPwd;
        _pwd = strNewPwd;
        _isVerified = isVerified;
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        
        [dict setObject:strUserID forKey:@(3)];
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
    [strRet appendFormat:@"pt: ChangeUserPassword (%d)\n\t", EnumPacketPT_ChangeUserPassword];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
    
    [strRet appendFormat:@"user: %@\n\t", _user];
    [strRet appendFormat:@"orgpwd: %@\n\t", _orgpwd];
    [strRet appendFormat:@"pwd: %@\n\t", _pwd];
    [strRet appendFormat:@"isVerified: %@\n\t", @(_isVerified)];
    
    [strRet appendString:@"\n}\n"];
    
    return strRet;
}

@end
