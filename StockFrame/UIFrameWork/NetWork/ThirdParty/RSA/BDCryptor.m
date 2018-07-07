//
//  Created by Patrick Hogan on 10/12/12.
//


////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public Interface
////////////////////////////////////////////////////////////////////////////////////////////////////////////
#import "BDCryptor.h"


////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Implementation
////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation BDCryptor


- (SecKeyRef)getKeyRefWithPrivateKey:(NSString *)key
							   error:(BDError *)error
{
	return nil;
}


- (NSData *)encrypt:(NSData *)plainText
				key:(NSData *)key
              error:(BDError *)error
{
	return nil;
}

// --
- (NSData *)decrypt:(NSData *)cipherText
				key:(NSString *)key
			  error:(BDError *)error
{
	return nil;
}

- (NSData *)decrypt:(NSData *)cipherText
			 keyRef:(SecKeyRef)keyRef
			  error:(BDError *)error
		 releaseKey:(BOOL)bReleaseKey
{
	return nil;
}


// --
- (NSData *)sign:(NSData *)plainData
             key:(NSString *)key
           error:(BDError *)error
{
	return nil;
}

- (NSData *)sign:(NSData *)plainData
		  keyRef:(SecKeyRef)keyRef
           error:(BDError *)error
	  releaseKey:(BOOL)bReleaseKey
{
	return nil;
}

// --
- (BOOL)verify:(NSData *)plainData
	signedData:(NSData *)cipherData
		   key:(NSData *)key
		 error:(BDError *)error
{
	return NO;
}


@end