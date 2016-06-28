//
//  NSString+URLEncoding.m
//
//  Created by Jon Crosby on 10/19/07.
//  Copyright 2007 Kaboomerang LLC. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.


#import "NSString+URLEncoding.h"

@implementation NSString (OAURLEncodingAdditions)

- (NSString *)URLEncodedStringPlusForSpace
{
    /*
     * Fix BUG #20814::【iPad&iPhone EN】【v5.3】【Crash Log】*** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '*** -[NSPlaceholderMutableString initWithString:]: nil argument'
     */
    NSString *encodeStr = [self URLEncodedString];
    NSMutableString* result = nil;
    if (encodeStr) {
        result = [NSMutableString stringWithString:[self URLEncodedString]];
        [result replaceOccurrencesOfString:@"%20" withString:@"+" options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    }else
        result = (NSMutableString*)self;
    return result;
}

- (NSString *)URLEncodedString 
{
    NSString *result = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                           (CFStringRef)self,
                                                                           NULL,
																		   CFSTR("!*'();:@&=+$,/?%#[]~"),
                                                                           kCFStringEncodingUTF8);
    [result autorelease];
	return result;
}

- (NSString*)URLDecodedString
{
	NSString *result = (NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
																						   (CFStringRef)self,
																						   CFSTR(""),
																						   kCFStringEncodingUTF8);
    [result autorelease];
	return result;	
}

- (NSMutableDictionary *)dictionaryFromQueryComponentsWithDecoding:(BOOL)withDecode
{
    NSMutableDictionary *queryComponents = [NSMutableDictionary dictionary];
    for(NSString *keyValuePairString in [self componentsSeparatedByString:@"&"])
    {
        NSArray *keyValuePairArray = [keyValuePairString componentsSeparatedByString:@"="];
        if ([keyValuePairArray count] < 2) continue; // Verify that there is at least one key, and at least one value.  Ignore extra = signs
        NSString *key = [keyValuePairArray objectAtIndex:0];
        NSString *value = [keyValuePairArray objectAtIndex:1];
        
        if (withDecode)
        {
            key = [key URLDecodedString];
            value = [value URLDecodedString];
        }
        
        // Add check here since crash happens once
        if (!key || !value) {
            continue;
        }
        
        NSMutableArray *results = [queryComponents objectForKey:key]; // URL spec says that multiple values are allowed per key
        //http://en.wikipedia.org/wiki/Query_string#Structure
        //Multiple values can also be associated with a single field: field1=value1&field1=value2&field1=value3...
        if(!results) // First object
        {
            results = [NSMutableArray array];
            [queryComponents setObject:results forKey:key];
        }
        [results addObject:value];
    }
    return queryComponents;
}

- (NSMutableDictionary *)dictionaryFromQueryComponents
{
    return [self dictionaryFromQueryComponentsWithDecoding:YES];
}

@end
