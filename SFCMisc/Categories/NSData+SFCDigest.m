//
//  NSData+SFCDigest.m
//  SFCMisc
//
//  Created by Slavik Bubnov on 03.03.12.
//  Copyright (c) 2012 Slavik Bubnov, bubnovslavik@gmail.com. All rights reserved.
//

#import "NSData+SFCDigest.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>


@implementation NSData (SFCDigest)

- (NSString *)sfc_md5Hash {
   unsigned char result[CC_MD5_DIGEST_LENGTH];
   CC_MD5([self bytes], (CC_LONG)[self length], result);
   
   return [NSString stringWithFormat:
           @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
           result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
           result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]
           ];
}


- (NSString *)sfc_sha1Hash {
   unsigned char result[CC_SHA1_DIGEST_LENGTH];
   CC_SHA1([self bytes], (CC_LONG)[self length], result);
   
   return [NSString stringWithFormat:
           @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
           result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
           result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15],
           result[16], result[17], result[18], result[19]
           ];
}


- (NSData *)sfc_AES256EncryptWithKey:(NSString *)key {
   // 'key' should be 32 bytes for AES256, will be null-padded otherwise
   char keyPtr[kCCKeySizeAES256+1]; // room for terminator (unused)
   bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
   
   // fetch key data
   [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
   
   NSUInteger dataLength = [self length];
   
   //See the doc: For block ciphers, the output size will always be less than or
   //equal to the input size plus the size of one block.
   //That's why we need to add the size of one block here
   size_t bufferSize = dataLength + kCCBlockSizeAES128;
   void *buffer = malloc(bufferSize);
   
   size_t numBytesEncrypted = 0;
   CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                         keyPtr, kCCKeySizeAES256,
                                         NULL /* initialization vector (optional) */,
                                         [self bytes], dataLength, /* input */
                                         buffer, bufferSize, /* output */
                                         &numBytesEncrypted);
   if (cryptStatus == kCCSuccess) {
      //the returned NSData takes ownership of the buffer and will free it on deallocation
      return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
   }
   
   free(buffer); //free the buffer;
   return nil;
}


- (NSData *)sfc_AES256DecryptWithKey:(NSString *)key {
   // 'key' should be 32 bytes for AES256, will be null-padded otherwise
   char keyPtr[kCCKeySizeAES256+1]; // room for terminator (unused)
   bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
   
   // fetch key data
   [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
   
   NSUInteger dataLength = [self length];
   
   //See the doc: For block ciphers, the output size will always be less than or
   //equal to the input size plus the size of one block.
   //That's why we need to add the size of one block here
   size_t bufferSize = dataLength + kCCBlockSizeAES128;
   void *buffer = malloc(bufferSize);
   
   size_t numBytesDecrypted = 0;
   CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                         keyPtr, kCCKeySizeAES256,
                                         NULL /* initialization vector (optional) */,
                                         [self bytes], dataLength, /* input */
                                         buffer, bufferSize, /* output */
                                         &numBytesDecrypted);
   
   if (cryptStatus == kCCSuccess) {
      //the returned NSData takes ownership of the buffer and will free it on deallocation
      return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
   }
   
   free(buffer); //free the buffer;
   return nil;
}

@end
