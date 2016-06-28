//
//  NSString+NSString___APIEncoding.h
//  Core
//
//  Created by LuoQi on 3/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (APIEncoding)
+(NSString*)encryptAPIString:(NSString*)str;
+(NSString*)decryptAPIString:(NSString*)str;
+ (NSString *)_859ToUTF8:(NSString *)oldStr;
@end
