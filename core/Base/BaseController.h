//
//  BaseController.h
//  PonhooLibrary
//
//  Created by Tan Michael on 12-3-14.
//  Copyright (c) 2012年 ponhoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "utility.h"

@interface BaseController : UIViewController<MBProgressHUDDelegate>

@property (nonatomic, retain) MBProgressHUD             *waitView;

- (BOOL) existViewControllerInNavigation:(UIViewController*) controller;
- (NSArray*) viewControllersInNavigationByClass:(Class) controllerClass;

- (void)navigationToPrevious;
- (void)navigationToRoot;
- (void)navigationTo:(UIViewController *)controller;

- (void)showWaitView;
- (void)showWaitViewWithTitle:(NSString *)title;
- (void)showWaitViewWithTitle:(NSString *)title withAnimation:(BOOL) animated;
- (void)showWaitViewWithTitle:(NSString *)title andCloseDelay:(double) delayInSeconds;
- (void)showWaitViewWithTitle:(NSString *)title andCloseDelay:(double) delayInSeconds withAnimation:(BOOL) animated;
- (void)updateWaitViewWithTitle:(NSString *)title;
- (void)closeWaitView; 

@end
