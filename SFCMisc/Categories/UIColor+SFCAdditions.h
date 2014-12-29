//
//  UIColor+SFCAdditions.h
//  SFCMisc
//
//  Taken from Three20
//
//  Created by Slavik Bubnov on 02.11.11.
//  Copyright (c) 2011 Slavik Bubnov, bubnovslavik@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 Macroses
 */
#define  RGBCOLOR(r,g,b)      [UIColor sfc_colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define  RGBACOLOR(r,g,b,a)   [UIColor sfc_colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define  HSVCOLOR(h,s,v)      [UIColor sfc_colorWithHue:(h) saturation:(s) value:(v) alpha:1]
#define  HSVACOLOR(h,s,v,a)   [UIColor sfc_colorWithHue:(h) saturation:(s) value:(v) alpha:(a)]
#define  RGBA(r,g,b,a)        (r)/255.0f, (g)/255.0f, (b)/255.0f, (a)


@interface UIColor (SFСAdditions)

@property (readonly) CGFloat sfc_hue;
@property (readonly) CGFloat sfc_saturation;
@property (readonly) CGFloat sfc_value;

/**
 Accepted ranges:
   hue: 0.0 - 360.0
 saturation: 0.0 - 1.0
   value: 0.0 - 1.0
   alpha: 0.0 - 1.0
 */
+ (UIColor *)sfc_colorWithHue:(CGFloat)h saturation:(CGFloat)s value:(CGFloat)v alpha:(CGFloat)a;

/**
 Creates color from hex string in format
 #ffaabb:70%
 #ffaabb
 ffbbaa
 */
+ (UIColor *)sfc_colorWithHexString:(NSString *)hexString;

/**
 Accepted ranges:
   hue: 0.0 - 1.0
 saturation: 0.0 - 1.0
   value: 0.0 - 1.0
 */
- (UIColor *)sfc_multiplyHue:(CGFloat)hd saturation:(CGFloat)sd value:(CGFloat)vd;
- (UIColor *)sfc_addHue:(CGFloat)hd saturation:(CGFloat)sd value:(CGFloat)vd;

@end
