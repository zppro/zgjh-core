//
//  NSDictionary+Data.m
//  CodansShareLibrary10
//
//  Created by 钟 平 on 11-10-19.
//  Copyright (c) 2011年 codans. All rights reserved.
//

#import "NSDictionary+Data.h"
#import <objc/runtime.h>

@implementation NSDictionary (Data)

- (NSDictionary*)mixIn:(NSDictionary*) dict{ 
    NSMutableDictionary *dictA = [NSMutableDictionary dictionaryWithDictionary:self];
    for (NSString *key in [dict allKeys]) {
        [dictA setValue:[dict objectForKey:key] forKey:key];
    } 
    return dictA;
}

+ (NSDictionary*)fromObject:(id) obj{
    NSMutableDictionary *dict = nil;
    if([obj isKindOfClass:[NSDictionary class]]){
        dict = [NSMutableDictionary dictionaryWithDictionary:obj];
    }
    else{ 
        unsigned int propertiesCount, i;
        objc_property_t *properties = class_copyPropertyList([obj class], &propertiesCount);
        if(propertiesCount >0){
            dict = [NSMutableDictionary dictionary];
            for (i = 0; i < propertiesCount; i++) {
                objc_property_t property = properties[i];
                NSString *key = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
                id value = [obj valueForKey:key];
                if(value != nil){
                    [dict setObject:[obj valueForKey:key] forKey:key];
                }
            }
        }
    }
    return dict; 
}

@end
