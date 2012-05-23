/*
 *  NSArray-DeepCopy.m
 *  MyProject_3
 *
 *  Created by apple on 11-5-20.
 *  Copyright 2011 E0571. All rights reserved.
 *
 */

/*
 *  NSDictionary-MutableDeepCopy.m
 *  MyProject_3
 *
 *  Created by apple on 11-5-20.
 *  Copyright 2011 E0571. All rights reserved.
 *
 */

#import "NSArray+DeepCopy.h"



@implementation NSArray (DeepCopy)

- (NSMutableArray*)deepMutableCopy
{	

	NSMutableArray *ret = [NSMutableArray arrayWithCapacity:[self count]];

	for (int i=0 ; i < [self count]; i++) 
	{
		id oneValue = [self objectAtIndex:i];
		id oneCopy = nil;
		
		
		if ([oneValue respondsToSelector:@selector(deepMutableCopy)]) {
			oneCopy = [oneValue deepMutableCopy];
		}
		else if( [oneValue respondsToSelector:@selector(copyWithZone:)])
		{
			oneCopy = [[oneValue copy] autorelease];
		}
		
		if (oneCopy == nil) 
		{
			oneCopy = [[oneValue copy] autorelease];
		}
		[ret addObject:oneCopy];
		 
		
	}

	return ret;
	
}




@end