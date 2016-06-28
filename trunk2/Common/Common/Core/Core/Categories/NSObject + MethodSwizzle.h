//
//  NSObject + MethodSwizzle.h
//  DolphiniPhone
//
//  Created by Jim Huang on 8/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Swizzle)

+ (BOOL)swizzleMethod:(SEL)origSelector withMethod:(SEL)newSelector;

+ (BOOL)swizzleString:(NSString*)oldString withString:(NSString*)newString;

+ (BOOL)swizzleString1:(NSString*)string1 class1:(Class)class1 withString2:(NSString*)string2 class2:(Class)class2;

@end
