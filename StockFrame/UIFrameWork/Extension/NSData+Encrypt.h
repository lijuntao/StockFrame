//
//  NSData+Encrypt.h
//  MasterDataManager
//
//  Created by doshan on 2014/7/2.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Encrypt)

+ (NSData*)base64DecodeString:(NSString *)string;
- (NSString *)base64Encode;

- (NSData *)RSA_PKCS1Padding_DecryptWithPrivateKeyRef:(SecKeyRef)keyRef;
- (NSData *)RSA_PKCS1Padding_SignWithPrivateKeyRef:(SecKeyRef)keyRef;

- (NSData *)AES128_CBC_NoPadding_EncryptWithKey:(NSData *)key IV:(NSData*)iv;
- (NSData *)AES128_CBC_NoPadding_DecryptWithKey:(NSData *)key IV:(NSData*)iv;
@end
