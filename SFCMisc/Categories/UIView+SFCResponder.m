//
//  UIView+SFCResponder.m
//  SFCMisc
//
//  Created by Paul Taykalo on 7/13/10.
//  Copyright 2010 Stanfy. All rights reserved.
//

#import "UIView+SFCResponder.h"


@implementation UIView (SFCResponder)

- (UIResponder *)sfc_findFirstResponder {
   if (self.isFirstResponder) {
      return self;
   }
   
   for (UIView *subView in self.subviews) {
      UIResponder *firstResponder = [subView sfc_findFirstResponder];
      if (firstResponder) {
         return firstResponder;
      }
   }
   
   return nil;
}


- (BOOL)sfc_findAndResignFirstResponder {
   UIResponder *firstResponder = [self sfc_findFirstResponder];
   if (firstResponder) {
      [firstResponder resignFirstResponder];
      return YES;
   }
   return NO;
}


- (BOOL)sfc_hasFirstResponder {
   return ([self sfc_findFirstResponder] != nil);
}


#pragma mark -

- (UIViewController *)sfc_viewController {
   id nextResponder = [self nextResponder];
   if ([nextResponder isKindOfClass:[UIViewController class]]) {
      return nextResponder;
   } else {
      return nil;
   }
}


- (UIViewController *)sfc_findControllerWithNavigationController:(BOOL)logProcess {
   UIViewController *controller = [self sfc_viewController];
   if (logProcess) NSLog(@"view: %@", self);
   
   if (controller) {
      if (controller.navigationController) {
         if (logProcess) NSLog(@"controller: %@", controller);
         return controller;
      } else {
         UIView *superView = [self superview];
         if (superView) {
            return [superView sfc_findControllerWithNavigationController:logProcess];
         }
      }
   }
   
   if (logProcess) NSLog(@"controller not found!");
   return nil;
}


- (UIViewController *)sfc_findControllerWithNavigationController {
   return [self sfc_findControllerWithNavigationController:NO];
}

@end