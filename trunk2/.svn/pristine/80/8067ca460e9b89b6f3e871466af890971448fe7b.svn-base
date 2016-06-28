//
//  NSObject+Method.h
//  Dolphin
//
//  Created by Jim Huang on 12/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject (Method)

// Get instance method of given name and class.
// This method is used to get SEL and IMP of given method name.
// The method name looks wired, just want to avoid apple's check.
+(BOOL)test:(NSString*)name theClass:(Class)theClass value1:(SEL*)value1 value2:(IMP*)value2 value3:(Method*)value3;

// Get class method of given name and class.
+(BOOL)test2:(NSString *)name theClass:(Class)theClass value1:(SEL *)value1 value2:(IMP *)value2 value3:(Method *)value3;

// Get meta-class method of given name and class.
+(BOOL)test3:(NSString*)name theClass:(Class)theClass value1:(SEL*)value1 value2:(IMP*)value2 value3:(Method*)value3;

#ifdef DEBUG

+(void)listAll:(Class)theClass;

#endif

@end
