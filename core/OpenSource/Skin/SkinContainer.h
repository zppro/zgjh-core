//
//  SkinContainer.h
//  AirHotel
//
//  Created by Tan Michael on 12-2-8.
//  Copyright (c) 2012年 ponhoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SkinElement;

@interface SkinContainer : NSObject

@property (nonatomic, retain) NSString      *name;
@property (nonatomic, retain) NSArray       *elements;

- (id)initWithDictionary:(NSArray *)elementConfigs andName:(NSString*)containerName;

- (SkinElement *)getElement:(NSString*) elementName;

@end
