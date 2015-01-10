//
//  UIView+SFCAutoLayout.h
//  SFCMisc
//
//  Created by Bubnov Slavik on 13.08.13.
//  Copyright (c) 2013 bubnovslavik@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>


#define SFV2D(...)   NSDictionaryOfVariableBindings(__VA_ARGS__)


@interface UIView (SFCAutoLayout)

- (NSArray *)sfc_addConstraintsWithFormat:(NSString *)format;
- (NSArray *)sfc_addConstraintsWithFormat:(NSString *)format views:(NSDictionary *)views;
- (NSArray *)sfc_addConstraintsWithFormat:(NSString *)format options:(NSLayoutFormatOptions)options views:(NSDictionary *)views;
- (NSArray *)sfc_addConstraintsWithFormat:(NSString *)format metrics:(NSDictionary *)metrics views:(NSDictionary *)views;
- (NSArray *)sfc_addConstraintsWithFormat:(NSString *)format options:(NSLayoutFormatOptions)options metrics:(NSDictionary *)metrics views:(NSDictionary *)views;

- (NSArray *)sfc_addConstraintsWithFormats:(NSArray *)formats;
- (NSArray *)sfc_addConstraintsWithFormats:(NSArray *)formats views:(NSDictionary *)views;
- (NSArray *)sfc_addConstraintsWithFormats:(NSArray *)formats options:(NSLayoutFormatOptions)options views:(NSDictionary *)views;
- (NSArray *)sfc_addConstraintsWithFormats:(NSArray *)formats metrics:(NSDictionary *)metrics views:(NSDictionary *)views;
- (NSArray *)sfc_addConstraintsWithFormats:(NSArray *)formats options:(NSLayoutFormatOptions)options metrics:(NSDictionary *)metrics views:(NSDictionary *)views;

- (NSLayoutConstraint *)sfc_addConstraintWithItem:(UIView *)view1
                                    attribute:(NSLayoutAttribute)attr1
                                    relatedBy:(NSLayoutRelation)relation
                                       toItem:(UIView *)view2
                                    attribute:(NSLayoutAttribute)attr2
                                   multiplier:(CGFloat)multiplier
                                     constant:(CGFloat)c;

@end
