//
//  NSString+SFCExtends.h
//  SFCMisc
//
//  Created by Slavik Bubnov on 12/2/10.
//  Copyright 2010 Slavik Bubnov, bubnovslavik@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Alias macros for +stringFromObjects: method
 */
#define __s(c, ...) [NSString sfc_stringFromObjects:c, ##__VA_ARGS__, nil]


@interface NSString (SFCExtends)

/**
 Create and return string by repeating |string| |count| times
 */
+ (NSString *)sfc_stringByRepeatingString:(NSString *)string count:(NSInteger)count;

/**
 Compile string from objects.
 Can be used to hiding of "private" strings from Apple ;)
 If object isn't string - its stringValue will be taken.
 
 For example,
   @"someString4Tests" == __s(@"so", @"meStri", @"ng", [NSNumber numberWithInt:4], @"Tests")
 
 @return NSString
 */
+ (NSString *)sfc_stringFromObjects:(id)object, ... NS_REQUIRES_NIL_TERMINATION;

/**
 Perform -isEqualToString: for each string from array
 @return BOOL
 */
- (BOOL)sfc_isEqualToAnyStringFromArray:(NSArray *)strings;

/**
 Perform -isEqualToString: for each string from va_list
 @return BOOL
 */
- (BOOL)sfc_isEqualToAnyString:(NSString *)string, ... NS_REQUIRES_NIL_TERMINATION;

/**
 Add percent escapes for characters with string encoding
 @return NSString
 */
- (NSString *)sfc_addPercentEscapes;
- (NSString *)sfc_addPercentEscapesWithEncoding:(NSStringEncoding)encoding;
- (NSString *)sfc_addPercentEscapesWithEncoding:(NSStringEncoding)encoding characters:(NSString *)characters;

/**
 Capitalizing first letter and keeps all other characters case
 For example, "someString" will become "FirstString" (not "Firststring")
 */
- (NSString *)sfc_capitalizeFirstLetter;

@end
