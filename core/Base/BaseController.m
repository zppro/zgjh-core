//
//  BaseController.m
//  PonhooLibrary
//
//  Created by Tan Michael on 12-3-14.
//  Copyright (c) 2012年 ponhoo. All rights reserved.
//

#import "BaseController.h"

@implementation BaseController

@synthesize waitView = _waitView;

- (void)dealloc {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    [_waitView release];
    
    [super dealloc];
}

#pragma mark common function
- (void)presentSms:(MFMessageComposeViewController*) picker From:(UIViewController*) fromController{
    pickerFromController = fromController;
    picker.messageComposeDelegate = self;
    [pickerFromController presentModalViewController:picker animated:YES];
    
}
- (void)presentMail:(MFMailComposeViewController*) picker From:(UIViewController*) fromController{
    pickerFromController = fromController;
    picker.mailComposeDelegate = self;
    [pickerFromController presentModalViewController:picker animated:YES];
}


#pragma mark MFMessageComposeViewControllerDelegate
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result {
    switch (result) {
        case MessageComposeResultCancelled:
            break;
        case MessageComposeResultSent:
            [self showWaitViewWithTitle:@"短信发送成功"];
            break;
        case MessageComposeResultFailed:
            [self showWaitViewWithTitle:@"短信发送失败"];
            break;
        default:
            break;
    }
    [pickerFromController dismissModalViewControllerAnimated:YES];
}


#pragma mark MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error {
    switch (result)
    {
        case MFMailComposeResultCancelled: {
            break;
        }
        case MFMailComposeResultSaved:
            [self showWaitViewWithTitle:@"邮件保存成功"];
            break;
        case MFMailComposeResultSent:
            [self showWaitViewWithTitle:@"邮件发送成功"];
            break;
        case MFMailComposeResultFailed:
            [self showWaitViewWithTitle:@"邮件发送失败"];
            break;
        default:
            break;
    }
    [pickerFromController dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods
- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [_waitView removeFromSuperview];
}

#pragma mark -
#pragma mark - Navigation
- (BOOL) existViewControllerInNavigation:(UIViewController*) controller {
    for (UIViewController* viewController in self.navigationController.viewControllers) {
        if(viewController == controller){
            return TRUE;
        }
    }
    return FALSE;
} 

- (NSArray*) viewControllersInNavigationByClass:(Class) controllerClass {
    NSMutableArray* results = [[[NSMutableArray alloc] init] autorelease];
    for (UIViewController* viewController in self.navigationController.viewControllers) {
        if([viewController class] == controllerClass){
            [results addObject:viewController];
        }
    }
    return results;
}

- (void)navigationToPrevious{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)navigationToRoot{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)navigationTo:(UIViewController *)controller {
    [self performSelector:@selector(pushController:) withObject:controller afterDelay:0.07 * 2];
}

- (void)pushController:(UIViewController *)theController{
    [self.navigationController pushViewController:theController animated:YES];
}

#pragma mark - waitingView


- (void)showWaitView {
    [self showWaitViewWithTitle:@"" andCloseDelay:0 withAnimation:YES];
}

- (void)showWaitViewWithTitle:(NSString *)title {
    [self showWaitViewWithTitle:title andCloseDelay:0 withAnimation:YES];
}

- (void)showWaitViewWithTitle:(NSString *)title withAnimation:(BOOL) animated {
    [self showWaitViewWithTitle:title andCloseDelay:0 withAnimation:animated];
}

- (void)showWaitViewWithTitle:(NSString *)title andCloseDelay:(double) delayInSeconds {
    [self showWaitViewWithTitle:title andCloseDelay:delayInSeconds withAnimation:YES];
}

- (void)showWaitViewWithTitle:(NSString *)title andCloseDelay:(double) delayInSeconds withAnimation:(BOOL) animated {
    self.waitView.labelText = title;
    [self.view addSubview:self.waitView];
    DebugLog(@"view:%@",NSStringFromCGRect(self.view.frame));
    [self.view bringSubviewToFront:self.waitView]; 
    [self.waitView show:animated];
    if(delayInSeconds > 0){
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            if (self.waitView) {
                [self.waitView hide:YES];
            }
        });
    }
}


- (void)updateWaitViewWithTitle:(NSString *)title {
    self.waitView.labelText = title;
}

- (void)closeWaitView {
    if (self.waitView) {
        [self.waitView hide:YES];
    }
}


@end
