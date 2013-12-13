//
//  UIImage+Scale.h
//  PonhooLibrary
//
//  Created by 钟 平 on 12-4-8.
//  Copyright (c) 2012年 ponhoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Scale)
-(UIImage*)scaleToSize:(CGSize)size;
+ (id) createRoundedRectImage:(UIImage*)image size:(CGSize)size;
+ (CGImageRef) createRoundedRectImageRef:(UIImage*)image size:(CGSize)size;
-(UIColor*) asBackgroundColor;
@end
