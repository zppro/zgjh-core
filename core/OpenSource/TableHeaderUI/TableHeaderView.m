//
//  TableHeaderView.m
//  AirMenu120
//
//  Created by Tan Michael on 11-9-27.
//  Copyright 2011年 Codans. All rights reserved.
//

#import "TableHeaderView.h"
#import "MacroFunctions.h"
#import "PHResourceManager.h"
#import "UIView+Common.h"

@implementation TableHeaderView

@synthesize headerTitleBGView = _headerTitleBGView;
@synthesize headerLabel = _headerLabel;
@synthesize operationButton = _operationButton; 
@synthesize backBautton = _backBautton; 
@synthesize delegate = _delegate;

#pragma mark - init&dealloc
- (id)initWithFrame:(CGRect)frame andBackButtonImage:(UIImage*) backButtonImage andTitleBGImage:(UIImage *)titleBGImage{
    return [self initWithFrame:frame andBackButtonImage:backButtonImage andTitleBGImage:titleBGImage andOperBtnImage:nil];
}
- (id)initWithFrame:(CGRect)frame andBackButtonImage:(UIImage*) backButtonImage andTitleBGImage:(UIImage *)titleBGImage andOperBtnImage:(UIImage *)operImage {
    self = [super initWithFrame:frame];
    if (self) {
        _headerTitleBGView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _headerTitleBGView.image = titleBGImage;
        [self addSubview:_headerTitleBGView];
        
        _headerLabel = [[UILabel alloc] initWithFrame:frame];
        _headerLabel.textColor = [UIColor whiteColor];
        _headerLabel.backgroundColor = [UIColor clearColor];
        _headerLabel.textAlignment = UITextAlignmentCenter;
        _headerLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];//[UIFont systemFontOfSize:16];//
        [self addSubview:_headerLabel];

        
        self.backBautton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBautton setFrame:CGRectMake(5, abs(frame.size.height-(2+backButtonImage.size.height)/2.f)/2.f, (1+backButtonImage.size.width)/2.f ,(2+backButtonImage.size.height)/2.f)];
        [_backBautton setImage:backButtonImage forState:UIControlStateNormal];
        [_backBautton addTarget:self action:@selector(doBack) forControlEvents:UIControlEventTouchUpInside];
        [_backBautton setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_backBautton];
        
        
        if(operImage!=nil){
            self.operationButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [_operationButton setFrame:CGRectMake(frame.size.width - 5 - (2+operImage.size.width)/2.f, abs(frame.size.height-(2+operImage.size.height)/2.f)/2.f, (2+operImage.size.width)/2.f,(2+operImage.size.height)/2.f)];
            [_operationButton setImage:operImage forState:UIControlStateNormal];
            [_operationButton addTarget:self action:@selector(doOperation) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_operationButton];
        } 
                
    }
    return self;
} 

- (void)dealloc {
    [_headerTitleBGView release];
    [_headerLabel release];
    [_operationButton release];
    [_backBautton release];  
    
    [super dealloc];
}

#pragma mark - button method 
- (void)doOperation { 
    if(_delegate != nil){
        if([(id)_delegate respondsToSelector:@selector(operationButtonOnClick)]){
            [(id)_delegate performSelector:@selector(operationButtonOnClick)];
        } 
    }
} 

- (void)doBack { 
    if(_delegate != nil && [(id)_delegate respondsToSelector:@selector(backButtonOnClickWithPOPVC)]){
        [_delegate backButtonOnClickWithPOPVC];
        return;
    }
    
    if(_delegate != nil){
        if([(id)_delegate respondsToSelector:@selector(backButtonOnClick)]){
            [_delegate backButtonOnClick];
        } 
    }
    [[self belongController].navigationController popViewControllerAnimated:YES];
}

@end
