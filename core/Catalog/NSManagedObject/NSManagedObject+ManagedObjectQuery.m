//
//  NSManagedObject+ManagedObjectQuery.m
//  iMenu
//
//  Created by yangxh yang on 11-10-14.
//  Copyright (c) 2011年 hotel3g.com. All rights reserved.
//

#import "NSManagedObject+ManagedObjectQuery.h"

@implementation NSManagedObject (ManagedObjectQuery)

+ (DKManagedObjectQuery *)query
{
    return [DKManagedObjectQuery queryWithManagedObjectClass:[self class]];
}

@end
