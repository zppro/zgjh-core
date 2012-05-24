/*
 *  NSDictionary-MutableDeepCopy.m
 *  MyProject_3
 *
 *  Created by apple on 11-5-20.
 *  Copyright 2011 E0571. All rights reserved.
 *
 */

#import "NSDictionary+MutableDeepCopy.h"

@implementation NSDictionary(MutableDeepCopy)

-(NSMutableDictionary*) mutableDeepCopy
{
	NSMutableDictionary *ret = [NSMutableDictionary dictionaryWithCapacity:[self count]];
	NSArray *keys = [self allKeys];
	for (id key in keys) 
	{
		id oneValue = [self valueForKey:key];
		id oneCopy = nil;
		
		if ([oneValue respondsToSelector:@selector(mutableDeepCopy)]) {
			oneCopy = [oneValue mutableDeepCopy];
		}
		else if( [oneValue respondsToSelector:@selector(mutableCopy)])
		{
			oneCopy = [[oneValue mutableCopy] autorelease];
		}
		
		if (oneCopy == nil) 
		{
			oneCopy = [[oneValue copy] autorelease];
		}
		[ret setValue:oneCopy forKey:key];
	}
	
	return ret;
}

@end


