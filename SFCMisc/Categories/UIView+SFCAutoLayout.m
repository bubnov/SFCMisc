//
//  UIView+SFCAutoLayout.m
//  SFCMisc
//
//  Created by v.bubnov on 13.08.13.
//  Copyright (c) 2013 bubnovslavik@gmail.com. All rights reserved.
//

/**
 Read:
 http://iosdevelopmentjournal.com/blog/2013/04/22/alignment-options-in-auto-laytout/
 http://www.techotopia.com/index.php/Understanding_the_iOS_6_Auto_Layout_Visual_Format_Language
 */

#import "UIView+SFCAutoLayout.h"


@implementation UIView (SFCAutoLayout)

- (NSArray *)sfc_addConstraintsWithFormat:(NSString *)format {
   return [self sfc_addConstraintsWithFormats:(format ? @[format] : nil) options:0 metrics:nil views:nil];
}


- (NSArray *)sfc_addConstraintsWithFormats:(NSArray *)formats {
   return [self sfc_addConstraintsWithFormats:formats options:0 metrics:nil views:nil];
}


- (NSArray *)sfc_addConstraintsWithFormat:(NSString *)format views:(NSDictionary *)views {
   return [self sfc_addConstraintsWithFormats:(format ? @[format] : nil) options:0 metrics:nil views:views];
}


- (NSArray *)sfc_addConstraintsWithFormats:(NSArray *)formats views:(NSDictionary *)views {
   return [self sfc_addConstraintsWithFormats:formats options:0 metrics:nil views:views];
}


- (NSArray *)sfc_addConstraintsWithFormat:(NSString *)format options:(NSLayoutFormatOptions)options views:(NSDictionary *)views {
   return [self sfc_addConstraintsWithFormats:(format ? @[format] : nil) options:options metrics:nil views:views];
}


- (NSArray *)sfc_addConstraintsWithFormat:(NSString *)format metrics:(NSDictionary *)metrics views:(NSDictionary *)views {
   return [self sfc_addConstraintsWithFormats:(format ? @[format] : nil) options:0 metrics:metrics views:views];
}


- (NSArray *)sfc_addConstraintsWithFormats:(NSArray *)formats options:(NSLayoutFormatOptions)options views:(NSDictionary *)views {
   return [self sfc_addConstraintsWithFormats:formats options:options metrics:nil views:views];
}


- (NSArray *)sfc_addConstraintsWithFormat:(NSString *)format options:(NSLayoutFormatOptions)options metrics:(NSDictionary *)metrics views:(NSDictionary *)views {
   return [self sfc_addConstraintsWithFormats:(format ? @[format] : nil) options:options metrics:metrics views:views];
}


- (NSArray *)sfc_addConstraintsWithFormats:(NSArray *)formats metrics:(NSDictionary *)metrics views:(NSDictionary *)views {
   return [self sfc_addConstraintsWithFormats:formats options:0 metrics:metrics views:views];
}


- (NSArray *)sfc_addConstraintsWithFormats:(NSArray *)formats options:(NSLayoutFormatOptions)options metrics:(NSDictionary *)metrics views:(NSDictionary *)views {
   if ( ! formats || ! [formats count]) {
      return nil;
   }
   
   if ([views count]) {
      for (UIView *view in [views allValues]) {
         if ([view isKindOfClass:[UIView class]]) {
            view.translatesAutoresizingMaskIntoConstraints = NO;
         }
      }
   }
   
   NSMutableDictionary *mutableViews = [views isKindOfClass:[NSMutableDictionary class]] ? views : [views mutableCopy];
   [mutableViews setObject:self forKey:@"self"];
   
   NSMutableArray *allConstraints = [NSMutableArray array];
   for (NSString *format in formats) {
      NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:options metrics:metrics views:mutableViews];
      [allConstraints addObjectsFromArray:constraints];
   }
   
   [self addConstraints:allConstraints];
   
   return allConstraints;
}


- (NSLayoutConstraint *)sfc_addConstraintWithItem:(UIView *)view1
                                    attribute:(NSLayoutAttribute)attr1
                                    relatedBy:(NSLayoutRelation)relation
                                       toItem:(UIView *)view2
                                    attribute:(NSLayoutAttribute)attr2
                                   multiplier:(CGFloat)multiplier
                                     constant:(CGFloat)c
{
   view1.translatesAutoresizingMaskIntoConstraints = NO;
   NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:view1
                                                                 attribute:attr1
                                                                 relatedBy:relation
                                                                    toItem:view2
                                                                 attribute:attr2
                                                                multiplier:multiplier
                                                                  constant:c];
   [self addConstraint:constraint];
   return constraint;
}

@end