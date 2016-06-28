//
//  NSMutableArray+Move.m
//  Core
//
//  Created by meng li on 12-9-13.
//
//

#import "NSMutableArray+Move.h"

@implementation NSMutableArray (Move)

-(void)moveObjectAtIndex:(NSUInteger)idx1 toIndex:(NSUInteger)idx2{
    if (idx1 >= [self count]
        || idx2 >= [self count]) {
        return;
    }
    id obj = [[self objectAtIndex:idx1] retain];
    [self removeObjectAtIndex:idx1];
    [self insertObject:obj atIndex:idx2];
    [obj release];
}

@end
