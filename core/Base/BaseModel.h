//
//  BaseModel.h
//  PonhooLibrary
//
//  Created by 钟 平 on 12-3-30.
//  Copyright (c) 2012年 ponhoo. All rights reserved.
//

#import <Foundation/Foundation.h>
 
@interface BaseModel : NSManagedObject

+ (NSString*) localEntityKey;
+ (NSString*) dataSourceKey;

+ (BOOL)createWithData:(NSArray *)data;
+ (id)createWithIEntity:(id)iEntity;

+ (BOOL)updateWithData:(NSArray *)data EntityKey:(NSString *)entityKey IEntityKey:(NSString *)iEntityKey fethchFormat:(NSString *)fetchFormat;
+ (BOOL)updateWithData:(NSArray *)data EntityKey:(NSString *)entityKey IEntityKey:(NSString *)iEntityKey;
- (void)updateWithIEntity:(id)iEntity;
+ (id)objectByEntityKey:(NSString *)value;
- (NSDictionary *)elementToPropertMappings;

- (NSMutableDictionary*) toMutableDictionary;
- (void)PrintSelf;
 

@end
