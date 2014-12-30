//
//  NSString+SFCDigest.m
//  SFCMisc
//
//  Created by Slavik Bubnov on 03.03.12.
//  Copyright (c) 2012 Slavik Bubnov, bubnovslavik@gmail.com. All rights reserved.
//

#import "NSString+SFCDigest.h"
#import "NSData+SFCDigest.h"


@implementation NSString (SFDigest)

- (NSString *)sfc_md5Hash {
   return [[self dataUsingEncoding:NSUTF8StringEncoding] sfc_md5Hash];
}


- (NSString *)sha1Hash {
   return [[self dataUsingEncoding:NSUTF8StringEncoding] sfc_sha1Hash];
}


- (NSString *)sfc_XORWithKey:(NSString *)key {
   NSUInteger length = [self length];
   NSUInteger keyLength = [key length];
   
   unsigned char *bytes = (unsigned char *)[[self dataUsingEncoding:NSUTF8StringEncoding] bytes];
   unsigned char *keyBytes = (unsigned char *)[[key dataUsingEncoding:NSUTF8StringEncoding] bytes];
   
   for (int i = 0; i < length; i++) {
      bytes[i] ^= keyBytes[i % keyLength];
   }
   
   return [[NSString alloc] initWithBytes:bytes length:length encoding:NSUTF8StringEncoding];
}


- (NSString *)sfc_AES256EncryptWithKey:(NSString *)key {
   NSData *data = [[self dataUsingEncoding:NSUTF8StringEncoding] sfc_AES256EncryptWithKey:key];
   return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}


- (NSString *)sfc_AES256DecryptWithKey:(NSString *)key {
   NSData *data = [[self dataUsingEncoding:NSUTF8StringEncoding] sfc_AES256DecryptWithKey:key];
   return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end
