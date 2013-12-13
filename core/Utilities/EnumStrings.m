//
//  EnumStrings.m
//  CodansShareLibrary10
//
//  Created by 钟 平 on 11-10-11.
//  Copyright 2011年 codans. All rights reserved.
//

#import "EnumStrings.h"



#define kNamesOfUITextAlignment @"Left", @"Center", @"Right", nil
#define kNamesOfNSTextAlignment @"Left", @"Center", @"Right", nil
#define kNamesOfCERenderType @"Image", @"Text",@"TextAndImage", nil

static NSArray* namesOfUITextAlignment;
static NSArray* namesOfNSTextAlignment;
static NSArray* namesOfCERenderType;

@implementation EnumStrings

+ (void) initialize {
    if (namesOfUITextAlignment == nil) {
        namesOfUITextAlignment = [[NSArray alloc] initWithObjects: kNamesOfUITextAlignment];
    }
    if (namesOfNSTextAlignment == nil) {
        namesOfNSTextAlignment = [[NSArray alloc] initWithObjects: kNamesOfNSTextAlignment];
    }
    if(namesOfCERenderType == nil){
        namesOfCERenderType = [[NSArray alloc] initWithObjects: kNamesOfCERenderType];
    }
}

+(NSString*) UITextAlignmentToString:(UITextAlignment) align
{
    return [namesOfUITextAlignment objectAtIndex:align];
}

+(UITextAlignment) UITextAlignmentFromString:(NSString*)s
{
    NSUInteger n = [namesOfUITextAlignment indexOfObject:s]; 
    if ( n == NSNotFound ) {
        n = UITextAlignmentLeft;
    }
    return (UITextAlignment) n;
}

+(NSString*) NSTextAlignmentToString:(NSTextAlignment) align{
    return [namesOfNSTextAlignment objectAtIndex:align];
}
+(NSTextAlignment) NSTextAlignmentFromString:(NSString*)s{
    NSUInteger n = [namesOfNSTextAlignment indexOfObject:s];
    if ( n == NSNotFound ) {
        n = NSTextAlignmentLeft;
    }
    return (NSTextAlignment) n;
}

+(NSString*) CERenderTypeToString:(CERenderType) renderType{
    return [namesOfCERenderType objectAtIndex:renderType];
}
+(CERenderType) CERenderTypeFromString:(NSString*)s{
    NSUInteger n = [namesOfCERenderType indexOfObject:s]; 
    if ( n == NSNotFound ) {
        n = CERenderType_Image;
    }
    return (CERenderType) n;
}

@end
