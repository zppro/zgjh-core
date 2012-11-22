//
//  SkinManager.m
//  AirHotel
//
//  Created by Tan Michael on 12-2-8.
//  Copyright (c) 2012年 ponhoo. All rights reserved.
//

#import "SkinManager.h"
#import "Skin.h"
#import "PHResourceManager.h"
#import "MacroFunctions.h"
#import "NXDebug.h"
#import "NSArray+ArrayQuery.h"

@implementation SkinManager
SYNTHESIZE_LESSER_SINGLETON_FOR_CLASS(SkinManager);

@synthesize currentSkinName = _currentSkinName;
@synthesize skins = _skins;

- (void)dealloc {
    [_currentSkinName release];
    [_skins release];
    
    [super dealloc];
}

- (void)loadWithContentsOfFile:(NSString *)skinIndexFileName {
    ASSERT(skinIndexFileName != nil);
    NSLog(@"%@", MF_Plist(skinIndexFileName));
    NSDictionary *skinIndexDict = [NSDictionary dictionaryWithContentsOfFile:MF_Plist(skinIndexFileName)];
    if(skinIndexDict != nil) {
        self.currentSkinName = [skinIndexDict objectForKey:@"CurrentSkinName"];
        
        NSArray *skinConfigs = [skinIndexDict objectForKey:@"Skins"];
        _skins = [[NSMutableArray alloc] initWithCapacity:[skinConfigs count]];
        for (NSDictionary* skinConfig in skinConfigs) {
            NSString *skinName = [skinConfig objectForKey:@"Name"];
            NSString *skinFilePath = MF_Plist([skinConfig objectForKey:@"Name"]);
            NSFileManager *fileManager = [NSFileManager defaultManager];
            if (![fileManager fileExistsAtPath:skinFilePath]) {
                NSLog(@"SkinFile:%@ is not exist", skinName);
                continue;
            }
            [((NSMutableArray *)_skins) addObject:[[[Skin alloc] initWithContentsOfFile:skinFilePath 
                                                                                andName:skinName 
                                                                               andTitle:[skinConfig objectForKey:@"Title"]] autorelease]];
        }
    }
}

- (Skin *)currentSkin {
    return [self getSkin:_currentSkinName];
}

- (Skin *)getSkin:(NSString*) skinName {
    DKArrayQuery * arrayQuery = [DKArrayQuery queryWithArray:_skins];
    return [[[arrayQuery where:@"name" equals:skinName] results] lastObject];
}

@end
