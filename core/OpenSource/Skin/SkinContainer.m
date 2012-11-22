//
//  SkinContainer.m
//  AirHotel
//
//  Created by Tan Michael on 12-2-8.
//  Copyright (c) 2012年 ponhoo. All rights reserved.
//

#import "SkinContainer.h"
#import "SkinElement.h"
#import "NSArray+ArrayQuery.h"

@implementation SkinContainer

@synthesize name = _name;
@synthesize elements = _elements;

- (void)dealloc {
    [_name release];
    [_elements release];
    
    [super dealloc];
}

- (id)initWithDictionary:(NSArray *)elementConfigs andName:(NSString*)containerName {
    self = [super init];
    if (self) {
        self.name = containerName;
        _elements = [[NSMutableArray alloc] initWithCapacity:[elementConfigs count]];
        for (NSDictionary* elementConfig in elementConfigs) {
            [((NSMutableArray*)_elements) addObject:[[[SkinElement alloc] initWithDictionary:elementConfig] autorelease]];
        }
    }
    return self;
}

- (SkinElement *)getElement:(NSString*) elementName {
    
    //DKArrayQuery * arrayQuery = [DKArrayQuery queryWithArray:_elements];
    //return [[[arrayQuery where:@"name" equals:elementName] results] lastObject];
    
    return [[[[_elements query] where:@"name" equals:elementName] results] lastObject];
}

@end
