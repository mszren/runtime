//
//  Regex.m
//  Core
//
//  Created by Jim Huang on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Regex.h"

@implementation Regex

@synthesize capture = _capture, string = _string;


-(id)initWithString:(NSString*)string
{
    self = [self initWithString:string andCapture:0];
    return self;
}

-(id)initWithString:(NSString *)string andCapture:(int)capture
{
    self = [super init];
    if(self)
    {
        _capture = capture;
        _string = [string retain];
    }
    
    return self;
}

-(void)dealloc
{
    [_string release];
    [super dealloc];
}

@end
