//
//  UIColor+SFCAdditions.m
//  SFCMisc
//
//  Taken from Three20
//
//  Created by Slavik Bubnov on 02.11.11.
//  Copyright (c) 2011 Slavik Bubnov, bubnovslavik@gmail.com. All rights reserved.
//

#import "UIColor+SFCAdditions.h"

/**
 Color algorithms from http://www.cs.rit.edu/~ncs/color/t_convert.html
 */
#define  MAX3(a,b,c)    (a > b ? (a > c ? a : c) : (b > c ? b : c))
#define  MIN3(a,b,c)    (a < b ? (a < c ? a : c) : (b < c ? b : c))

static void RGBtoHSV(CGFloat r, CGFloat g, CGFloat b, CGFloat* h, CGFloat* s, CGFloat* v) {
  CGFloat min, max, delta;
  min = MIN3(r, g, b);
  max = MAX3(r, g, b);
  *v = max;        // v
  delta = max - min;
  if ( max != 0 )
    *s = delta / max;    // s
  else {
    // r = g = b = 0    // s = 0, v is undefined
    *s = 0;
    *h = -1;
    return;
  }
  if ( r == max )
    *h = ( g - b ) / delta;    // between yellow & magenta
  else if ( g == max )
    *h = 2 + ( b - r ) / delta;  // between cyan & yellow
  else
    *h = 4 + ( r - g ) / delta;  // between magenta & cyan
  *h *= 60;        // degrees
  if ( *h < 0 )
    *h += 360;
}


static void HSVtoRGB( CGFloat *r, CGFloat *g, CGFloat *b, CGFloat h, CGFloat s, CGFloat v ) {
  int i;
  CGFloat f, p, q, t;
  if ( s == 0 ) {
    // achromatic (grey)
    *r = *g = *b = v;
    return;
  }
  h /= 60;      // sector 0 to 5
  i = floor( h );
  f = h - i;      // factorial part of h
  p = v * ( 1 - s );
  q = v * ( 1 - s * f );
  t = v * ( 1 - s * ( 1 - f ) );
  switch( i ) {
    case 0:
      *r = v;
      *g = t;
      *b = p;
      break;
    case 1:
      *r = q;
      *g = v;
      *b = p;
      break;
    case 2:
      *r = p;
      *g = v;
      *b = t;
      break;
    case 3:
      *r = p;
      *g = q;
      *b = v;
      break;
    case 4:
      *r = t;
      *g = p;
      *b = v;
      break;
    default:    // case 5:
      *r = v;
      *g = p;
      *b = q;
      break;
  }
}



@implementation UIColor (SFCCategory)

+ (UIColor *)sfc_colorWithHue:(CGFloat)h saturation:(CGFloat)s value:(CGFloat)v alpha:(CGFloat)a {
  CGFloat r, g, b;
  HSVtoRGB(&r, &g, &b, h, s, v);
  return [UIColor colorWithRed:r green:g blue:b alpha:a];
}


- (UIColor *)sfc_multiplyHue:(CGFloat)hd saturation:(CGFloat)sd value:(CGFloat)vd {
  const CGFloat *rgba = CGColorGetComponents(self.CGColor);
  CGFloat r = rgba[0];
  CGFloat g = rgba[1];
  CGFloat b = rgba[2];
  CGFloat a = rgba[3];

  CGFloat h, s, v;
  RGBtoHSV(r, g, b, &h, &s, &v);

  h *= hd;
  v *= vd;
  s *= sd;

  HSVtoRGB(&r, &g, &b, h, s, v);

  return [UIColor colorWithRed:r green:g blue:b alpha:a];
}


- (UIColor *)sfc_addHue:(CGFloat)hd saturation:(CGFloat)sd value:(CGFloat)vd {
  const CGFloat *rgba = CGColorGetComponents(self.CGColor);
  CGFloat r = rgba[0];
  CGFloat g = rgba[1];
  CGFloat b = rgba[2];
  CGFloat a = rgba[3];

  CGFloat h, s, v;
  RGBtoHSV(r, g, b, &h, &s, &v);

  h += hd;
  v += vd;
  s += sd;

  HSVtoRGB(&r, &g, &b, h, s, v);

  return [UIColor colorWithRed:r green:g blue:b alpha:a];
}


- (CGFloat)sfc_hue {
  const CGFloat *rgba = CGColorGetComponents(self.CGColor);
  CGFloat h, s, v;
  RGBtoHSV(rgba[0], rgba[1], rgba[2], &h, &s, &v);
  return h;
}


- (CGFloat)sfc_saturation {
  const CGFloat *rgba = CGColorGetComponents(self.CGColor);
  CGFloat h, s, v;
  RGBtoHSV(rgba[0], rgba[1], rgba[2], &h, &s, &v);
  return s;
}


- (CGFloat)sfc_value {
  const CGFloat *rgba = CGColorGetComponents(self.CGColor);
  CGFloat h, s, v;
  RGBtoHSV(rgba[0], rgba[1], rgba[2], &h, &s, &v);
  return v;
}


+ (UIColor *)sfc_colorWithHexString:(NSString *)stringValue {
   UIColor  *result = nil;

   if (! stringValue || ! [stringValue length]) {
      return [UIColor clearColor];
   }

   CGFloat alpha = 1.0;
   if ([stringValue rangeOfString:@":"].location != NSNotFound) {
      NSString *alphaSubString = [stringValue substringFromIndex:[stringValue rangeOfString:@":"].location];
      alphaSubString = [alphaSubString stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"%:"]];
      if (alphaSubString && [alphaSubString length]) {
         alpha = (CGFloat) ([alphaSubString doubleValue] / 100.0);
      }
   }

   NSScanner *scanner = [NSScanner scannerWithString:[stringValue stringByReplacingOccurrencesOfString:@"#" withString:@""]];
   unsigned int baseColor;
   [scanner scanHexInt:&baseColor];
   CGFloat red = ((baseColor & 0xFF0000) >> 16) / 255.0f;
   CGFloat green = ((baseColor & 0x00FF00) >> 8) / 255.0f;
   CGFloat blue = (baseColor & 0x0000FF) / 255.0f;
   result = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
   return result;
}


@end
