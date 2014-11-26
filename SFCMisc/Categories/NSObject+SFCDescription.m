//
//  NSObject+SFCDescription.m
//  SFCMisc
//
//  Created by Slavik Bubnov on 28.03.12.
//  Copyright (c) 2012 Bubnov Slavik, bubnovslavik@gmail.com. All rights reserved.
//

#import "NSObject+SFCDescription.h"
#import "NSString+SFCExtends.h"


@interface NSObject (SFCDescription_Private)

- (NSString *)sfc_properDescription:(NSInteger)level;

@end


#pragma mark - NSObject (SFCDescription) -

@implementation NSObject (SFCDescription)

- (NSString *)sfc_descriptionIndentForLevel:(NSInteger)level {
   if (level) {
      return [NSString sfc_stringByRepeatingString:@"  " count:level];
   }
   return @"";
}


- (NSString *)sfc_properDescription {
   return [self sfc_properDescription:0];
}


- (NSString *)sfc_properDescription:(NSInteger)level {
   return [self description];
}


- (NSString *)sfc_shortDescription {
   return [NSString stringWithFormat:@"<%@ 0x%x>",
           [self class],
           (unsigned int)self];
}

@end



#pragma mark - NSDictionary (SFCDescription) -

@implementation NSDictionary (SFCDescription)

- (NSString *)sfc_properDescription:(NSInteger)level {
   NSMutableString *string = [NSMutableString stringWithString:@"{\n"];
   
   for (NSString *key in [self.allKeys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)]) {
      id object = [self objectForKey:key];
      NSString *format = [object isKindOfClass:[NSString class]] 
         ? @"%@\"%@\" = \"%@\";\n" 
         : @"%@\"%@\" = %@;\n";
      [string appendFormat:format, [self sfc_descriptionIndentForLevel:(level + 1)], key, [object sfc_properDescription:(level + 1)]];
   }
   
   return [string stringByAppendingFormat:@"%@}", [self sfc_descriptionIndentForLevel:level]];
}

@end



#pragma mark - NSArray (SFCDescription) -

@implementation NSArray (SFCDescription)

- (NSString *)sfc_properDescription:(NSInteger)level {
   NSMutableString *string = [NSMutableString stringWithString:@"(\n"];
   
   for (int i = 0; i < [self count]; i++) {
      id object = [self objectAtIndex:i];
      NSString *separator = (i == [self count] - 1) ? @"" : @",";
      [string appendFormat:@"%@\%@%@\n", [self sfc_descriptionIndentForLevel:(level + 1)], [object sfc_properDescription:(level + 1)], separator];
   }
   
   return [string stringByAppendingFormat:@"%@)", [self sfc_descriptionIndentForLevel:level]];
}

@end
