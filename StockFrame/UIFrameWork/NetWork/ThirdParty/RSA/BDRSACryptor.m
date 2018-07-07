//
//  Created by Patrick Hogan on 10/12/12.
//


////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public Interface
////////////////////////////////////////////////////////////////////////////////////////////////////////////
#import "BDRSACryptor.h"

////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Utilities
////////////////////////////////////////////////////////////////////////////////////////////////////////////
#import <Security/Security.h>

#import <CommonCrypto/CommonDigest.h>

#import "NSData+Encrypt.h"
#import "BDCryptorError.h"

////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Constants
////////////////////////////////////////////////////////////////////////////////////////////////////////////
//static unsigned char oidSequence [] = { 0x30, 0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d, 0x01, 0x01, 0x01, 0x05, 0x00 };


////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Implementation
static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation BDRSACryptor


- (SecKeyRef)getKeyRefWithPrivateKey:(NSString *)key
							   error:(BDError *)error
{
	[self setPrivateKey:key
                    tag:[self privateKeyIdentifier]
                  error:error];
    
    NSMutableDictionary *keyQueryDictionary = [self keyQueryDictionary:[self privateKeyIdentifier]];
    [keyQueryDictionary setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecReturnRef];
    
    SecKeyRef privateKey = [self keyRefWithTag:[self privateKeyIdentifier]
                                         error:error];
    
    if ([BDError error:error
     containsErrorType:BDCryptoErrorRSACopyKey
            errorClass:[BDCryptorError class]])
    {
        return nil;
    }
	
	return privateKey;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Encryption/decryption methods
////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSData *)encrypt:(NSData *)plainText
                  key:(NSData *)key
                error:(BDError *)error
{
    if (!plainText)
    {
        [error addErrorWithType:BDCryptoErrorEncrypt
                     errorClass:[BDCryptorError class]];
    
        return nil;
    }
    
    [self setPublicKey:key
                   tag:[self publicKeyIdentifier]
                 error:error];
    
    SecKeyRef publicKey = [self keyRefWithTag:[self publicKeyIdentifier]
                                        error:error];
    
    if ([BDError error:error
     containsErrorType:BDCryptoErrorRSACopyKey
            errorClass:[BDCryptorError class]])
    {
        return nil;
    }
    
    uint8_t *nonce = (uint8_t *)[plainText bytes];
    size_t cipherBufferSize = SecKeyGetBlockSize(publicKey);
    uint8_t *cipherBuffer = malloc(cipherBufferSize);
    
//    BDDebugLog(@"Cipher buffer size: %lu", cipherBufferSize);
    
    if (cipherBufferSize < sizeof(nonce))
    {
        if (publicKey)
        {
            CFRelease(publicKey);
        }
        
        free(cipherBuffer);
        
        [error addErrorWithType:BDCryptoErrorRSATextLength
                     errorClass:[BDCryptorError class]];
        
        return nil;
    }
    
    OSStatus secStatus = SecKeyEncrypt(publicKey,
                                       kSecPaddingPKCS1,
                                       nonce,
                                       strlen((char *)nonce) + 1,
                                       &cipherBuffer[0],
                                       &cipherBufferSize);
    
    if (secStatus != noErr)
    {
        [error addErrorWithType:BDCryptoErrorEncrypt
                     errorClass:[BDCryptorError class]];
                
        return nil;
    }
    
    NSData *encryptedData = [NSData dataWithBytes:cipherBuffer
                                           length:cipherBufferSize];
    
//    BDDebugLog(@"Base 64 Encrypted String:\n%@", [encryptedData base64EncodedString]);
    
    if (publicKey)
    {
        CFRelease(publicKey);
    }
    free(cipherBuffer);
    
    return encryptedData;
}


- (NSData *)decrypt:(NSData *)cipherText
                  key:(NSString *)key
                error:(BDError *)error
{
    if (!cipherText)
    {
        [error addErrorWithType:BDCryptoErrorDecrypt
                     errorClass:[BDCryptorError class]];
        
        return nil;
    }
    
	SecKeyRef keyRef = [self getKeyRefWithPrivateKey:key error:error];
	return [self decrypt:cipherText keyRef:keyRef error:error releaseKey:YES];
    
}
- (NSData *)decrypt:(NSData *)cipherText
			 keyRef:(SecKeyRef)keyRef
			  error:(BDError *)error
		 releaseKey:(BOOL)bReleaseKey
{
	
    size_t plainBufferSize = SecKeyGetBlockSize(keyRef);
    uint8_t *plainBuffer = malloc(plainBufferSize);
    
    NSData *incomingData = cipherText;
    uint8_t *cipherBuffer = (uint8_t*)[incomingData bytes];
    size_t cipherBufferSize = SecKeyGetBlockSize(keyRef);
    
    if (plainBufferSize < cipherBufferSize)
    {
        if (bReleaseKey && keyRef)
        {
            CFRelease(keyRef);
        }
        
        free(plainBuffer);
        
        [error addErrorWithType:BDCryptoErrorRSATextLength
                     errorClass:[BDCryptorError class]];
        
        return nil;
    }
    
    OSStatus secStatus = SecKeyDecrypt(keyRef,
                                       kSecPaddingPKCS1,
                                       cipherBuffer,
                                       cipherBufferSize,
                                       plainBuffer,
                                       &plainBufferSize);
    
    if (secStatus != noErr)
    {
        [error addErrorWithType:BDCryptoErrorDecrypt
                     errorClass:[BDCryptorError class]];
        
        return nil;
    }
    
    NSData *decryptedData = [[NSData alloc] initWithBytes:plainBuffer length:plainBufferSize];
    
    free(plainBuffer);
    
    if (bReleaseKey && keyRef)
    {
        CFRelease(keyRef);
    }
    
    return decryptedData;
	
}


- (NSData *)sign:(NSData *)plainData
             key:(NSString *)key
           error:(BDError *)error
{    
    if (!plainData)
    {
        [error addErrorWithType:BDCryptoErrorEncrypt
                     errorClass:[BDCryptorError class]];
        
        return nil;
    }
    
	SecKeyRef keyRef = [self getKeyRefWithPrivateKey:key error:error];
	return [self sign:plainData keyRef:keyRef error:error releaseKey:YES];
}

- (NSData *)sign:(NSData *)plainData
		  keyRef:(SecKeyRef)keyRef
           error:(BDError *)error
	  releaseKey:(BOOL)bReleaseKey
{
	
    uint8_t *nonce = (uint8_t *)[plainData bytes];
    size_t cipherBufferSize = SecKeyGetBlockSize(keyRef);
    uint8_t *cipherBuffer = malloc(cipherBufferSize);
    
    //    BDDebugLog(@"Cipher buffer size: %lu", cipherBufferSize);
    
    if (cipherBufferSize < sizeof(nonce))
    {
        if (bReleaseKey && keyRef)
        {
            CFRelease(keyRef);
        }
        
        free(cipherBuffer);
        
        [error addErrorWithType:BDCryptoErrorRSATextLength
                     errorClass:[BDCryptorError class]];
        
        return nil;
    }
    
    OSStatus secStatus = SecKeyRawSign(keyRef,
                                       kSecPaddingPKCS1,
                                       [plainData bytes],
                                       [plainData length],
                                       &cipherBuffer[0],
                                       &cipherBufferSize);
    
    if (secStatus != noErr)
    {
        [error addErrorWithType:BDCryptoErrorEncrypt
                     errorClass:[BDCryptorError class]];
        
        return nil;
    }
	
	
    NSData *encryptedData = [NSData dataWithBytes:cipherBuffer
                                           length:cipherBufferSize];
    
    //    BDDebugLog(@"Base 64 Encrypted String:\n%@", [encryptedData base64EncodedString]);
    
    if (bReleaseKey && keyRef)
    {
        CFRelease(keyRef);
    }
    free(cipherBuffer);
    
    return encryptedData;
}

- (BOOL)verify:(NSData *)plainData
		signedData:(NSData *)cipherData
			   key:(NSData *)key
			 error:(BDError *)error
{
	
    if (!cipherData)
    {
        [error addErrorWithType:BDCryptoErrorDecrypt
                     errorClass:[BDCryptorError class]];
        
        return NO;
    }
    
    [self setPublicKey:key
                   tag:[self publicKeyIdentifier]
                 error:error];
    
    SecKeyRef publicKey = [self keyRefWithTag:[self publicKeyIdentifier]
                                        error:error];
    
    if ([BDError error:error
     containsErrorType:BDCryptoErrorRSACopyKey
            errorClass:[BDCryptorError class]])
    {
        return NO;
    }
    
	size_t plainBufferSize = SecKeyGetBlockSize(publicKey);
    uint8_t *plainBuffer = malloc(plainBufferSize);
    
    NSData *incomingData = cipherData;
    uint8_t *cipherBuffer = (uint8_t*)[incomingData bytes];
    size_t cipherBufferSize = SecKeyGetBlockSize(publicKey);
    
    if (plainBufferSize < cipherBufferSize)
    {
        if (publicKey)
        {
            CFRelease(publicKey);
        }
        
        free(plainBuffer);
        
        [error addErrorWithType:BDCryptoErrorRSATextLength
                     errorClass:[BDCryptorError class]];
        
        return NO;
    }
	   
    OSStatus secStatus = SecKeyRawVerify(publicKey,
										 kSecPaddingPKCS1,
										 [plainData bytes],
										 [plainData length],
										 cipherBuffer,
										 cipherBufferSize);	
	   
    if (secStatus != noErr)
    {
        [error addErrorWithType:BDCryptoErrorDecrypt
                     errorClass:[BDCryptorError class]];
        
        return NO;
    }
    
    return YES;
}


- (size_t)encode:(unsigned char *)buffer
          length:(size_t)length
{
    if (length < 128)
    {
        buffer[0] = length;
        return 1;
    }
    
    size_t i = (length / 256) + 1;
    buffer[0] = i + 0x80;
    for (size_t j = 0 ; j < i; ++j)
    {
        buffer[i - j] = length & 0xFF;
        length = length >> 8;
    }
    
    return i + 1;
}


- (void)setPrivateKey:(NSString *)key
                  tag:(NSString *)tag
                error:(BDError *)error
{
    [self removeKey:tag
              error:nil];
    
    NSString *strippedKey = nil;
    if ([self isPrivateKey:key])
    {
        strippedKey = [self strippedKey:key
                                 header:[self PEMPrivateHeader]
                                 footer:[self PEMPrivateFooter]];
    }
    
    if (!strippedKey)
    {
        [error addErrorWithType:BDCryptoErrorRSAKeyFormat
                     errorClass:[BDCryptorError class]];
        
        return;
    }
    

    NSData *strippedPrivateKeyData = [self base64DecodeString:strippedKey];//[strippedKey base64Encode];
    
//    BDDebugLog(@"Stripped Private Key Base 64:\n%@",strippedKey);
    
    NSMutableDictionary *keyQueryDictionary = [self keyQueryDictionary:tag];
    [keyQueryDictionary setObject:strippedPrivateKeyData forKey:(__bridge id)kSecValueData];
    [keyQueryDictionary setObject:(__bridge id)kSecAttrKeyClassPrivate forKey:(__bridge id)kSecAttrKeyClass];
    [keyQueryDictionary setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecReturnPersistentRef];
    
    CFTypeRef persistKey = nil;
    OSStatus secStatus = SecItemAdd((__bridge CFDictionaryRef)keyQueryDictionary, &persistKey);
    
    if (persistKey != nil)
    {
        CFRelease(persistKey);
    }
    
    if ((secStatus != noErr) && (secStatus != errSecDuplicateItem))
    {
        [error addErrorWithType:BDCryptoErrorRSAAddKey
                     errorClass:[BDCryptorError class]];
        
        return;
    }
    
    return;
}


- (void)setPublicKey:(NSData *)key
                 tag:(NSString *)tag
               error:(BDError *)error
{
    [self removeKey:tag
              error:nil];
    
    NSData *strippedPublicKeyData = [self strippedX509PublicKey:key
                                                      error:error];
    
    if ([BDError errorContainsErrors:error])
    {
        return;
    }
    
//    BDDebugLog(@"Stripped Public Key Bytes:\n%@", [strippedPublicKeyData description]);
    
    CFTypeRef persistKey = nil;
    
    NSMutableDictionary *keyQueryDictionary = [self keyQueryDictionary:tag];
    [keyQueryDictionary setObject:strippedPublicKeyData forKey:(__bridge id)kSecValueData];
    [keyQueryDictionary setObject:(__bridge id)kSecAttrKeyClassPublic forKey:(__bridge id)kSecAttrKeyClass];
    [keyQueryDictionary setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecReturnPersistentRef];
    
    OSStatus secStatus = SecItemAdd((__bridge CFDictionaryRef)keyQueryDictionary, &persistKey);
    
    if (persistKey != nil)
    {
        CFRelease(persistKey);
    }
    
    if ((secStatus != noErr) && (secStatus != errSecDuplicateItem))
    {
        [error addErrorWithType:BDCryptoErrorRSAAddKey
                     errorClass:[BDCryptorError class]];
        
        return;
    }
    
    return;
}


- (NSData *)strippedX509PublicKey:(NSData *)key
                        error:(BDError *)error
{
    
    NSData *strippedPublicKeyData = key;
       
    
    {
        unsigned char * bytes = (unsigned char *)[strippedPublicKeyData bytes];
        size_t bytesLen = [strippedPublicKeyData length];
        
        size_t i = 0;
        if (bytes[i++] != 0x30)
        {
            [error addErrorWithType:BDCryptoErrorRSAKeyFormat
                         errorClass:[BDCryptorError class]];
            
            return nil;
        }
        
        if (bytes[i] > 0x80)
        {
            i += bytes[i] - 0x80 + 1;
        }
        else
        {
            i++;
        }
        
        if (i >= bytesLen)
        {
            [error addErrorWithType:BDCryptoErrorRSAKeyFormat
                         errorClass:[BDCryptorError class]];
            
            return nil;
        }
        if (bytes[i] != 0x30)
        {
            [error addErrorWithType:BDCryptoErrorRSAKeyFormat
                         errorClass:[BDCryptorError class]];
            
            
            return nil;
        }
        
        i += 15;
        
        if (i >= bytesLen - 2)
        {
            [error addErrorWithType:BDCryptoErrorRSAKeyFormat
                         errorClass:[BDCryptorError class]];
            
            
            return nil;
        }
        if (bytes[i++] != 0x03)
        {
            [error addErrorWithType:BDCryptoErrorRSAKeyFormat
                         errorClass:[BDCryptorError class]];
            
            return nil;
        }
        
        if (bytes[i] > 0x80)
        {
            i += bytes[i] - 0x80 + 1;
        }
        else
        {
            i++;
        }
        
        if (i >= bytesLen)
        {
            [error addErrorWithType:BDCryptoErrorRSAKeyFormat
                         errorClass:[BDCryptorError class]];
            
            return nil;
        }
        if (bytes[i++] != 0x00)
        {
            [error addErrorWithType:BDCryptoErrorRSAKeyFormat
                         errorClass:[BDCryptorError class]];
            
            return nil;
        }
        if (i >= bytesLen)
        {
            [error addErrorWithType:BDCryptoErrorRSAKeyFormat
                         errorClass:[BDCryptorError class]];
            
            return nil;
        }
        
        strippedPublicKeyData = [NSData dataWithBytes:&bytes[i]
                                               length:bytesLen - i];
    }
    
//    BDDebugLog(@"X.509 Formatted Public Key bytes:\n%@", [strippedPublicKeyData description]);
    
    if (!strippedPublicKeyData)
    {
        [error addErrorWithType:BDCryptoErrorRSAKeyFormat
                     errorClass:[BDCryptorError class]];
        
        return nil;
    }
    
    return strippedPublicKeyData;
}


- (NSString *)strippedKey:(NSString *)key
                   header:(NSString *)header
                   footer:(NSString *)footer
{
    NSString *result = [[key stringByReplacingOccurrencesOfString:header
                                                       withString:@""] stringByReplacingOccurrencesOfString:footer withString:@""];
    
    return [[result stringByReplacingOccurrencesOfString:@"\n"
                                              withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
}


- (BOOL)isPrivateKey:(NSString *)key
{
    if (([key rangeOfString:[self PEMPrivateHeader]].location != NSNotFound) && ([key rangeOfString:[self PEMPrivateFooter]].location != NSNotFound))
    {
        return YES;
    }
    
    return NO;
}


- (BOOL)isX509PublicKey:(NSString *)key
{
    if (([key rangeOfString:[self X509PublicHeader]].location != NSNotFound) && ([key rangeOfString:[self X509PublicFooter]].location != NSNotFound))
    {
        return YES;
    }
    
    return NO;
}


- (BOOL)isPKCS1PublicKey:(NSString *)key
{
    if (([key rangeOfString:[self PKCS1PublicHeader]].location != NSNotFound) && ([key rangeOfString:[self PKCS1PublicFooter]].location != NSNotFound))
    {
        return YES;
    }
    
    return NO;
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Keychain convenience methods
////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSData *)keyDataWithTag:(NSString *)tag
                     error:(BDError *)error
{
    NSMutableDictionary *queryKey = [self keyQueryDictionary:tag];
    [queryKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecReturnData];
    
    SecKeyRef key = NULL;
    OSStatus err = SecItemCopyMatching((__bridge CFDictionaryRef)queryKey, (CFTypeRef *)&key);
    
    if (err != noErr || !key)
    {
        [error addErrorWithType:BDCryptoErrorRSACopyKey
                     errorClass:[BDCryptorError class]];
        
        return nil;
    }
    
    return (__bridge NSData *)key;
}


- (SecKeyRef)keyRefWithTag:(NSString *)tag
                     error:(BDError *)error
{
	
	NSMutableDictionary *queryKey = [self keyQueryDictionary:tag];
	[queryKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecReturnRef];
	
	SecKeyRef key = NULL;
	OSStatus err = SecItemCopyMatching((__bridge CFDictionaryRef)queryKey, (CFTypeRef *)&key);
	
	if (err != noErr)
	{
		[error addErrorWithType:BDCryptoErrorRSACopyKey
					 errorClass:[BDCryptorError class]];
		
		
		return nil;
	}
	
	return key;
	
}


- (void)removeKey:(NSString *)tag
            error:(BDError *)error
{
    NSDictionary *queryKey = [self keyQueryDictionary:tag];
    OSStatus secStatus = SecItemDelete((__bridge CFDictionaryRef)queryKey);
    
    if ((secStatus != noErr) && (secStatus != errSecDuplicateItem))
    {
        [error addErrorWithType:BDCryptoErrorRSARemoveKey
                     errorClass:[BDCryptorError class]];
    }
}


- (NSMutableDictionary *)keyQueryDictionary:(NSString *)tag
{
    NSData *keyTag = [tag dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    [result setObject:(__bridge id)kSecClassKey forKey:(__bridge id)kSecClass];
    [result setObject:(__bridge id)kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    [result setObject:keyTag forKey:(__bridge id)kSecAttrApplicationTag];
    [result setObject:(__bridge id)kSecAttrAccessibleWhenUnlocked forKey:(__bridge id)kSecAttrAccessible];
    
    return result;
}


- (NSUInteger)PEMWrapWidth
{
    return 64;
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - RSA Key Anatomy
////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *)X509PublicHeader
{
    return @"-----BEGIN PUBLIC KEY-----";
}


- (NSString *)X509PublicFooter
{
    return @"-----END PUBLIC KEY-----";
}


- (NSString *)PKCS1PublicHeader
{
    return  @"-----BEGIN RSA PUBLIC KEY-----";
}


- (NSString *)PKCS1PublicFooter
{
    return @"-----END RSA PUBLIC KEY-----";
}


- (NSString *)PEMPrivateHeader
{
    return @"-----BEGIN RSA PRIVATE KEY-----";
}


- (NSString *)PEMPrivateFooter
{
    return @"-----END RSA PRIVATE KEY-----";
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Important tags
////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *)publicKeyIdentifier
{
    return [self publicKeyIdentifierWithTag:nil];
}


- (NSString *)privateKeyIdentifier
{
    return [self privateKeyIdentifierWithTag:nil];
}


- (NSString *)publicKeyIdentifierWithTag:(NSString *)additionalTag
{
    NSString *identifier = [NSString stringWithFormat:@"%@.publicKey", [[NSBundle mainBundle] bundleIdentifier]];
    
    if (additionalTag)
    {
        identifier = [identifier stringByAppendingFormat:@".%@", additionalTag];
    }
    
    return identifier;
}


- (NSString *)privateKeyIdentifierWithTag:(NSString *)additionalTag
{
    NSString *identifier = [NSString stringWithFormat:@"%@.privateKey", [[NSBundle mainBundle] bundleIdentifier]];
    
    if (additionalTag)
    {
        identifier = [identifier stringByAppendingFormat:@".%@", additionalTag];
    }
    
    return identifier;
}
#pragma mark -
#pragma mark Base64 Encode/Decoder
- (NSString *)base64EncodeData:(NSData*)dataToConvert
{
    if ([dataToConvert length] == 0)
        return @"";
    
    char *characters = malloc((([dataToConvert length] + 2) / 3) * 4);
    if (characters == NULL)
        return nil;
    
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (i < [dataToConvert length])
    {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < [dataToConvert length])
            buffer[bufferLength++] = ((char *)[dataToConvert bytes])[i++];
        
        //  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}

- (NSData*)base64DecodeString:(NSString *)string
{
    if (string == nil)
        [NSException raise:NSInvalidArgumentException format:nil];
    if ([string length] == 0)
        return [NSData data];
    
    static char *decodingTable = NULL;
    if (decodingTable == NULL)
    {
        decodingTable = malloc(256);
        if (decodingTable == NULL)
            return nil;
        memset(decodingTable, CHAR_MAX, 256);
        NSUInteger i;
        for (i = 0; i < 64; i++)
            decodingTable[(short)encodingTable[i]] = i;
    }
    
    const char *characters = [string cStringUsingEncoding:NSASCIIStringEncoding];
    if (characters == NULL)     //  Not an ASCII string!
        return nil;
    char *bytes = malloc((([string length] + 3) / 4) * 3);
    if (bytes == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (YES)
    {
        char buffer[4];
        short bufferLength;
        for (bufferLength = 0; bufferLength < 4; i++)
        {
            if (characters[i] == '\0')
                break;
            if (isspace(characters[i]) || characters[i] == '=')
                continue;
            buffer[bufferLength] = decodingTable[(short)characters[i]];
            if (buffer[bufferLength++] == CHAR_MAX)      //  Illegal character!
            {
                free(bytes);
                return nil;
            }
        }
        
        if (bufferLength == 0)
            break;
        if (bufferLength == 1)      //  At least two characters are needed to produce one byte!
        {
            free(bytes);
            return nil;
        }
        
        //  Decode the characters in the buffer to bytes.
        bytes[length++] = (buffer[0] << 2) | (buffer[1] >> 4);
        if (bufferLength > 2)
            bytes[length++] = (buffer[1] << 4) | (buffer[2] >> 2);
        if (bufferLength > 3)
            bytes[length++] = (buffer[2] << 6) | buffer[3];
    }
    
    realloc(bytes, length);
    
    return [NSData dataWithBytesNoCopy:bytes length:length];
}

@end