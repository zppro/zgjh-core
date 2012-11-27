//
//  TableHeaderView.h
//  AirMenu120
//
//  Created by Tan Michael on 11-9-27.
//  Copyright 2011年 Codans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableHeaderDelegate.h"

@interface TableHeaderView : UIView

@property (nonatomic, retain) UIImageView               *headerTitleBGView;
@property (nonatomic, retain) UILabel                   *headerLabel;
@property (nonatomic, retain) UIButton                  *backBautton;
@property (nonatomic, retain) UIButton                  *operationButton; 
@property (nonatomic, assign) id<TableHeaderDelegate>   delegate;

- (id)initWithFrame:(CGRect)frame andBackButtonImage:(UIImage*) backButtonImage andTitleBGImage:(UIImage *)titleBGImage;
- (id)initWithFrame:(CGRect)frame andBackButtonImage:(UIImage*) backButtonImage andTitleBGImage:(UIImage *)titleBGImage andOperBtnImage:(UIImage *)operImage;
@end
