//
//  SkinElement.h
//  AirHotel
//
//  Created by Tan Michael on 12-2-7.
//  Copyright (c) 2012年 ponhoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SkinElement : NSObject

@property (nonatomic, retain) NSString      *name;
@property (nonatomic, retain) NSString      *frame;
@property (nonatomic, retain) NSNumber      *tag;
@property (nonatomic, retain) NSString      *text;
@property (nonatomic, retain) NSNumber      *font;
@property (nonatomic, retain) NSString      *textColor;
@property (nonatomic, retain) NSString      *textAlignment;
@property (nonatomic, retain) NSString      *enabled;
@property (nonatomic, retain) NSString      *hidden;
@property (nonatomic, retain) NSString      *backgroundColor;
@property (nonatomic, retain) NSString      *image;
@property (nonatomic, retain) NSString      *backImage;
@property (nonatomic, retain) NSString      *elementType;

- (id)initWithDictionary:(NSDictionary *)elementConfig;
- (id)generateObject;

@end
