//
//  NSArray+ExtraMethod.m
//  JCFindHouse
//
//  Created by Jam on 13-11-20.
//  Copyright (c) 2013年 jiamiao. All rights reserved.
//

#import "NSArray+ExtraMethod.h"

@implementation NSArray (ExtraMethod)

- (id)objectSafetyAtIndex:(NSUInteger)index
{
    if (index >= [self count]) {
        return nil;
    } else {
        return [self objectAtIndex:index];
    }
}

@end
