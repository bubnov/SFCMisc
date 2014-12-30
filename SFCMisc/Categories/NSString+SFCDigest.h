//
//  NSString+SFCDigest.h
//  SFCMisc
//
//  Created by Slavik Bubnov on 03.03.12.
//  Copyright (c) 2012 Slavik Bubnov, bubnovslavik@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (SFCDigest)

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
 Apply XOR to string with key
 @return NSString
 */
- (NSString *)sfc_XORWithKey:(NSString *)key;

- (NSString *)sfc_AES256EncryptWithKey:(NSString *)key;
- (NSString *)sfc_AES256DecryptWithKey:(NSString *)key;

@end
