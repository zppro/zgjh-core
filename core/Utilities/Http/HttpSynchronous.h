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

@interface HttpSynchronous : Http

+(void)httpUploadTo:(NSString *)url file:(NSString *) path data:(NSDictionary *)dict delegate:(id) delegate sucessBlock:(SuccessBlock)sucessBlock failedBlock:(FailedBlock)failedBlock completionBlock:(FinalBlock)completionBlock;

+(void)httpDownload:(NSString *)url destination:(NSString *)path delegate:(id) delegate sucessBlock:(SuccessBlock)sucessBlock failedBlock:(FailedBlock)failedBlock completionBlock:(FinalBlock)completionBlock;

@end
