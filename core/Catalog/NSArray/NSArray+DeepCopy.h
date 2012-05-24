/*
 *  NSArray-DeepCopy.h
 *  MyProject_3
 *
 *  Created by apple on 11-5-20.
 *  Copyright 2011 E0571. All rights reserved.
 *
 */

#import <Foundation/Foundation.h>




@interface NSArray (DeepCopy)
- (NSMutableArray*)deepMutableCopy;

@end