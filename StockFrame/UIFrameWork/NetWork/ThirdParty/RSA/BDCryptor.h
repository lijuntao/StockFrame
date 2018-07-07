//
//  Created by Patrick Hogan on 10/12/12.
//

#import <UIKit/UIKit.h>
////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Forward Declarations
////////////////////////////////////////////////////////////////////////////////////////////////////////////
@class BDError;


////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public Interface
////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface BDCryptor : NSObject

- (SecKeyRef)getKeyRefWithPrivateKey:(NSString *)key
							   error:(BDError *)error;

- (NSData *)encrypt:(NSData *)plainText
                  key:(NSData *)key
              error:(BDError *)error;
// --
- (NSData *)decrypt:(NSData *)cipherText
                  key:(NSString *)key
			  error:(BDError *)error;
- (NSData *)decrypt:(NSData *)cipherText
				keyRef:(SecKeyRef)keyRef
			  error:(BDError *)error
		 releaseKey:(BOOL)bReleaseKey;

// --
- (NSData *)sign:(NSData *)plainData
             key:(NSString *)key
           error:(BDError *)error;
- (NSData *)sign:(NSData *)plainData
             keyRef:(SecKeyRef)keyRef
           error:(BDError *)error
	  releaseKey:(BOOL)bReleaseKey;

// --
- (BOOL)verify:(NSData *)plainData
		signedData:(NSData *)cipherData
			   key:(NSData *)key
			 error:(BDError *)error;
@end
