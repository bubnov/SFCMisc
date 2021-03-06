//
//  UIView+SFCAdditions.h
//  SFCMisc
//
//  Created by Slavik Bubnov on 02.11.11.
//  Copyright (c) 2011 Slavik Bubnov, bubnovslavik@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 Add similar useful getters and setters to UIView, like in Three20
 Used to have ability to use this methods in frameworks projects, 
 without adding Three20 sources.
 */
@interface UIView (SFCAdditions)

/**
 Handy getters and setters
 */
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGSize size;

- (CGPoint)localCenter;

/**
 Tries to find reciever's superview with certain class (recursive)
 */
- (UIView *)findSuperviewWithClass:(Class)cls;

@end
