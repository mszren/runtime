//
//  CPCCrypto.h
//  AESCryptoiPhone
//
//  Created by dumbbellyang on 1/12/11.
//  Copyright 2011 Foxconn Technology Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Security/Security.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

#define UNZIP_FOLDER @"sales_data"
#define UNZIP_FOLDER2 @"sales_data2"
#define UNZIP_FOLDER3 @"sales_data3"
#define SYMMETRIC_KEY_FILE @"symmetric.key"
#define PRIVATE_KEY_FILE @"private.pem"
#define PUBLIC_KEY_FILE @"public.pem"
#define JAVA_PRIVATE_KEY_FILE @"javaprivate.pem"
#define JAVA_PUBLIC_KEY_FILE @"javapublic.pem"
#define ENCRYPTED_FILES @"Enc391Sample.xml",@"Enc2134Sample.xml",@"Enc4876Sample.xml",@"Enc8381Sample.xml",@"Enc12571Sample.xml",nil
#define DECRYPTED_FILES @"Dec391Sample.xml",@"Dec2134Sample.xml",@"Dec4876Sample.xml",@"Dec8381Sample.xml",@"Dec12571Sample.xml",nil

#define kAES128BlockSize	    kCCBlockSizeAES128
#define kAES128KeySize	        kCCKeySizeAES128

#define kDESBlockSize	        kCCBlockSizeDES
#define kDESKeySize				kCCKeySizeDES

#define k3DESBlockSize	        kCCBlockSize3DES
#define k3DESKeySize	        kCCKeySize3DES

typedef enum {
    AlgorithmAES128 = 0,
    AlgorithmAES256 = 1,
    AlgorithmDES = 2,
    Algorithm3DES = 3,
	AlgorithmRSA = 4
} EncryptAlgorithm;


@interface CPCCrypto : NSObject {
	NSData *publicKeyData;
	NSData *privateKeyData;
	NSData *symmetricKeyData;
	
	bool   isImportKey;
}

@property(nonatomic, retain)    NSData *publicKeyData;
@property(nonatomic, retain)    NSData *privateKeyData;
@property(nonatomic, retain)    NSData *symmetricKeyData;

@property(nonatomic, readwrite) bool isImportKey;

//- (void) generateSymmetricKey:(int)keySize SaveToFile:(bool)isSaveToFile;
//
//- (void) generateRSAKeyPair:(NSUInteger)keySize SaveToFile:(bool)isSaveToFile;

- (void) saveKeyToFile:(NSData*)keyData KeyFile:(NSString*)strKeyFile;

- (NSData*) loadKeyFromFile:(NSString*)strKeyFile;

//- (NSData*) getKeyFromString:(NSString*)strKey;

- (NSData*) getSymmetricKeyFromString:(NSString*)strKey;

- (NSString*) getPublicKeyString;

- (NSString*) getPrivateKeyString;

- (NSData*) doCipherAES128:(NSData *)plainText key:(NSData *)aSymmetricKey
			       context:(CCOperation)encryptOrDecrypt padding:(CCOptions *)pkcs7;

//- (NSData*) doCipherAES256:(NSData *)plainText key:(NSData *)aSymmetricKey
//			       context:(CCOperation)encryptOrDecrypt padding:(CCOptions *)pkcs7;

- (NSData*) doCipherDES:(NSData *)plainText key:(NSData *)aSymmetricKey
			    context:(CCOperation)encryptOrDecrypt padding:(CCOptions *)pkcs7;

- (NSData*) doCipher3DES:(NSData *)plainText key:(NSData *)aSymmetricKey
			     context:(CCOperation)encryptOrDecrypt padding:(CCOptions *)pkcs7;

//- (NSData*) doCipherRSA:(NSData *)plainText key:(NSData *)aSymmetricKey
//			    context:(CCOperation)encryptOrDecrypt padding:(CCOptions *)pkcs7;

- (NSData*) encrypt:(NSData *)plainText Algorithm:(EncryptAlgorithm)alg key:(NSData *)aSymmetricKey padding:(CCOptions *)pkcs7;

- (NSData*) decrypt:(NSData *)plainText Algorithm:(EncryptAlgorithm)alg key:(NSData *)aSymmetricKey padding:(CCOptions *)pkcs7;

- (void) encryptFile:(NSString*)strSourceFile TargetFile:(NSString*)strTargetFile Algorithm:(EncryptAlgorithm)alg key:(NSData *)aSymmetricKey padding:(CCOptions *)pkcs7;

- (void) decryptFile:(NSString*)strSourceFile TargetFile:(NSString*)strTargetFile Algorithm:(EncryptAlgorithm)alg key:(NSData *)aSymmetricKey padding:(CCOptions *)pkcs7;

- (NSString*) doCipherDESBase64FromString:(NSString*)inPut key:(NSString *)key;

@end
