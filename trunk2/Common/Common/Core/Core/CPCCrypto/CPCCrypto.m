//
//  CPCCrypto.m
//  AESCryptoiPhone
//
//  Created by dumbbellyang on 1/12/11.
//  Copyright 2011 Foxconn Technology Group. All rights reserved.
//

#import "CPCCrypto.h"
#import "GTMBase64.h"

@implementation CPCCrypto

@synthesize publicKeyData;
@synthesize privateKeyData;
@synthesize symmetricKeyData;

@synthesize isImportKey;

+ (NSData*) hexToBytes:(NSString*)strHex {
	NSMutableData* data = [[[NSMutableData alloc] init] autorelease];
	int idx;
	for (idx = 0; idx+2 <= strHex.length; idx+=2) {
		NSRange range = NSMakeRange(idx, 2);
		NSString* hexStr = [strHex substringWithRange:range];
		NSScanner* scanner = [NSScanner scannerWithString:hexStr];
		unsigned int intValue;
		[scanner scanHexInt:&intValue];
		[data appendBytes:&intValue length:1];
	}
	return data;
}

+ (NSString*) getCachesDirectory{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

CCOptions encryptPadding = kCCOptionPKCS7Padding;

- (void) dealloc{
	[publicKeyData release];
	[privateKeyData release];
	[symmetricKeyData release];
	
	[super dealloc];
}

//- (void) generateSymmetricKey:(int)keySize SaveToFile:(bool)isSaveToFile{
//	isImportKey = NO;
//	
//	symmetricKeyData = [SSCrypto getKeyDataWithLength:keySize];
//	if (isSaveToFile) {
//		[self saveKeyToFile:symmetricKeyData KeyFile:SYMMETRIC_KEY_FILE];
//	}
//}
//
//- (void) generateRSAKeyPair:(NSUInteger)keySize SaveToFile:(bool)isSaveToFile{
//	if (((keySize != 512) && (keySize != 1024)) || (keySize != 2048)) {
//		keySize = 2048;
//	}
//	// generate a private key
//    privateKeyData = [SSCrypto generateRSAPrivateKeyWithLength:keySize];
//    //NSLog(@"privateKeyData: \n%s", [privateKey bytes]);
//    // generate a public key from the private key data
//    publicKeyData = [SSCrypto generateRSAPublicKeyFromPrivateKey:privateKeyData];
//    //NSLog(@"publicKeyData: \n%s", [publicKey bytes]);
//	
//    // At this point you would write the private and public keys to files
//    // for later use like so:
//	if (isSaveToFile) {
//		[self saveKeyToFile:privateKeyData KeyFile:PRIVATE_KEY_FILE];
//		[self saveKeyToFile:publicKeyData KeyFile:PUBLIC_KEY_FILE];
//	}
//}

- (void) saveKeyToFile:(NSData*)keyData KeyFile:(NSString*)strKeyFile{
	//文件夹
	NSString *documentDir = [CPCCrypto getCachesDirectory];
    
	//文件路径
    NSString *filePath = [documentDir stringByAppendingPathComponent:strKeyFile];
	
	//写入文件
	[keyData writeToFile:filePath atomically:YES];
}

- (NSData*) loadKeyFromFile:(NSString*)strKeyFile{
	isImportKey = NO;
	
	//文件夹
	NSString *documentDir = [CPCCrypto getCachesDirectory];
    
	//文件路径
    NSString *filePath = [documentDir stringByAppendingPathComponent:strKeyFile];
	
	//从文件读取
	return [[[NSData alloc] initWithContentsOfFile:filePath] autorelease];	
}

- (NSData*) getSymmetricKeyFromString:(NSString*)strKey{
	isImportKey = YES;
	return [CPCCrypto hexToBytes:strKey];
}

//- (NSData*) getSymmetricKeyFromRandomString:(NSString*)strKey{
//	return [strKey dataUsingEncoding:NSASCIIStringEncoding];
//}

//- (NSData*) getAES256KeyFromString:(NSString*)strKey{
//	isImportKey = YES;
//	//return [Util hexToBytes:strKey];
//	strKey = @"Rk9YQ09OTlRFQ0hOT0xPR1lHUk9VUENNTVNHQkdJVFM=";
//	return [[strKey dataUsingEncoding:NSASCIIStringEncoding] decodeBase64];
//}

//- (NSString*) getSymmetricKeyString{
//	if (isImportKey) {
//		//return [[[NSString alloc] initWithData:symmetricKeyData encoding:NSUTF8StringEncoding] autorelease];
//		return [[[NSString alloc] initWithData:symmetricKeyData encoding:NSASCIIStringEncoding] autorelease];
//	}
//	else {
//		return [symmetricKeyData hexval];
//	}
//}

//- (NSString*) getAES256KeyString{
//	if (isImportKey) {
//		return [[[NSString alloc] initWithData:symmetricKeyData encoding:NSUTF8StringEncoding] autorelease];
//	}
//	else {
//		return [symmetricKeyData hexval];
//	}
//}

- (NSString*) getPublicKeyString{
	NSString *strKey = [[[NSString alloc] initWithData:publicKeyData encoding:NSASCIIStringEncoding] autorelease];
	return strKey;
	//return [publicKeyData encodeBase64];
}

- (NSString*) getPrivateKeyString{
	NSString *strKey = [[[NSString alloc] initWithData:privateKeyData encoding:NSASCIIStringEncoding] autorelease];
	return strKey;
	//return [privateKeyData encodeBase64];
}

- (NSData*) doCipherAES128:(NSData *)plainText key:(NSData *)aSymmetricKey
			       context:(CCOperation)encryptOrDecrypt padding:(CCOptions *)pkcs7 
{
    CCCryptorStatus ccStatus = kCCSuccess;
    // Symmetric crypto reference.
    CCCryptorRef thisEncipher = NULL;
    // Cipher Text container.
    NSData * cipherOrPlainText = nil;
    // Pointer to output buffer.
    uint8_t * bufferPtr = NULL;
    // Total size of the buffer.
    size_t bufferPtrSize = 0;
    // Remaining bytes to be performed on.
    size_t remainingBytes = 0;
    // Number of bytes moved to buffer.
    size_t movedBytes = 0;
    // Length of plainText buffer.
    size_t plainTextBufferSize = 0;
    // Placeholder for total written.
    size_t totalBytesWritten = 0;
    // A friendly helper pointer.
    uint8_t * ptr;
	
    // Initialization vector; dummy in this case 0's.
    uint8_t iv[kAES128BlockSize];
    memset((void *) iv, 0x0, (size_t) sizeof(iv));
		
    //LOGGING_FACILITY(plainText != nil, @"PlainText object cannot be nil." );
    //LOGGING_FACILITY(aSymmetricKey != nil, @"Symmetric key object cannot be nil." );
    //LOGGING_FACILITY(pkcs7 != NULL, @"CCOptions * pkcs7 cannot be NULL." );
    //LOGGING_FACILITY([aSymmetricKey length] == kChosenCipherKeySize, @"Disjoint choices for key size." );
	
    plainTextBufferSize = [plainText length];
	
    //LOGGING_FACILITY(plainTextBufferSize > 0, @"Empty plaintext passed in." );
	
    NSLog(@"AES128 pkcs7: %d", *pkcs7);
    // We don't want to toss padding on if we don't need to
    if(encryptOrDecrypt == kCCEncrypt) {
        if(*pkcs7 != kCCOptionECBMode) {
            if((plainTextBufferSize % kAES128BlockSize) == 0) {
                *pkcs7 = 0x0000;
            } else {
                *pkcs7 = kCCOptionPKCS7Padding;
            }
        }
    } else if(encryptOrDecrypt != kCCDecrypt) {
        NSLog(@"Invalid CCOperation parameter [%d] for AES128 cipher context.", *pkcs7 );
    } 
	
    // Create and Initialize the crypto reference.
    ccStatus = CCCryptorCreate(encryptOrDecrypt,
                               kCCAlgorithmAES128,
                               *pkcs7 + kCCOptionECBMode,
                               (const void *)[aSymmetricKey bytes],
                               kAES128KeySize,
                               (const void *)iv,
                               &thisEncipher
                               );
	
	
	//LOGGING_FACILITY1( ccStatus == kCCSuccess, @"Problem creating the context, ccStatus == %d.", ccStatus );
	
    // Calculate byte block alignment for all calls through to and including final.
    bufferPtrSize = CCCryptorGetOutputLength(thisEncipher, plainTextBufferSize, true);
	
    // Allocate buffer.
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t) );
	
    // Zero out buffer.
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
	
    // Initialize some necessary book keeping.
	
    ptr = bufferPtr;
	
    // Set up initial size.
    remainingBytes = bufferPtrSize;
	
    // Actually perform the encryption or decryption.
    ccStatus = CCCryptorUpdate(thisEncipher,
                               (const void *) [plainText bytes],
                               plainTextBufferSize,
                               ptr,
                               remainingBytes,
                               &movedBytes
                               );
	
	//LOGGING_FACILITY1( ccStatus == kCCSuccess, @"Problem with CCCryptorUpdate, ccStatus == %d.", ccStatus );
	
    // Handle book keeping.
    ptr += movedBytes;
    remainingBytes -= movedBytes;
    totalBytesWritten += movedBytes;
	
    // Finalize everything to the output buffer.
    ccStatus = CCCryptorFinal(thisEncipher,
                              ptr,
                              remainingBytes,
                              &movedBytes
                              );
	
    totalBytesWritten += movedBytes;
	
    if(thisEncipher) {
        (void) CCCryptorRelease(thisEncipher);
        thisEncipher = NULL;
    }
	
    //LOGGING_FACILITY1( ccStatus == kCCSuccess, @"Problem with encipherment ccStatus == %d", ccStatus );
	
    if (ccStatus == kCCSuccess)
        cipherOrPlainText = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)totalBytesWritten];
    else
        cipherOrPlainText = nil;
	
    if(bufferPtr) free(bufferPtr);
	
    return cipherOrPlainText;
}

