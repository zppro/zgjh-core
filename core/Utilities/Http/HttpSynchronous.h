//
//  HttpSynchronous.h
//  core
//
//  Created by zppro on 13-1-18.
//
//

#import "Http.h"
#import "MacroFunctions.h"

@class LeblueRequest;
@class LeblueResponse;

@interface HttpSynchronous : Http

+(void)httpUploadTo:(NSString *)url file:(NSString *) path data:(NSDictionary *)dict delegate:(id) delegate sucessBlock:(SuccessBlock)sucessBlock failedBlock:(FailedBlock)failedBlock completionBlock:(FinalBlock)completionBlock;

+(void)httpDownload:(NSString *)url destination:(NSString *)path delegate:(id) delegate sucessBlock:(SuccessBlock)sucessBlock failedBlock:(FailedBlock)failedBlock completionBlock:(FinalBlock)completionBlock;

+(void)httpPostWithRequestInfo:(NSString *)url req:(LeblueRequest *)req  sucessBlock:(SuccessBlock)sucessBlock failedBlock:(FailedBlock)failedBlock completionBlock:(FinalBlock)completionBlock;

+(void)httpGetWithInfo:(NSString *)url sucessBlock:(SuccessBlock)sucessBlock failedBlock:(FailedBlock)failedBlock completionBlock:(FinalBlock)completionBlock;

@end
