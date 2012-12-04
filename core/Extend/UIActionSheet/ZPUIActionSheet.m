//
//  ZPUIActionSheet.m
//  core
//
//  Created by zppro on 12-11-30.
//
//

#import "ZPUIActionSheet.h"
#import "BlocksKit.h" 
#import "MacroFunctions.h"
#import "PHResourceManager.h"
#import "UIView+Common.h"

@implementation ZPUIActionSheet
@synthesize contentView= _contentView; 

-(void)dealloc{
    [_contentView release];
    [super dealloc];
}

+(id)zSheetWithHeight:(float)height withSheetTitle:(NSString*)title{
    return [[[ZPUIActionSheet alloc] initWithHeight:height withSheetTitle:title] autorelease];
}

-(id)initWithHeight:(float)height withSheetTitle:(NSString*)title{
    
    self = [super init];
    
    if (self)
        
    {
        int theheight = height-40;
        int btnnum = theheight/50;
        btnnum = MAX(btnnum, 1);
        for(int i=0; i<btnnum; i++){ 
            [self addButtonWithTitle:@" " handler:^(void) {
                //
                if(i==0){
                    [self docancel];
                }
            }];
        }
        [self setCancelButtonIndex:0];
         
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, height+4)];
        _contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_contentView];
         
        
    }
    
    
    self.cancelButtonIndex = 1;
    return self;
    
}

-(void)done{
    [self dismissWithClickedButtonIndex:0 animated:YES];
}

-(void)docancel{
    [self dismissWithClickedButtonIndex:0 animated:YES];
}
 

// For detecting taps outside of the alert view
-(void)tapOut:(UIGestureRecognizer *)gestureRecognizer {
    CGPoint p = [gestureRecognizer locationInView:self];
    if (p.y < 0) { // They tapped outside
        [self dismissWithClickedButtonIndex:0 animated:YES];
    }
}

- (void) addTapGesture{
    // Capture taps outside the bounds of this alert view
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOut:)];
    tap.cancelsTouchesInView = NO; // So that legit taps on the table bubble up to the tableview
    [self.superview addGestureRecognizer:tap];
    [tap release];
}

-(void) showInView:(UIView *)view {
    [super showInView:view];
    [self addTapGesture];
}

- (void)showFromToolbar:(UIToolbar *)view {
    [super showFromToolbar:view];
    [self addTapGesture];
}
- (void)showFromTabBar:(UITabBar *)view {
    [super showFromTabBar:view];
    [self addTapGesture];
}
- (void)showFromBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated {
    [super showFromBarButtonItem:item animated:animated];
    [self addTapGesture];
}
- (void)showFromRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated {
    [super showFromRect:rect inView:view animated:animated];
    [self addTapGesture];
} 

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
