//
//  NSManagedObject+e0571.m
//  iPodMenuPlus
//
//  Created by yangxh yang on 11-6-29.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "NSManagedObject+e0571.h"
#import "NSManagedObjectContext+e0571.h"
#import "CatalogOfNSManagedObject.h"

@implementation NSManagedObject(e0571)

#pragma mark -
#pragma mark Fetch all unsorted
+ (NSArray *)fetchAll {
    return [moc fetchObjectsForEntityName:NSStringFromClass([self class])];
}

+ (id)fetchFirst {
    return [moc fetchFirstObjectForEntityName:NSStringFromClass([self class])];
}

#pragma mark -
#pragma mark Fetch all sorted
+ (NSArray *)fetchAllSortBy:(NSString *)key ascending:(BOOL)ascending {
    return [moc fetchObjectsForEntityName:NSStringFromClass([self class]) sortByKey:key ascending:ascending];
}

+ (NSArray *)fetchAllSortWith:(NSArray *)sortDescriptors {
    return [moc fetchObjectsForEntityName:NSStringFromClass([self class]) sortWith:sortDescriptors];
}

#pragma mark -
#pragma mark Fetch filtered unsorted
+ (NSArray *)fetchWithPredicate:(NSPredicate *)predicate {
    return [moc fetchObjectsForEntityName:NSStringFromClass([self class]) withPredicate:predicate];
}

+ (NSArray *)fetchWithPredicateFormat:(NSString *)predicateFormat, ... {
    va_list variadicArguments;
	va_start(variadicArguments, predicateFormat);
	NSPredicate* predicate = [NSPredicate predicateWithFormat:predicateFormat
													arguments:variadicArguments];
	va_end(variadicArguments);
    
    return [self fetchWithPredicate:predicate];
}

+ (id)fetchFirsWithPredicateFormat:(NSString *)predicateFormat, ... {
    va_list variadicArguments;
	va_start(variadicArguments, predicateFormat);
	NSPredicate* predicate = [NSPredicate predicateWithFormat:predicateFormat
													arguments:variadicArguments];
	va_end(variadicArguments);
    
    NSArray *objects = [self fetchWithPredicate:predicate];
    return [objects count] > 0 ? [objects objectAtIndex:0] : nil;
}

#pragma mark -
#pragma mark Fetch filtered sorted
+ (NSArray *)fetchWithSortBy:(NSString *)key ascending:(BOOL)ascending withPredicate:(NSPredicate *)predicate {
    return [moc fetchObjectsForEntityName:NSStringFromClass([self class]) sortByKey:key ascending:ascending withPredicate:predicate];
}

+ (NSArray *)fetchWithSort:(NSArray *)sortDescriptors withPredicate:(NSPredicate *)predicate {
    return [moc fetchObjectsForEntityName:NSStringFromClass([self class]) sortWith:sortDescriptors withPredicate:predicate];
}

+ (NSArray *)fetchWithSortBy:(NSString *)key ascending:(BOOL)ascending predicateWithFormat:(NSString *)predicateFormat, ... {
    va_list variadicArguments;
	va_start(variadicArguments, predicateFormat);
	NSPredicate* predicate = [NSPredicate predicateWithFormat:predicateFormat
													arguments:variadicArguments];
	va_end(variadicArguments);
    
    return [self fetchWithSortBy:key ascending:ascending withPredicate:predicate];
}

+ (NSArray *)fetchWithSort:(NSArray *)sortDescriptors predicateWithFormat:(NSString *)predicateFormat, ... {
    va_list variadicArguments;
	va_start(variadicArguments, predicateFormat);
	NSPredicate* predicate = [NSPredicate predicateWithFormat:predicateFormat
													arguments:variadicArguments];
	va_end(variadicArguments);
    
    return [self fetchWithSort:sortDescriptors withPredicate:predicate];
}

#pragma mark -
#pragma mark Custom
+ (id)create {
   return [moc insertNewObjectForEntityForName:NSStringFromClass([self class])];
}

+ (void)deleteAll {
    [moc deleteAllObjectsForName:NSStringFromClass([self class])];
}

- (void)delete {
    [moc deleteObject:self];
}

@end
