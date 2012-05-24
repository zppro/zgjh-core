//
//  e0571CoreDataManager.h
//  iPodMenuPlus
//
//  Created by yangxh on 11-5-6.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "SynthesizeSingleton.h"

#define SETTING_DEBUG_KEY @"is_debug"

@interface e0571CoreDataManager : NSObject {
	
	NSManagedObjectModel *managedObjectModel;
	NSManagedObjectContext *managedObjectContext;
	NSPersistentStoreCoordinator *persistentStoreCoordinator;
	NSManagedObjectContext *threadManagedObjectContext; 	//多线程使用
	
	NSString *initialType;
	NSString *storePath;
	
}

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain, readonly) NSManagedObjectContext *threadManagedObjectContext;

- (NSString *)applicationDocumentsDirectory;
- (void)saveContext;

//当前线程的上下文
- (NSManagedObjectContext *)contextForCurrentThread;
- (NSString *)dbName;
- (NSString *)dbNameWithExt;
- (void)initContext;

SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(e0571CoreDataManager);

@end