//- (NSData*) doCipherAES256:(NSData *)plainText key:(NSData *)aSymmetricKey
//				   context:(CCOperation)encryptOrDecrypt padding:(CCOptions *)pkcs7 
//{
//	SSCrypto *crypto = [[[SSCrypto alloc] initWithSymmetricKey:aSymmetricKey] autorelease];
//	
//	NSLog(@"AES 256 key:%@",aSymmetricKey);
//	
//	if(encryptOrDecrypt == kCCEncrypt) {
//		[crypto setClearTextWithData:plainText];
//		
//		return [crypto encrypt:@"aes256"];
//	}
//	else {
//		[crypto setCipherText:plainText];
//		
//		return [crypto decrypt:@"aes256"];
//	}
//}

- (NSData*) doCipherDES:(NSData *)plainText key:(NSData *)aSymmetricKey
				context:(CCOperation)encryptOrDecrypt padding:(CCOptions *)pkcs7 
{
    CCCryptorStatus ccStatus = kCCSuccess;
    // Symmetric crypto reference.
    CCCryptorRef thisEncipher = NULL;
    // Cipher Text container.
    NSData * cipherOrPlainText = nil;
    // Pointer to output buffer.
    uint8_t * bufferPtr = NULL;
    // Total size of the buffer.
    size_t bufferPtrSize = 0;
    // Remaining bytes to be performed on.
    size_t remainingBytes = 0;
    // Number of bytes moved to buffer.
    size_t movedBytes = 0;
    // Length of plainText buffer.
    size_t plainTextBufferSize = 0;
    // Placeholder for total written.
    size_t totalBytesWritten = 0;
    // A friendly helper pointer.
    uint8_t * ptr;
	
    // Initialization vector; dummy in this case 0's.
    uint8_t iv[kDESBlockSize];
    memset((void *) iv, 0x0, (size_t) sizeof(iv));
	
    //NSLog(@"doCipher DES: plaintext: %@", plainText);
    NSLog(@"doCipher DES: key length: %ld", [aSymmetricKey length]);
	
    //LOGGING_FACILITY(plainText != nil, @"PlainText object cannot be nil." );
    //LOGGING_FACILITY(aSymmetricKey != nil, @"Symmetric key object cannot be nil." );
    //LOGGING_FACILITY(pkcs7 != NULL, @"CCOptions * pkcs7 cannot be NULL." );
    //LOGGING_FACILITY([aSymmetricKey length] == kChosenCipherKeySize, @"Disjoint choices for key size." );
	
    plainTextBufferSize = [plainText length];
	
    //LOGGING_FACILITY(plainTextBufferSize > 0, @"Empty plaintext passed in." );
	
    NSLog(@"DES pkcs7: %d", *pkcs7);
    // We don't want to toss padding on if we don't need to
    if(encryptOrDecrypt == kCCEncrypt) {
        if(*pkcs7 != kCCOptionECBMode) {
            if((plainTextBufferSize % kDESBlockSize) == 0) {
                *pkcs7 = 0x0000;
            } else {
                *pkcs7 = kCCOptionPKCS7Padding;
            }
        }
    } else if(encryptOrDecrypt != kCCDecrypt) {
        NSLog(@"Invalid CCOperation parameter [%d] for cipher DES context.", *pkcs7 );
    } 
	
    // Create and Initialize the crypto reference.
    ccStatus = CCCryptorCreate(encryptOrDecrypt,
                               kCCAlgorithmDES,
                               kCCOptionPKCS7Padding | kCCOptionECBMode, //the origin is '*pkcs7 + kCCOptionECBMode',not all good
                               (const void *)[aSymmetricKey bytes],
                               kDESKeySize,
                               (const void *)iv,
                               &thisEncipher
                               );
	
	
	//LOGGING_FACILITY1( ccStatus == kCCSuccess, @"Problem creating the context, ccStatus == %d.", ccStatus );
	
    // Calculate byte block alignment for all calls through to and including final.
    bufferPtrSize = CCCryptorGetOutputLength(thisEncipher, plainTextBufferSize, true);
	
    // Allocate buffer.
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t) );
	
    // Zero out buffer.
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
	
    // Initialize some necessary book keeping.
	
    ptr = bufferPtr;
	
    // Set up initial size.
    remainingBytes = bufferPtrSize;
	
    // Actually perform the encryption or decryption.
    ccStatus = CCCryptorUpdate(thisEncipher,
                               (const void *) [plainText bytes],
                               plainTextBufferSize,
                               ptr,
                               remainingBytes,
                               &movedBytes
                               );
	
	//LOGGING_FACILITY1( ccStatus == kCCSuccess, @"Problem with CCCryptorUpdate, ccStatus == %d.", ccStatus );
	
    // Handle book keeping.
    ptr += movedBytes;
    remainingBytes -= movedBytes;
    totalBytesWritten += movedBytes;
	
    // Finalize everything to the output buffer.
    ccStatus = CCCryptorFinal(thisEncipher,
                              ptr,
                              remainingBytes,
                              &movedBytes
                              );
	
    totalBytesWritten += movedBytes;
	
    if(thisEncipher) {
        (void) CCCryptorRelease(thisEncipher);
        thisEncipher = NULL;
    }
	
    //LOGGING_FACILITY1( ccStatus == kCCSuccess, @"Problem with encipherment ccStatus == %d", ccStatus );
	
    if (ccStatus == kCCSuccess)
        cipherOrPlainText = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)totalBytesWritten];
    else
        cipherOrPlainText = nil;
	
    if(bufferPtr) free(bufferPtr);
	
    return cipherOrPlainText;
}

