//
//  NSData+SFCDigest.h
//  SFCMisc
//
//  Created by Slavik Bubnov on 03.03.12.
//  Copyright (c) 2012 Slavik Bubnov, bubnovslavik@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSData (SFCDigest)

/**
 Calculate the md5 hash of this data using CC_MD5.
 @return md5 hash of this data
 */
@property (readonly, nonatomic) NSString *sfc_md5Hash;

/**
 Calculate the SHA1 hash of this data using CC_SHA1.
 @return SHA1 hash of this data
 */
@property (readonly, nonatomic) NSString *sfc_sha1Hash;

/**
 AES 256
 http://stackoverflow.com/questions/1400246/aes-encryption-for-an-nsstring-on-the-iphone/1400596#1400596
 */
- (NSData *)sfc_AES256EncryptWithKey:(NSString *)key;
- (NSData *)sfc_AES256DecryptWithKey:(NSString *)key;

@end
