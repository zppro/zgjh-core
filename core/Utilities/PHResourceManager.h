//
//  PHResourceManager.h
//  PonhooLibrary
//
//  Created by Tan Michael on 12-2-20.
//  Copyright (c) 2012年 ponhoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MacroFunctions.h"
@interface PHResourceManager : NSObject

+ (UIImage *)getImageWithName:(NSString *)imageName andSkinName:(NSString *)skinName;
+ (UIImage *)getImageWithName:(NSString *)imageName;
+ (NSString *)getResourcePath:(NSString *)name;
+ (NSString *)getFilePath:(NSString *)fileName;

+ (void) moveResourceFrom:(NSString *)sourcePath To:(NSString*) destPath sucessBlock:(SuccessBlock)sucessBlock failedBlock:(FailedBlock)failedBlock completionBlock:(FinalBlock)completionBlock;

@end
