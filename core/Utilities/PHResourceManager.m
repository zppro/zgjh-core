//
//  PHResourceManager.m
//  PonhooLibrary
//
//  Created by Tan Michael on 12-2-20.
//  Copyright (c) 2012年 ponhoo. All rights reserved.
//

#import "PHResourceManager.h"
#import "MacroFunctions.h"

@implementation PHResourceManager

+ (UIImage *)getImageWithName:(NSString *)imageName andSkinName:(NSString *)skinName {
    if(skinName == nil) skinName = @"Default";
    
    NSString* path = [MF_DocumentFolder() stringByAppendingFormat:@"/%@/%@", skinName, imageName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSAssert(path != nil, @"%@", path);
        path = [MF_ResourceDocument() stringByAppendingFormat:@"/%@/%@", skinName, imageName];
        if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
            NSAssert(path != nil, @"%@", path);
            return nil;
        }
    }
    UIImage *image = [UIImage imageWithContentsOfFile:path]; 
    return image;
}

+ (UIImage *)getImageWithName:(NSString *)imageName {
    NSString* path = [MF_DocumentFolder() stringByAppendingFormat:@"/%@", imageName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSAssert(path != nil, @"%@", path);
        path = [MF_ResourceDocument() stringByAppendingFormat:@"/%@", imageName];
        if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
            NSAssert(path != nil, @"%@", path);
            return nil;
        }
    }
    UIImage *image = [UIImage imageWithContentsOfFile:path]; 
    return image;
}

+ (NSString *)getResourcePath:(NSString *)name {
    NSBundle *bundle =[NSBundle mainBundle];
    return [[bundle resourcePath] stringByAppendingFormat:@"/Documents/Skins/%@", name];
}

+ (NSString *)getFilePath:(NSString *)fileName {
    if(fileName == nil || [fileName isEqualToString:@""]){
        return nil;
    }
    NSString *filePath = [MF_DocumentFolder() stringByAppendingPathComponent:fileName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        filePath = [MF_ResourceDocument() stringByAppendingPathComponent:fileName];
        if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            return nil;
        }
    }
    return filePath;
}

@end
