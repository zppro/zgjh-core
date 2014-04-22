//
//  BaseModel.m
//  PonhooLibrary
//
//  Created by 钟 平 on 12-3-30.
//  Copyright (c) 2012年 ponhoo. All rights reserved.
//

#import "BaseModel.h"
#import "CatalogOfNSManagedObject.h"
#import "NSManagedObject+e0571.h"
#import "Functions.h"
#import "DKManagedObjectQuery.h"
#import "NSManagedObject+ManagedObjectQuery.h"

@implementation BaseModel
 

+ (NSString*) localEntityKey{
    return nil;
}
+ (NSString*) dataSourceKey{
    return nil;
}

+ (BOOL)updateWithData:(NSArray *)data EntityKey:(NSString *)entityKey IEntityKey:(NSString *)iEntityKey fethchFormat:(NSString *)fetchFormat
{
    NSMutableDictionary *dictHolder = [[NSMutableDictionary alloc] initWithCapacity:[data count]];
    for (id iEntity in data) {
        [dictHolder setObject:iEntity forKey:[iEntity valueForKey:iEntityKey]];
    }
    
    // 根据条件过滤更新数据源
    NSArray *localEntities;// = [self fetchAll];
    if ( !fetchFormat.length ) {
        localEntities = [self fetchAll];
    } else {
        localEntities = [self fetchWithPredicateFormat:fetchFormat];
    }
    
    for (id localEntity in localEntities) {
        id iEntity = [dictHolder objectForKey:[localEntity valueForKey:entityKey]];
        if (iEntity != nil) {
            [localEntity updateWithIEntity:iEntity];
            [dictHolder removeObjectForKey:[localEntity valueForKey:entityKey]];
        }else {
            [localEntity delete];
        }
    }
    
    for (NSString *key in dictHolder){
        id iEntity = [dictHolder objectForKey:key];
        
        /*
         yangxh 2011-12-20 add
         在有fetchFormat情况下，标识符对应的数据可能存在，但是没在条件内，
         这样就会存在 一个标识符 对应 多条数据
         解决：首先根据标识符查找，找不到然后再创建
         */
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K = %@", entityKey, key];
        
        if ([fetchFormat length] > 0) {
            NSPredicate *sourcePredicate = [NSPredicate predicateWithFormat:fetchFormat];
            predicate = [[[NSCompoundPredicate alloc] initWithType:NSAndPredicateType
                                                    subpredicates:[NSArray arrayWithObjects:
                                                                   predicate, sourcePredicate, nil]] autorelease];
        }
        
        NSArray *entities = [self fetchWithPredicate:predicate];
        id entity = entities.count > 0 ? [entities objectAtIndex:0] : [self create];
        [entity updateWithIEntity:iEntity];
    }
    [dictHolder release];
    
    return [moc save];
}

+ (BOOL)updateWithData:(NSArray *)data EntityKey:(NSString *)entityKey IEntityKey:(NSString *)iEntityKey
{
    return [self updateWithData:data EntityKey:entityKey IEntityKey:iEntityKey fethchFormat:nil];
}

- (void)updateWithIEntity:(id)iEntity{
    NSDictionary *mapings = [self elementToPropertMappings];
    for (NSString *key in mapings) {
        if([[iEntity valueForKey:key] class] == [NSNull class]){
            [self setValue:nil forKey:[mapings objectForKey:key]];
        }
        else{
            NSString *value = [iEntity valueForKey:key];
            
            if([value isKindOfClass:[NSString class]]){
                
                /* 不靠谱的检测日期字串
                NSError *error = NULL;
                
                NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeDate error:&error];
                NSUInteger numberOfMatches = [detector numberOfMatchesInString:value
                                                                       options:0
                                                                         range:NSMakeRange(0, [value length])];
                 
                */
                
                // Expect date in this format "/Date(1268123281843)/"
                NSRange range = [value rangeOfString:@"/Date"];
                if(range.length>0 && range.location==0){
                    int startPos = [value rangeOfString:@"("].location+1;
                    int endPos = [value rangeOfString:@")"].location;
                    NSRange range = NSMakeRange(startPos,endPos-startPos);
                    unsigned long long milliseconds = [[value substringWithRange:range] longLongValue];
                    NSTimeInterval interval = milliseconds/1000;
                    [self setValue:[NSDate dateWithTimeIntervalSince1970:interval] forKey:[mapings objectForKey:key]];
                }
                else{
                    
                    [self setValue:value forKey:[mapings objectForKey:key]];
                    /*
                    NSPredicate *dateStringPredict = [NSPredicate predicateWithFormat:@"SELF MATCHES '((19|20)[0-9][0-9])-(0[1-9]|1[012])-(0[1-9]|1[0-9]|2[0-9]|3[01])[T]([0-5][0-9]):([0-5][0-9]):([0-5][0-9])(\\.?[0-9]{0,3})?'"];
                    BOOL isMatch = [dateStringPredict evaluateWithObject:value];
                    if(isMatch){
                        //日期
                        NSDate * valueDate = ParseDateFromStringFormat(value, @"yyyy-MM-dd'T'HH:mm:ss");
                        if(valueDate == nil){
                            valueDate = ParseDateFromStringFormat(value, @"yyyy-MM-dd'T'HH:mm:ss.S");
                        }
                        if(valueDate == nil){
                            valueDate = ParseDateFromStringFormat(value, @"yyyy-MM-dd'T'HH:mm:ss.SS");
                        }
                        if(valueDate == nil){
                            valueDate = ParseDateFromStringFormat(value, @"yyyy-MM-dd'T'HH:mm:ss.SSS");
                        }
                        [self setValue:valueDate forKey:[mapings objectForKey:key]];
                    }
                    else{
                        [self setValue:value forKey:[mapings objectForKey:key]];
                    }
                    */
                }
                
            }
            else{
                [self setValue:value forKey:[mapings objectForKey:key]];
            }
        }
    }
}

+ (id)objectByEntityKey:(NSString *)value
{
    // 找出主键
    NSString *key = [self localEntityKey];
    if (!key || !value) {
        return nil;
    }
    
    // 查找记录
    return [[[self query] where:key equals:value] firstObject];
}

// 必须重写
- (NSDictionary*)elementToPropertMappings{return nil;}

+ (id)createWithIEntity:(id)iEntity{
    id instance = [self create];
    [instance updateWithIEntity:iEntity];
    return instance;
}



- (NSMutableDictionary*) toMutableDictionary{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSDictionary *mapings = [self elementToPropertMappings];
    for (NSString *key in mapings) {
        
        if([self valueForKey:[mapings objectForKey:key]] != nil){
            
            if([[self valueForKey:[mapings objectForKey:key]] isKindOfClass:[NSDate class]]){
                [dictionary setObject: ParseDateToJsonStr([self valueForKey:[mapings objectForKey:key]]) forKey:key];
            }
            else{
                [dictionary setObject:[self valueForKey:[mapings objectForKey:key]] forKey:key];
            }
        }
    }
    return dictionary;
}

- (void)PrintSelf {
    
}

@end
