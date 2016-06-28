//
//  NSObject+Method.m
//  Dolphin
//
//  Created by Jim Huang on 12/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "NSObject+Method.h"

// Same as objc_method, use a wired name to avoid apple's check.
typedef struct my_method
{
    SEL    name;
    const char*  types;
    IMP imp;
    
}* p_my_struct;

@implementation NSObject (Method)

+(BOOL)test:(NSString*)name theClass:(Class)theClass value1:(SEL*)value1 value2:(IMP*)value2 value3:(Method*)value3
{
    @try{
        unsigned int methodCount;
        Method* methods =class_copyMethodList(theClass, &methodCount);
        
        if(!methods)
        {
            return NO;
        }
        
        for(int i =0; i < methodCount; i++)
        {
            Method method = methods[i];
            p_my_struct methodStruct = (p_my_struct)method;
            
            const char* methodName = (const char*)(methodStruct->name);
            
            if(methodName)
            {
                const char* theName = [name cStringUsingEncoding:NSUTF8StringEncoding];
                if(strcmp(theName, methodName) == 0)
                {
                    if(value1)
                    {
                        *value1 = methodStruct->name;
                    }
                    
                    if(value2)
                    {
                        *value2 = methodStruct->imp;
                    }
                    
                    if(value3)
                    {
                        *value3 = method;
                    }
                    
                    free(methods);
                    return YES;
                }
            }
        }
        
        free(methods);
        return NO;
    }@catch (NSException *e) {
        DebugLog(@"Call %@ failed with error:%@", name, e);
        if(value1)
        {
            *value1 = NULL;
        }
        
        if(value2)
        {
            *value2 = NULL;
        }
        
        if(value3)
        {
            *value3 = NULL;
        }
        return NO;
    }
}

+(BOOL)test3:(NSString*)name theClass:(Class)theClass value1:(SEL*)value1 value2:(IMP*)value2 value3:(Method*)value3 {
    @try{
        unsigned int methodCount;
        const char *className = [[theClass description] UTF8String];
        Method* methods = class_copyMethodList(objc_getMetaClass(className), &methodCount);
        
        if(!methods)
        {
            return NO;
        }
        
        for(int i =0; i < methodCount; i++)
        {
            Method method = methods[i];
            p_my_struct methodStruct = (p_my_struct)method;
            
            const char* methodName = (const char*)(methodStruct->name);
            
            if(methodName)
            {
                NSString* methodNameNSString = [NSString stringWithCString:methodName encoding:NSUTF8StringEncoding];
                if([methodNameNSString isEqualToString:name])
                {
                    if(value1)
                    {
                        *value1 = methodStruct->name;
                    }
                    
                    if(value2)
                    {
                        *value2 = methodStruct->imp;
                    }
                    
                    if(value3)
                    {
                        *value3 = method;
                    }
                    
                    free(methods);
                    return YES;
                }
            }
        }
        
        free(methods);
        return NO;
    }@catch (NSException *e) {
        DebugLog(@"Call %@ failed with error:%@", name, e);
        if(value1)
        {
            *value1 = NULL;
        }
        
        if(value2)
        {
            *value2 = NULL;
        }
        
        if(value3)
        {
            *value3 = NULL;
        }
        return NO;
    }
}

typedef struct my_class
{
    void *isa;
    void* *super_class;
    const char *name;
    long version;
    long info;
    long instance_size;
    struct objc_ivar_list *ivars;
    struct objc_method_list **methodLists;
    struct objc_cache *cache;
    struct objc_protocol_list *protocols;
} * p_my_class;


+(BOOL)test2:(NSString *)name theClass:(Class)theClass value1:(SEL *)value1 value2:(IMP *)value2 value3:(Method *)value3
{
    p_my_class pClass = (p_my_class)theClass;
    return [NSObject test:name theClass:(Class)(pClass->isa) value1:value1 value2:value2 value3:value3];
}


#ifdef DEBUG

// List all the fields, properties and methods for this class.
+(void)listAll:(Class)theClass
{
    unsigned int varsCount;
    Ivar* vars = class_copyIvarList(theClass, &varsCount);
    
    DebugLog(@"vars for %s", class_getName(theClass));
    
    for(int i=0; i <varsCount; i++)
    {
        Ivar var = vars[i];
        const char* varName = ivar_getName(var);
        DebugLog(@"%s", varName);
    }
    
    DebugLog(@"\n");
    
    free(vars);
    
    
    unsigned int propertiesCount;
    objc_property_t * properties = class_copyPropertyList(theClass, &propertiesCount);
    
    DebugLog(@"properties for %s", class_getName(theClass));
    for(int i=0; i < propertiesCount; i++)
    {
        objc_property_t property = properties[i];
        const char* propertyName = property_getName(property);
        const char* propertyAttributes = property_getAttributes(property);
        
        DebugLog(@"%s : %s", propertyName, propertyAttributes);
    }
    
    DebugLog(@"\n");
    
    free(properties);
    
    
    unsigned int methodsCount;
    Method* methods = class_copyMethodList(theClass, &methodsCount);
    
    DebugLog(@"methods for %s", class_getName(theClass));
    for(int i=0; i < methodsCount; i++)
    {
        const char* methodName = sel_getName(method_getName(methods[i]));
        char* methodReturnType = malloc(100);
        method_getReturnType(methods[i], methodReturnType, 100);
        
        DebugLog(@"%s   %s", methodName, methodReturnType);
        
        free(methodReturnType);
    }
    
    DebugLog(@"\n");
    
    free(methods);
}

#endif

@end
