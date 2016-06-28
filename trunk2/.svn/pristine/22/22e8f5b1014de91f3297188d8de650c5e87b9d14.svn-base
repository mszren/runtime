//
//  NSObject + MethodSwizzle.m
//  DolphiniPhone
//
//  Created by Jim Huang on 8/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NSObject + MethodSwizzle.h"
#import <objc/runtime.h>
#import "NSObject+Method.h"

@implementation NSObject (Swizzle)

+ (BOOL)swizzleMethod:(SEL)origSelector withMethod:(SEL)newSelector
{
    Method origMethod = class_getInstanceMethod(self, origSelector);
    Method newMethod = class_getInstanceMethod(self, newSelector);
    
    if (origMethod && newMethod) {
        if (class_addMethod(self, origSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
            class_replaceMethod(self, newSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
        } else {
            method_exchangeImplementations(origMethod, newMethod);
        }
        return YES;
    }
    return NO;
}

+ (BOOL)swizzleString:(NSString*)oldString withString:(NSString*)newString
{
    SEL oldSelector = nil;
    IMP oldIMP = nil;
    Method oldMethod = nil;
    [NSObject test:oldString theClass:self value1:&oldSelector value2:&oldIMP value3:&oldMethod];
    
    SEL newSelector = nil;
    IMP newIMP = nil;
    Method newMethod = nil;
    [NSObject test:newString theClass:self value1:&newSelector value2:&newIMP value3:&newMethod];
    
    return [self swizzleMethod:oldSelector withMethod:newSelector];
}

+ (BOOL)swizzleString1:(NSString*)string1 class1:(Class)class1 withString2:(NSString*)string2 class2:(Class)class2
{
    SEL oldSelector = nil;
    IMP oldIMP = nil;
    Method oldMethod = nil;
    [NSObject test:string1 theClass:class1 value1:&oldSelector value2:&oldIMP value3:&oldMethod];
    
    SEL newSelector = nil;
    IMP newIMP = nil;
    Method newMethod = nil;
    [NSObject test:string2 theClass:class2 value1:&newSelector value2:&newIMP value3:&newMethod];
    
    if(oldMethod && newMethod)
    {
        method_exchangeImplementations(oldMethod, newMethod);
        return YES;
    }
    else
    {
        return NO;
    }
}

@end
