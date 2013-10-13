//
//  HttpAppAsynchronous.h
//  core
//
//  Created by zppro on 13-7-15.
//
//

#import "Http.h"
#import "MacroFunctions.h"

@class HttpAppRequest;

@interface HttpAppAsynchronous : Http

+(void)httpPostWithUrl:(NSString *)url req:(HttpAppRequest *)req  sucessBlock:(SuccessBlock)sucessBlock failedBlock:(FailedBlock)failedBlock completionBlock:(FinalBlock)completionBlock;

+(void)httpGetWithUrl:(NSString *)url req:(HttpAppRequest *)req sucessBlock:(SuccessBlock)sucessBlock failedBlock:(FailedBlock)failedBlock completionBlock:(FinalBlock)completionBlock;

@end
