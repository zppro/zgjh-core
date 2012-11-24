//
//  CInputAssistView.h
//  AirMenu120
//
//  Created by loufq on 11-10-24.
//  Copyright (c) 2011年 Codans. All rights reserved.
//  输入辅助类

/*
 
 //create
 //默认有取消按钮
 tf.inputAccessoryView = [CInputAssistView createWithDelegate:self]; 
 tf.inputAccessoryView = [CInputAssistView createWithDelegate:self style:CInputAssistViewAll];
 tf.inputAccessoryView = [CInputAssistView createWithDelegate:self target:tf style:CInputAssistViewAll];

 //delegate
 
 -(void)inputAssistViewPerviousTapped:(UITextField*)aTextFiled{
 DebugLog(@"%@", @"inputAssistViewPerviousTapped"); 
 }
 -(void)inputAssistViewNextTapped:(UITextField*)aTextFiled{
 DebugLog(@"%@", @"inputAssistViewNextTapped");    
 }
 
 -(void)inputAssistViewCancelTapped:(UITextField*)aTextFiled{
 DebugLog(@"%@", @"inputAssistViewCancelTapped");     
 [self removeFromSuperview];
 }
 
 -(void)inputAssistViewDoneTapped:(UITextField*)aTextFiled{
 DebugLog(@"%@", @"inputAssistViewDoneTapped");    
 }
 
 */



typedef enum {
    CInputAssistViewNone,//什么也没有
    CInputAssistViewPervious,//前一个
    CInputAssistViewPerviousAndNext,//上一个 下一个
    CInputAssistViewNext,//下一个
    CInputAssistViewCancel,//取消
    CInputAssistViewDone,//确定
    CInputAssistViewCancelAndDone,//取消 确定
    CInputAssistViewAll,//前一个 后一个 取消 确定
     CInputAssistViewHide,
} CInputAssistViewStyle;

@protocol CInputAssistViewDelgate <NSObject>

-(void)inputAssistViewPerviousTapped:(UITextField*)aTextFiled;
-(void)inputAssistViewNextTapped:(UITextField*)aTextFiled;
-(void)inputAssistViewCancelTapped:(UITextField*)aTextFiled;
-(void)inputAssistViewDoneTapped:(UITextField*)aTextFiled;
 

@end

@interface CInputAssistView : UIView{
    
    UIBarButtonItem* btnPervious;
    UIBarButtonItem* btnNext;
    UIBarButtonItem* btnCancel;
    UIBarButtonItem* btnDone;   
    UIToolbar* myToolbar;
}
@property(nonatomic,assign)CInputAssistViewStyle style;
@property(nonatomic,assign)UITextField* textField;
@property(nonatomic,assign)id<CInputAssistViewDelgate> delegate;

//带隐藏键盘按钮
+(id)createWithDelegate:(id)del;

+(id)createWithDelegate:(id)del style:(CInputAssistViewStyle)aStyle;

+(id)createWithDelegate:(id)del target:(UITextField*)aTextField style:(CInputAssistViewStyle)aStyle;

@end
