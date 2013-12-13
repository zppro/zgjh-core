//
//  EnumStrings.h
//  CodansShareLibrary10
//
//  Created by 钟 平 on 11-10-11.
//  Copyright 2011年 codans. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 typedef enum {
 UITextAlignmentLeft = 0,
 UITextAlignmentCenter,
 UITextAlignmentRight,                   // could add justified in future
 } UITextAlignment;
 */
typedef enum{
    CERenderType_Image,
    CERenderType_Text,
    CERenderType_TextAndImage
}CERenderType;

@interface EnumStrings : NSObject

+(NSString*) UITextAlignmentToString:(UITextAlignment) align;
+(UITextAlignment) UITextAlignmentFromString:(NSString*)s;

+(NSString*) NSTextAlignmentToString:(NSTextAlignment) align;
+(NSTextAlignment) NSTextAlignmentFromString:(NSString*)s;

+(NSString*) CERenderTypeToString:(CERenderType) renderType;
+(CERenderType) CERenderTypeFromString:(NSString*)s;
@end
