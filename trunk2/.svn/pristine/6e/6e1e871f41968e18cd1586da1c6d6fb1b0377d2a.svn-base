//
//  NSStringAdditional.h
//  Dolphin
//
//  Created by Jim Huang on 4/15/11.
//  Copyright 2011 Baina. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (Additional)

- (BOOL)isEqualIgnoreCase:(NSString*)other;

- (NSComparisonResult)compareUsingLocalizedCaseInsensitiveOptions:(NSString *)string;

- (NSString *)capitalizeFirstCharacter;

-(NSString*)md5;

- (long)longValue;

- (BOOL)isNumberValue;

/*
 Escape characters so we can pass a string via stringByEvaluatingJavaScriptFromString
 
 When we call js methed with a string parameter, we need to do some format, otherwise it doesn't work.
 e.g. we need add "\" for new line.
 "line1
 line2"
 should be
 "line1 \
 line2"
 
 So these change will be made:
 1)Replace "\" with "\\",  replace "\n" "\r\n" with "\"
 2)Replace "'" -> &quot;
 */
-(NSString*)formartStringForJsParam;

@end

@interface NSMutableString (AdditionalMutable)

- (NSMutableString*)removeLastChar;

@end
