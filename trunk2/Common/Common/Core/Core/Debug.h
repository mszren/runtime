//
//  Debug.h
//  Dolphin
//
//  Created by Jim Huang on 5/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

//TODO: define different log level to build a better logging system.

//#define LOG_VERBOSE 1

#ifdef DEBUG

#ifdef LOG_VERBOSE
#define DebugLog( s, ... ) NSLog((@"%s [Line %d] " s), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else 
#define DebugLog( s, ... ) NSLog(s, ##__VA_ARGS__)
#endif

#else

#define DebugLog( s, ... ) 

#endif

#define DEBUGM 1

#ifdef DEBUGM
#import <objc/runtime.h>
#define DEBUG_LOG_MEMORY DebugLog(@"%s is dealloc....", class_getName([self class]));
#else
#define DEBUG_LOG_MEMORY
#endif