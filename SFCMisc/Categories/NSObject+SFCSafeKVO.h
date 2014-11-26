//
//  NSObject+SFCSafeKVO.h
//  SFCMisc
//
//  Created by bubnovslavik@gmail.com on 13.02.13.
//  Copyright (c) 2013 Bubnov Slavik, bubnovslavik@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SFCKVOBlock)(NSString *keyPath, id object, NSDictionary *change);

@interface NSObject (SFCSafeKVO)

- (void)sfc_observeKeyPath:(NSString *)keyPath block:(SFCKVOBlock)block;
- (void)sfc_observeKeyPaths:(NSArray *)keyPaths block:(SFCKVOBlock)block;
- (void)sfc_observeKeyPath:(NSString *)keyPath block:(SFCKVOBlock)block token:(NSString *)token;
- (void)sfc_observeKeyPaths:(NSArray *)keyPaths block:(SFCKVOBlock)block token:(NSString *)token;
- (void)sfc_observeKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options block:(SFCKVOBlock)block token:(NSString *)token;
- (void)sfc_observeKeyPaths:(NSArray *)keyPaths options:(NSKeyValueObservingOptions)options block:(SFCKVOBlock)block token:(NSString *)token;
- (void)sfc_removeObserverWithToken:(NSString *)token;

@end