- (NSData*) doCipher3DES:(NSData *)plainText key:(NSData *)aSymmetricKey
				 context:(CCOperation)encryptOrDecrypt padding:(CCOptions *)pkcs7 
{
    CCCryptorStatus ccStatus = kCCSuccess;
    // Symmetric crypto reference.
    CCCryptorRef thisEncipher = NULL;
    // Cipher Text container.
    NSData * cipherOrPlainText = nil;
    // Pointer to output buffer.
    uint8_t * bufferPtr = NULL;
    // Total size of the buffer.
    size_t bufferPtrSize = 0;
    // Remaining bytes to be performed on.
    size_t remainingBytes = 0;
    // Number of bytes moved to buffer.
    size_t movedBytes = 0;
    // Length of plainText buffer.
    size_t plainTextBufferSize = 0;
    // Placeholder for total written.
    size_t totalBytesWritten = 0;
    // A friendly helper pointer.
    uint8_t * ptr;
	
    // Initialization vector; dummy in this case 0's.
    uint8_t iv[k3DESBlockSize];
    memset((void *) iv, 0x0, (size_t) sizeof(iv));
	
    //NSLog(@"doCipher 3DES: plaintext: %@", plainText);
    NSLog(@"doCipher 3DES: key length: %lu", (unsigned long)[aSymmetricKey length]);
	
    //LOGGING_FACILITY(plainText != nil, @"PlainText object cannot be nil." );
    //LOGGING_FACILITY(aSymmetricKey != nil, @"Symmetric key object cannot be nil." );
    //LOGGING_FACILITY(pkcs7 != NULL, @"CCOptions * pkcs7 cannot be NULL." );
    //LOGGING_FACILITY([aSymmetricKey length] == kChosenCipherKeySize, @"Disjoint choices for key size." );
	
    plainTextBufferSize = [plainText length];
	
    //LOGGING_FACILITY(plainTextBufferSize > 0, @"Empty plaintext passed in." );
	
    NSLog(@"3DES pkcs7: %d", *pkcs7);
    // We don't want to toss padding on if we don't need to
    if(encryptOrDecrypt == kCCEncrypt) {
        if(*pkcs7 != kCCOptionECBMode) {
            if((plainTextBufferSize % k3DESBlockSize) == 0) {
                *pkcs7 = 0x0000;
            } else {
                *pkcs7 = kCCOptionPKCS7Padding;
            }
        }
    } else if(encryptOrDecrypt != kCCDecrypt) {
        NSLog(@"Invalid CCOperation parameter [%d] for cipher 3DES context.", *pkcs7 );
    } 
	
    // Create and Initialize the crypto reference.
    ccStatus = CCCryptorCreate(encryptOrDecrypt,
                               kCCAlgorithm3DES,
                               *pkcs7 + kCCOptionECBMode,
                               (const void *)[aSymmetricKey bytes],
                               k3DESKeySize,
                               (const void *)iv,
                               &thisEncipher
                               );
	
	
	//LOGGING_FACILITY1( ccStatus == kCCSuccess, @"Problem creating the context, ccStatus == %d.", ccStatus );
	
    // Calculate byte block alignment for all calls through to and including final.
    bufferPtrSize = CCCryptorGetOutputLength(thisEncipher, plainTextBufferSize, true);
	
    // Allocate buffer.
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t) );
	
    // Zero out buffer.
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
	
    // Initialize some necessary book keeping.
	
    ptr = bufferPtr;
	
    // Set up initial size.
    remainingBytes = bufferPtrSize;
	
    // Actually perform the encryption or decryption.
    ccStatus = CCCryptorUpdate(thisEncipher,
                               (const void *) [plainText bytes],
                               plainTextBufferSize,
                               ptr,
                               remainingBytes,
                               &movedBytes
                               );
	
	//LOGGING_FACILITY1( ccStatus == kCCSuccess, @"Problem with CCCryptorUpdate, ccStatus == %d.", ccStatus );
	
    // Handle book keeping.
    ptr += movedBytes;
    remainingBytes -= movedBytes;
    totalBytesWritten += movedBytes;
	
    // Finalize everything to the output buffer.
    ccStatus = CCCryptorFinal(thisEncipher,
                              ptr,
                              remainingBytes,
                              &movedBytes
                              );
	
    totalBytesWritten += movedBytes;
	
    if(thisEncipher) {
        (void) CCCryptorRelease(thisEncipher);
        thisEncipher = NULL;
    }
	
    //LOGGING_FACILITY1( ccStatus == kCCSuccess, @"Problem with encipherment ccStatus == %d", ccStatus );
	
    if (ccStatus == kCCSuccess)
        cipherOrPlainText = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)totalBytesWritten];
    else
        cipherOrPlainText = nil;
	
    if(bufferPtr) free(bufferPtr);
	
    return cipherOrPlainText;
}

