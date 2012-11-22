//
//  Skin.h
//  AirHotel
//
//  Created by Tan Michael on 12-2-8.
//  Copyright (c) 2012年 ponhoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SkinContainer;

@interface Skin : NSObject

@property (nonatomic, retain) NSString      *name;
@property (nonatomic, retain) NSString      *title;
@property (nonatomic, retain) NSArray       *containers;

- (id)initWithContentsOfFile:(NSString *)path andName:(NSString *)skinName andTitle:(NSString *)skinTitle;

- (SkinContainer *)getContainer:(NSString *) containerName;

@end
