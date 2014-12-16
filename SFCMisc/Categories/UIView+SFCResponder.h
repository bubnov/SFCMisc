//
//  UIView+SFCResponder.h
//  SFCMisc
//
//  Created by Paul Taykalo on 7/13/10.
//  Copyright 2010 Stanfy. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface  UIView (SFCResponder) 

/**
 Finds and resigns first responder in view hierarchy.
 Use this for dismiss keyboard, when simple resignFirstReponder is not works
 */
- (BOOL)sfc_findAndResignFirstResponder;

/**
 Check if current view has first responder
 */
- (BOOL)sfc_hasFirstResponder;

/**
 Return first responder for view
 @return UIResponder or nil
 */
- (UIResponder *)sfc_findFirstResponder;

/**
 Returns sfc_viewController, that attached for this view
 */
- (UIViewController *)sfc_viewController;

/**
 Find nearest view controller with navigation controller
 */
- (UIViewController *)sfc_findControllerWithNavigationController;
- (UIViewController *)sfc_findControllerWithNavigationController:(BOOL)logProcess;

@end
