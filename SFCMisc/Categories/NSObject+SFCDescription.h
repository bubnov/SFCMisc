//
//  NSObject+SFCDescription.h
//  SFCMisc
//
//  Created by Slavik Bubnov on 28.03.12.
//  Copyright (c) 2012 Bubnov Slavik, bubnovslavik@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSObject (SFCDescription)

/**
 Return well-formatted string with object description
 To see the difference try to print to the log any array or dictionary like this:
 
   NSLog(@"%@", someDictionary);
   NSLog(@"%@", [someDictionary properDescription]);
 
 @return NSString
 */
- (NSString *)sfc_properDescription;

/**
 Return object description in format "<%@ 0x%x>"
 @return NSString
 */
- (NSString *)sfc_shortDescription;

@end