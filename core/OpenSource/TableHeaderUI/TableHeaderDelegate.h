//
//  TableHeaderDelegate.h
//  AirMenu120
//
//  Created by Tan Michael on 11-9-27.
//  Copyright 2011年 Codans. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TableHeaderDelegate

@optional
- (void)operationButtonOnClick;
- (void)backButtonOnClick;  
- (void)backButtonOnClickWithPOPVC;
@end
