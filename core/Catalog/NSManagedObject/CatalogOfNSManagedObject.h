//
//  CatalogOfNSManagedObject.h
//  core
//
//  Created by zppro on 13-1-9.
//
//

#ifndef core_CatalogOfNSManagedObject_h
#define core_CatalogOfNSManagedObject_h

#import "e0571CoreDataManager.h"
#import "NSManagedObjectContext+e0571.h"
#import "NSManagedObject+e0571.h"

#define moc ([[e0571CoreDataManager sharedInstance] contextForCurrentThread])
#define CoreDataContext [[e0571CoreDataManager sharedInstance] contextForCurrentThread]
#define CoreDataContextForTherad [[e0571CoreDataManager sharedInstance] contextForCurrentThread]

#endif
