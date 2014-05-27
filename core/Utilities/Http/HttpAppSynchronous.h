//
//  HttpAppSynchronous.h
//  core
//
//  Created by zppro on 14-4-22.
//
//

#import "Http.h"
#import "MacroFunctions.h"

@class HttpAppRequest;

@interface HttpAppSynchronous : Http

+(void)httpPostWithUrl:(NSString *)url req:(HttpAppRequest *)req  sucessBlock:(SuccessBlock)sucessBlock failedBlock:(FailedBlock)failedBlock completionBlock:(FinalBlock)completionBlock;

+(void)httpGetWithUrl:(NSString *)url req:(HttpAppRequest *)req sucessBlock:(SuccessBlock)sucessBlock failedBlock:(FailedBlock)failedBlock completionBlock:(FinalBlock)completionBlock;

@end