//- (NSData*) doCipherRSA:(NSData *)plainText key:(NSData *)aSymmetricKey
//			    context:(CCOperation)encryptOrDecrypt padding:(CCOptions *)pkcs7{
//	
//	SSCrypto *crypto;
//	
//	if(encryptOrDecrypt == kCCEncrypt) {
//		crypto = [[[SSCrypto alloc] initWithPublicKey:aSymmetricKey privateKey:privateKeyData] autorelease];
//		
//		[crypto setClearTextWithData:plainText];
//		
//		return [crypto encrypt];
//	}
//	else {
//		crypto = [[[SSCrypto alloc] initWithPublicKey:publicKeyData privateKey:aSymmetricKey] autorelease];
//		
//		[crypto setCipherText:plainText];
//		
//		return [crypto decrypt];
//	}
//}

- (NSData*) encrypt:(NSData *)plainText Algorithm:(EncryptAlgorithm)alg key:(NSData *)aSymmetricKey padding:(CCOptions *)pkcs7
{
	if (alg == AlgorithmAES128) {
		return [self doCipherAES128:plainText key:aSymmetricKey context:kCCEncrypt padding:pkcs7];
	}
//	else if (alg == AlgorithmAES256){
//		return [self doCipherAES256:plainText key:aSymmetricKey context:kCCEncrypt padding:pkcs7];
//	}
	else if (alg == AlgorithmDES){
		return [self doCipherDES:plainText key:aSymmetricKey context:kCCEncrypt padding:pkcs7];
	}
	else if (alg == Algorithm3DES){
		return [self doCipher3DES:plainText key:aSymmetricKey context:kCCEncrypt padding:pkcs7];
	}
//	else if (alg == AlgorithmRSA){
//		return [self doCipherRSA:plainText key:aSymmetricKey context:kCCEncrypt padding:pkcs7];
//	}
	else {
		return [self doCipherDES:plainText key:aSymmetricKey context:kCCEncrypt padding:pkcs7];
	}
}

