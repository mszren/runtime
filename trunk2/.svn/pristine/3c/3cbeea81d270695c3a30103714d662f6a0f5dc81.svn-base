//
//  NSStringAdditional.m
//  Dolphin
//
//  Created by Jim Huang on 4/15/11.
//  Copyright 2011 Baina. All rights reserved.
//

#import "NSStringAdditional.h"
#import <CommonCrypto/CommonDigest.h>
#import "GTMNSString+HTML.h"

@implementation NSString (Additional)

-(BOOL)isEqualIgnoreCase:(NSString*)other
{
	return [self caseInsensitiveCompare:other] == NSOrderedSame;
}

- (NSComparisonResult)compareUsingLocalizedCaseInsensitiveOptions:(NSString *)string
{
    //
    return [self localizedCaseInsensitiveCompare:string];

    //Optional solution in chinese the code is equal
//    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:[NSString stringWithUTF8String:"zh@collation=pinyin"]];
//    return [self compare:string options:NSCaseInsensitiveSearch | NSNumericSearch | NSWidthInsensitiveSearch | NSForcedOrderingSearch range:NSMakeRange(0, self.length) locale:locale];
}

- (NSString *)capitalizeFirstCharacter
{
	if (self == nil || [self length] == 0)
	{
		return self;
	}
	
	return [self stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[[self substringToIndex:1] capitalizedString]];
}

- (NSString *) md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (unsigned int)strlen(cStr), result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], 
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];  
}


static NSNumberFormatter* formatter = nil;

-(long)longValue
{
    if(formatter == nil)
    {
        formatter = [[NSNumberFormatter alloc] init];
    }
    
    return [[formatter numberFromString:self] longValue];
}

-(BOOL)isNumberValue
{
    const char *cStr = [self UTF8String];
    long nCount = strlen(cStr);
    BOOL result = NO;
    if (nCount > 0)
    {
        result = YES;
        for (int i = 0; i < nCount; ++i)
        {
            if (cStr[i] < '0' || cStr[i] > '9')
            {
                result = NO;
                break;
            }
        }
    }
    return result;
}

-(NSString*)formartStringForJsParam
{
    /*
     * Not work on http://i.cdn.turner.com/cnn/.element/css/2.0/blogs_basic.css
     * See http://worldsport.blogs.cnn.com/2012/11/19/vettel-alonso-driving-towards-f1-greatness/?utm_source=feedburner&utm_medium=feed&utm_campaign=Feed%3A+rss%2Fedition_worldsportblog+%28RSS%3A+World+Sport%29
     * Fixed!!!
     
     * If open debug js, not work on iPhone Version: http://worldsport.blogs.cnn.com/2012/11/19/vettel-alonso-driving-towards-f1-greatness/?utm_source=feedburner&utm_medium=feed&utm_campaign=Feed%3A+rss%2Fedition_worldsportblog+%28RSS%3A+World+Sport%29
     * Very strange!!!
     */
    NSMutableString* result = [NSMutableString stringWithCapacity:[self length]];
    for(int i=0; i < [self length]; i++)
    {
        char charAtIndex = [self characterAtIndex:i];
        if(charAtIndex == '\\')
        {
            [result appendString:@"\\\\"];
        }
        else if(charAtIndex == '\n')
        {
            [result appendString:@"\\ "];
        }
        else if(charAtIndex == '\r') // Fix http://worldsport.blogs.cnn.com/2012/11/19/vettel-alonso-driving-towards-f1-greatness/?utm_source=feedburner&utm_medium=feed&utm_campaign=Feed%3A+rss%2Fedition_worldsportblog+%28RSS%3A+World+Sport%29
        {
            [result appendString:@"\\ "];
            // In case '\r\n'
            if ((i + 1 <[self length] && [self characterAtIndex:i+1] == '\n')) {
                i++;
            }            
        }
        else if(charAtIndex == '\'')
        {
            [result appendString:@"&apos;"];
        }
        else
        {
            [result appendFormat:@"%c", charAtIndex];
        }
    }
    
    return result;
    
    /*
     * http://www.businessinsider.com/warren-buffett-calls-out-grover-norquist-on-taxes-2012-11 works, we need test more urls
     * Cause http://techcrunch.com/2012/12/21/mark-zuckerberg-voice-of-poke/ Evernote share format missing
     
     * If open debug js, not work on iPhone Version: http://worldsport.blogs.cnn.com/2012/11/19/vettel-alonso-driving-towards-f1-greatness/?utm_source=feedburner&utm_medium=feed&utm_campaign=Feed%3A+rss%2Fedition_worldsportblog+%28RSS%3A+World+Sport%29
     * Very strange!!!
     */
//    NSMutableString* result = [NSMutableString stringWithCapacity:[self length]];
//    return [result gtm_stringByEscapingForHTML];
    
    // See: http://stackoverflow.com/questions/5569794/escape-nsstring-for-javascript-input    
    /* If open debug js, not work on iPhone Version: http://worldsport.blogs.cnn.com/2012/11/19/vettel-alonso-driving-towards-f1-greatness/?utm_source=feedburner&utm_medium=feed&utm_campaign=Feed%3A+rss%2Fedition_worldsportblog+%28RSS%3A+World+Sport%29
     * Very strange!!!
     */
//    self = [self stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
//    self = [self stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
//    self = [self stringByReplacingOccurrencesOfString:@"\'" withString:@"\\\'"];
//    self = [self stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
//    self = [self stringByReplacingOccurrencesOfString:@"\r" withString:@"\\r"];
//    self = [self stringByReplacingOccurrencesOfString:@"\f" withString:@"\\f"];
//    return self;
}


@end

@implementation NSMutableString (AdditionalMutable)

- (NSMutableString*)removeLastChar
{
    if([self length] > 0)
    {
        [self deleteCharactersInRange:NSMakeRange([self length] - 1, 1)];
    }
    
    return self;
}

@end


