//
//  Skin.m
//  AirHotel
//
//  Created by Tan Michael on 12-2-8.
//  Copyright (c) 2012年 ponhoo. All rights reserved.
//

#import "Skin.h"
#import "SkinContainer.h"
#import "NSArray+ArrayQuery.h"

@implementation Skin

@synthesize name = _name;
@synthesize title = _title;
@synthesize containers = _containers;

- (void)dealloc {
    [_name release];
    [_title release];
    [_containers release];
    
    [super dealloc];
}

- (id)initWithContentsOfFile:(NSString *)path andName:(NSString *)skinName andTitle:(NSString *)skinTitle {
    self = [super init];
    if (self) {
        if(path != nil){
            
            self.name = skinName;
            self.title = skinTitle;
            
            NSDictionary *skinDict = [NSDictionary dictionaryWithContentsOfFile:path];
            if(skinDict != nil){
                NSArray *skinContainerConfigs = [skinDict objectForKey:@"Containers"];
                _containers = [[NSMutableArray alloc] initWithCapacity:[skinContainerConfigs count]];
                for (NSDictionary* skinContainerConfig in skinContainerConfigs) {
                    [((NSMutableArray *)_containers) addObject:[[[SkinContainer alloc] initWithDictionary:[skinContainerConfig objectForKey:@"Elements"] andName:[skinContainerConfig objectForKey:@"Name"]] autorelease]];
                }
            }
        }
    }
    return self;
}

- (SkinContainer *)getContainer:(NSString *) containerName {
    //DKArrayQuery * arrayQuery = [DKArrayQuery queryWithArray:_containers];
    //return [[[arrayQuery where:@"name" equals:containerName] results] lastObject];
    return [[[[_containers query] where:@"name" equals:containerName] results] lastObject];
}

@end