- (NSData*) decrypt:(NSData *)plainText Algorithm:(EncryptAlgorithm)alg key:(NSData *)aSymmetricKey padding:(CCOptions *)pkcs7
{
    if (alg == AlgorithmAES128) {
		return [self doCipherAES128:plainText key:aSymmetricKey context:kCCDecrypt padding:pkcs7];
	}
//	else if (alg == AlgorithmAES256) {
//		return [self doCipherAES256:plainText key:aSymmetricKey context:kCCDecrypt padding:pkcs7];
//	}
	else if (alg == AlgorithmDES){
		return [self doCipherDES:plainText key:aSymmetricKey context:kCCDecrypt padding:pkcs7];
	}
	else if (alg == Algorithm3DES){
		return [self doCipher3DES:plainText key:aSymmetricKey context:kCCDecrypt padding:pkcs7];
	}
//	else if (alg == AlgorithmRSA){
//		return [self doCipherRSA:plainText key:aSymmetricKey context:kCCDecrypt padding:pkcs7];
//	}
	else {
		return [self doCipherDES:plainText key:aSymmetricKey context:kCCDecrypt padding:pkcs7];
	}
}

- (void) encryptFile:(NSString*)strSourceFile TargetFile:(NSString*)strTargetFile 
		   Algorithm:(EncryptAlgorithm)alg key:(NSData *)aSymmetricKey padding:(CCOptions *)pkcs7{
	//从文件读取
	NSData *plainText = [NSData dataWithContentsOfFile:strSourceFile];
	
	//加密
	NSData *encryptedData = [self encrypt:plainText Algorithm:alg key:aSymmetricKey padding:pkcs7];
	
	//写入目标文件
	[encryptedData writeToFile:strTargetFile atomically:YES];
}

- (void) decryptFile:(NSString*)strSourceFile TargetFile:(NSString*)strTargetFile 
		   Algorithm:(EncryptAlgorithm)alg key:(NSData *)aSymmetricKey padding:(CCOptions *)pkcs7{
	//从文件读取
	NSData *plainText = [NSData dataWithContentsOfFile:strSourceFile];
	
	//解密
	NSData *encryptedData = [self decrypt:plainText Algorithm:alg key:aSymmetricKey padding:pkcs7];
	
	//写入目标文件
	[encryptedData writeToFile:strTargetFile atomically:YES];
}

- (NSString*) doCipherDESBase64FromString:(NSString*)inPut key:(NSString *)key
{
	[self setSymmetricKeyData:[self getSymmetricKeyFromString:key]];
	NSData *encryptedData = [self encrypt:[inPut dataUsingEncoding:NSUTF8StringEncoding] 
                                Algorithm:AlgorithmDES key:symmetricKeyData padding:&encryptPadding];
    NSString *strText = [GTMBase64 stringByEncodingData:encryptedData];
	return strText;
}

@end
