//
//  PHResourceManager.m
//  PonhooLibrary
//
//  Created by Tan Michael on 12-2-20.
//  Copyright (c) 2012年 ponhoo. All rights reserved.
//

#import "PHResourceManager.h"


@implementation PHResourceManager

+ (UIImage *)getImageWithName:(NSString *)imageName andSkinName:(NSString *)skinName {
    if(skinName == nil) skinName = @"Default";
    
    NSString* path = [MF_DocumentFolder() stringByAppendingFormat:@"/%@/%@", skinName, imageName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSAssert(path != nil, @"%@", path);
        path = [MF_ResourceDocument() stringByAppendingFormat:@"/%@/%@", skinName, imageName];
        if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
            NSAssert(path != nil, @"%@", path);
            path = MF_Resource(MF_SWF(@"%@/%@", skinName, imageName));
            if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
                NSAssert(path != nil, @"%@", path);
                return nil;
            }
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
            path = MF_Resource(MF_SWF(@"/%@", imageName));
            if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
                NSAssert(path != nil, @"%@", path);
                return nil;
            }
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

+ (void) moveResourceFrom:(NSString *)sourcePath To:(NSString*) destPath sucessBlock:(SuccessBlock)sucessBlock failedBlock:(FailedBlock)failedBlock completionBlock:(FinalBlock)completionBlock{
    NSError *moveError;
    if (!MF_FileExists(sourcePath)){
        moveError = [NSError errorWithDomain:@"core" code:101 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"sourcePath is not exist",@"message", nil ]];
        
        failedBlock(moveError);
        completionBlock();
        return;
    }
    if (MF_FileExists(destPath)){
        //删除
        if(![FMR removeItemAtPath:destPath error:&moveError]){
            failedBlock(moveError);
            completionBlock();
            return;
        } 
    }
    
    
    NSMutableArray *dirs = [NSMutableArray arrayWithArray:SPLITP(destPath)];
    [dirs removeLastObject];
    NSString *destDir = JOINAP(dirs);
    if(!destDir){
        moveError = [NSError errorWithDomain:@"core" code:102 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"destPath is not valid",@"message", nil ]];
        failedBlock(moveError);
        completionBlock();
        return;
    }
    BOOL isDir;
    if (![FMR fileExistsAtPath:destDir isDirectory:&isDir]) {
        if(isDir && ![FMR createDirectoryAtPath:destDir withIntermediateDirectories:YES attributes:nil error:&moveError]){
            failedBlock(moveError);
            completionBlock();
            return;
        }
    }
    
    if([FMR moveItemAtPath:sourcePath toPath:destPath error:&moveError]){
        sucessBlock([NSDictionary dictionary]);
    }
    else{
        failedBlock(moveError);
    }
    completionBlock();
}

@end
