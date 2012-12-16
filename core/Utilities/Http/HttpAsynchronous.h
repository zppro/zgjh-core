//
//  HttpAsynchronous.h
//  GreenTownSales
//
//  Created by loufq on 11-9-11.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Http.h"  
#import "MacroFunctions.h"

@class LeblueRequest;

@interface HttpAsynchronous : Http{  
} 



+(void)httpPostWithRequestInfo:(NSString *)url req:(LeblueRequest *)req  sucessBlock:(SuccessBlock)sucessBlock failedBlock:(FailedBlock)failedBlock completionBlock:(FinalBlock)completionBlock;

+(void)httpGetWithInfo:(NSString *)url sucessBlock:(SuccessBlock)sucessBlock failedBlock:(FailedBlock)failedBlock completionBlock:(FinalBlock)completionBlock; 

@end
