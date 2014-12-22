//
//  NSString+SFCExtends.m
//  SFCMisc
//
//  Created by Slavik Bubnov on 12/2/10.
//  Copyright 2010 Slavik Bubnov, bubnovslavik@gmail.com. All rights reserved.
//

#import "NSString+SFCExtends.h"


@implementation NSString (SFCExtends)

+ (NSString *)sfc_stringByRepeatingString:(NSString *)string count:(NSInteger)count {
   NSMutableString *resultString = [NSMutableString string];
   for (int i = 0; i < count; i++) {
      [resultString appendString:string];
   }
   return resultString;
}


+ (NSString *)sfc_stringFromObjects:(id)object, ... {
   va_list args;
   va_start(args, object);
   
   // Get object's string value if it is not a string
   if ( ! [object isKindOfClass:[NSString class]]) {
      object = [object stringValue];
   }
   
   // Init result string with first object
   NSMutableString *string = [NSMutableString stringWithString:object];
   
   // Append other objects
   id nextObject;
   while ((nextObject = va_arg(args, id))) {
      // Get object's string value if it is not a string
      if ( ! [nextObject isKindOfClass:[NSString class]]) {
         nextObject = [nextObject stringValue];
      }
      [string appendString:(NSString *)nextObject];
   }
   
   va_end(args);
   
   return string;
}


- (BOOL)sfc_isEqualToAnyStringFromArray:(NSArray *)strings {
   for (NSString *stringToMatch in strings) {
      if ([self isEqualToString:stringToMatch]) {
         return YES;
      }
   }
   return NO;
}


- (BOOL)sfc_isEqualToAnyString:(NSString *)string, ... {
   va_list args;
   va_start(args, string);
   
   // Check first string
   if ([self isEqualToString:string]) {
      va_end(args);
      return YES;
   }
   
   // Check other strings
   id nextString;
   while ((nextString = va_arg(args, id))) {
      if ([self isEqualToString:nextString]) {
         va_end(args);
         return YES;
      }
   }
   
   va_end(args);
   return NO;
}


#pragma mark -

- (NSString *)sfc_addPercentEscapes {
   return [self sfc_addPercentEscapesWithEncoding:NSUTF8StringEncoding];
}


- (NSString *)sfc_addPercentEscapesWithEncoding:(NSStringEncoding)encoding {
   return [self sfc_addPercentEscapesWithEncoding:encoding characters:@"!*'\"();:@&=+$,/?%#[]% "];
}


- (NSString *)sfc_addPercentEscapesWithEncoding:(NSStringEncoding)encoding characters:(NSString *)characters {
   if ( ! characters) {
      return self;
   }
   
   CFStringEncoding cfEncoding = CFStringConvertNSStringEncodingToEncoding(encoding);
   NSString *encodedString = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                                   (__bridge CFStringRef)self,
                                                                                                   NULL,
                                                                                                   (__bridge CFStringRef)characters,
                                                                                                   cfEncoding);
   return encodedString;
}


#pragma mark -

- (NSString *)sfc_capitalizeFirstLetter {
   if ( ! [self length]) {
      return self;
   }
   return [[[self substringToIndex:1] uppercaseString] stringByAppendingString:[self substringFromIndex:1]];
}


#pragma mark - Regex

- (NSString *)sfc_replaceOccurrencesOfRegex:(NSString *)regex withString:(NSString *)replacement {
   if ( ! regex || ! replacement) {
      return self;
   }
   return [self stringByReplacingOccurrencesOfString:regex
                                          withString:replacement
                                             options:NSRegularExpressionSearch|NSCaseInsensitiveSearch
                                               range:NSMakeRange(0, [self length])];
}


- (BOOL)sfc_matchedByRegex:(NSString *)regex {
   NSRange range = [self rangeOfString:regex
                               options:NSRegularExpressionSearch|NSCaseInsensitiveSearch];
   
   return (range.location != NSNotFound);
}


- (NSString *)sfc_searchWithRegex:(NSString *)regex {
   NSRange range = NSMakeRange(0, [self length]);
   return [self sfc_searchWithRegex:regex range:range];
}


- (NSString *)sfc_searchWithRegex:(NSString *)regex range:(NSRange)range {
   NSRange resultRange = [self rangeOfString:regex options:(NSRegularExpressionSearch | NSCaseInsensitiveSearch) range:range];
   if (resultRange.location != NSNotFound) {
      return [self substringWithRange:resultRange];
   }
   return nil;
}


- (NSArray *)sfc_searchAllWithRegex:(NSString *)regex {
   NSRange range = NSMakeRange(0, [self length]);
   return [self sfc_searchAllWithRegex:regex range:range];
}


- (NSArray *)sfc_searchAllWithRegex:(NSString *)regex range:(NSRange)range {
   NSMutableArray *substrings = [NSMutableArray array];
   
   NSRange resultRange = [self rangeOfString:regex options:(NSRegularExpressionSearch | NSCaseInsensitiveSearch) range:range];
   if (resultRange.location != NSNotFound) {
      NSString *substring = [self substringWithRange:resultRange];
      if (substring) {
         [substrings addObject:substring];
      }
      
      // Search next substrings
      NSInteger nextLocation = resultRange.location + resultRange.length;
      if (nextLocation < [self length] - 1) {
         NSRange nextRange = NSMakeRange(nextLocation, [self length] - nextLocation);
         [substrings addObjectsFromArray:[self sfc_searchAllWithRegex:regex range:nextRange]];
      }
   }
   
   return [substrings count] ? [substrings copy] : nil;
}

@end
