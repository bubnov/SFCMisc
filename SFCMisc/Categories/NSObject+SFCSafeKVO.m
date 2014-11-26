//
//  NSObject+SFCSafeKVO.m
//  SFCMisc
//
//  Created by bubnovslavik@gmail.com on 13.02.13.
//  Copyright (c) 2013 Bubnov Slavik, bubnovslavik@gmail.com. All rights reserved.
//

#import "NSObject+SFCSafeKVO.h"
#import "NSObject+SFCDescription.h"
#import "SFCRuntime.h"


@interface SFCKVOProxyObserver : NSObject

@property (copy, nonatomic) SFCKVOBlock block;
@property (copy, nonatomic) NSString *token;
@property (copy, nonatomic) NSString *keyPath;
@property (assign, nonatomic) NSObject *target;

+ (instancetype)observerWithTarget:(NSObject *)target keyPath:(NSString *)keyPath block:(SFKVOBlock)block token:(NSString *)token;

@end


@implementation SFCKVOProxyObserver

+ (instancetype)observerWithTarget:(NSObject *)target keyPath:(NSString *)keyPath block:(SFCKVOBlock)block token:(NSString *)token {
   SFCKVOProxyObserver *observer = [self new];
   observer.target = target;
   observer.keyPath = keyPath;
   observer.block = block;
   observer.token = token;
   return observer;
}


- (NSString *)description {
   return [NSString stringWithFormat:@"<%@ %p keyPath='%@' token='%@' target=%@ block=%@>",
           [self class],
           self,
           self.keyPath,
           self.token,
           [self.target sfc_shortDescription],
           self.block];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
   if (self.block) {
      self.block(keyPath, object, change);
   }
}


- (void)startObserving {
   if (self.target && self.keyPath) {
      [self.target addObserver:self forKeyPath:self.keyPath options:NSKeyValueObservingOptionNew context:nil];
   }
}


- (void)stopObserving {
   if (self.target && self.keyPath) {
      if ([self.target isKindOfClass:[NSOperation class]]) return;
      [self.target removeObserver:self forKeyPath:self.keyPath];
   }
}

@end



#pragma mark -

@implementation NSObject (SFCSafeKVO)

const char * _kSFCKVOProxyObserversKey;


- (void)sfc_observeKeyPath:(NSString *)keyPath block:(SFCKVOBlock)block {
   [self sfc_observeKeyPath:keyPath block:block token:nil];
}


- (void)sfc_observeKeyPaths:(NSArray *)keyPaths block:(SFCKVOBlock)block {
   [keyPaths enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
      [self sfc_observeKeyPath:obj block:block];
   }];
}


- (void)sfc_observeKeyPath:(NSString *)keyPath block:(SFCKVOBlock)block token:(NSString *)token {
   [self sfc_observeKeyPath:keyPath options:NSKeyValueObservingOptionNew block:block token:token];
}


- (void)sfc_observeKeyPaths:(NSArray *)keyPaths block:(SFCKVOBlock)block token:(NSString *)token {
   [keyPaths enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
      [self sfc_observeKeyPath:obj options:NSKeyValueObservingOptionNew block:block token:token];
   }];
}


- (void)sfc_observeKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options block:(SFCKVOBlock)block token:(NSString *)token {
   if ( ! keyPath || ! block) {
      return;
   }
   
   // Swizzled dealloc method once
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
      [SFCRuntime swizzleSelector:NSSelectorFromString(@"dealloc")
                     withSelector:@selector(_sfcKVODeallocSwizzled)
                    atObjectClass:[NSObject class]];
   });
   
   @synchronized(self) {
      // Get proxy observers array
      NSMutableArray *observers = objc_getAssociatedObject(self, &_kSFCKVOProxyObserversKey);
      if ( ! observers) {
         observers = [NSMutableArray array];
         objc_setAssociatedObject(self, &_kSFCKVOProxyObserversKey, observers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
      }
      
      // Create proxy observer
      SFCKVOProxyObserver *observer = [self _observerWithToken:token inArray:observers];
      if ( ! observer) {
         SFCKVOProxyObserver *proxyObserver = [SFCKVOProxyObserver observerWithTarget:self keyPath:keyPath block:block token:token];
         [observers addObject:proxyObserver];
         [proxyObserver startObserving];
      }
   }
}


- (void)observeKeyPaths:(NSArray *)keyPaths options:(NSKeyValueObservingOptions)options block:(SFKVOBlock)block token:(NSString *)token {
   [keyPaths enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
      [self observeKeyPath:obj options:options block:block token:token];
   }];
}


- (void)_sfcKVODeallocSwizzled {
   // If object has proxy observers - remove them
   @autoreleasepool {
      NSArray *observers = objc_getAssociatedObject(self, &_kSFKVOProxyObserversKey);
      if (observers) {
         [observers makeObjectsPerformSelector:@selector(stopObserving)];
      }
   }
   
   [self _sfKVODeallocSwizzled];
}


- (SFCKVOProxyObserver *)_observerWithToken:(NSString *)token inArray:(NSArray *)observers {
   if ( ! token || ! observers) {
      return nil;
   }
   
   NSUInteger index = [observers indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
      SFCKVOProxyObserver *observer = obj;
      if ([observer.token isEqualToString:token]) {
         *stop = YES;
         return YES;
      }
      return NO;
   }];
   
   if (index != NSNotFound) {
      return [observers objectAtIndex:index];
   }
   
   return nil;
}


- (void)removeObserverWithToken:(NSString *)token {
   @synchronized(self) {
      NSMutableArray *observers = objc_getAssociatedObject(self, &_kSFKVOProxyObserversKey);
      if (observers) {
         SFKVOProxyObserver *observer = [self _observerWithToken:token inArray:observers];
         if (observer) {
            [observer stopObserving];
            [observers removeObject:observer];
         }
      }
   }
}

@end