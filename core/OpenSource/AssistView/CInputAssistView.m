//
//  CInputAssistView.m
//  AirMenu120
//
//  Created by loufq on 11-10-24.
//  Copyright (c) 2011年 Codans. All rights reserved.
//

#import "CInputAssistView.h"
#import "BlocksKit.h"
@interface CInputAssistView(P) 
-(UIBarButtonItem*)createWithTitle:(NSString*)aTitle;
-(void)initLayout;
@end


@implementation CInputAssistView
@synthesize style,textField,delegate;
- (void)dealloc {
    self.delegate = nil;
    [super dealloc];
}

+(id)createWithDelegate:(id)del{
    return [self createWithDelegate:del style:CInputAssistViewCancel];
}

+(id)createWithDelegate:(id)del style:(CInputAssistViewStyle)aStyle{
    return [self createWithDelegate:del target:nil style:aStyle];
}

+(id)createWithDelegate:(id)del target:(UITextField*)aTextField style:(CInputAssistViewStyle)aStyle{
    CInputAssistView* av = [[[self alloc] initWithFrame:CGRectMake(0, 0, 320, 44)] autorelease];
    av.delegate = del;
    av.style = aStyle;
    av.textField = aTextField;
    [av initLayout];
    return av;
}
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];    
    if (self) {
    }
    return self;
}

-(void)initLayout{
    //
    [myToolbar removeFromSuperview];
    myToolbar =[[[UIToolbar alloc] initWithFrame:self.bounds] autorelease];
    myToolbar.barStyle = UIBarStyleBlackTranslucent;
 
    UIBarButtonItem *flexibleSpace = [[[UIBarButtonItem alloc]   
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace   
                                       target:nil   
                                       action:nil] autorelease]; 
    
    UIBarButtonItem *item1 = [[[UIBarButtonItem alloc] initWithTitle:@"前一个" style:UIBarButtonItemStyleBordered handler:^(id sender) {
        if ([self.delegate respondsToSelector:@selector(inputAssistViewPerviousTapped:)]) {
            [self.delegate inputAssistViewPerviousTapped:textField];
        }
    }] autorelease];
    
    UIBarButtonItem *item2 = [[[UIBarButtonItem alloc] initWithTitle:@"下一个" style:UIBarButtonItemStyleBordered handler:^(id sender) { 
        if ([self.delegate respondsToSelector:@selector(inputAssistViewNextTapped:)]) {
            [self.delegate inputAssistViewNextTapped:textField];
        }
    }] autorelease];

    
    NSString* cancelTitle =style==CInputAssistViewHide?@"隐藏键盘":@"取消";
    if (style==CInputAssistViewHide) {
        style =CInputAssistViewCancel;
    }
    UIBarButtonItem *item3 = [[[UIBarButtonItem alloc] initWithTitle:cancelTitle style:UIBarButtonItemStyleBordered handler:^(id sender) { 
        if ([self.delegate respondsToSelector:@selector(inputAssistViewCancelTapped:)]) {
            [self.delegate inputAssistViewCancelTapped:textField];
        }
    }] autorelease];
    UIBarButtonItem *item4 = [[[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleBordered handler:^(id sender) { 
        if ([self.delegate respondsToSelector:@selector(inputAssistViewDoneTapped:)]) {
            [self.delegate inputAssistViewDoneTapped:textField];
        }
    }] autorelease];
    btnPervious = item1;
    btnNext = item2;
    btnCancel= item3;
    btnDone = item4;
    NSArray *items = nil;
    
    switch (style) {
        case CInputAssistViewNone:
             //nothing
            break;
        case CInputAssistViewPervious:
            items =  [NSArray arrayWithObjects:btnPervious,nil];  
            break;
        case CInputAssistViewPerviousAndNext:
            items =  [NSArray arrayWithObjects:btnPervious,btnNext,flexibleSpace,nil];  
            break;  
        case CInputAssistViewNext:
            items =  [NSArray arrayWithObjects:btnNext,nil];  
            break;  
        case CInputAssistViewCancel:
            items =  [NSArray arrayWithObjects:flexibleSpace,btnCancel,nil];   
            break;  
        case CInputAssistViewDone:
            items =  [NSArray arrayWithObjects:flexibleSpace,btnDone,nil];   
            break;  
        case CInputAssistViewCancelAndDone:
            items =  [NSArray arrayWithObjects:flexibleSpace,btnCancel,btnDone,nil];   
            break;  
        case CInputAssistViewAll:
            items =  [NSArray arrayWithObjects:btnPervious,btnNext,flexibleSpace,btnCancel,btnDone,nil];   
            break;  
        default:
            break;
    }
  
    myToolbar.items = items;
 
    [self addSubview:myToolbar];
}
 

@end
