//
//  NSDictionaryAdditional.h
//  Dolphin
//
//  Created by Jim Huang on 5/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDictionary (NSDictionaryAdditional)

// Wrap objectForKey, if returned object is NSNull, return an empty string instead.
// Mostly for parse result from JSON.
-(NSString*)stringForKey:(NSString*)key;

@end
