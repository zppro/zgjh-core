//
//  SkinManager.h
//  AirHotel
//
//  Created by Tan Michael on 12-2-8.
//  Copyright (c) 2012年 ponhoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"
#define theSkinManager [SkinManager sharedInstance]

@class Skin;

@interface SkinManager : NSObject
SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(SkinManager);

@property (nonatomic, retain) NSString      *currentSkinName;
@property (nonatomic, retain) NSArray       *skins;

- (void)loadWithContentsOfFile:(NSString *)path;

- (Skin *)currentSkin;
- (Skin *)getSkin:(NSString*) skinName;

@end
