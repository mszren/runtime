//
//  Regex.h
//  Core
//
//  Created by Jim Huang on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

// A class wrap the string and capture of the Regular express.
@interface Regex : NSObject
{
    int _capture;
    NSString* _string;
}

-(id)initWithString:(NSString*)string;

-(id)initWithString:(NSString *)string andCapture:(int)capture;

@property (nonatomic, readonly) int capture;

@property (nonatomic, readonly) NSString* string;

@end
