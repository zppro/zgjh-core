//
//  HttpAppAsynchronous.m
//  core
//
//  Created by zppro on 13-7-15.
//
//

#import "HttpAppAsynchronous.h"

#import "JSONKit.h"
#import "NSObject+JSON.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "HttpAppRequest.h"
#import "HttpAppResponse.h"
#import "NSBundle+ECUtilities.h"

@implementation HttpAppAsynchronous

+(void)httpPostWithUrl:(NSString *)url req:(HttpAppRequest *)req  sucessBlock:(SuccessBlock)sucessBlock failedBlock:(FailedBlock)failedBlock completionBlock:(FinalBlock)completionBlock{
    NSURL *nUrl = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:nUrl];
    [request setTimeOutSeconds:60];
    [request addRequestHeader:@"User-Agent" value:@"iphone"];
    [request addRequestHeader:@"Cache-control" value:@"no-cache"];
    [request addRequestHeader:@"Referer" value:url];
    //[request addRequestHeader:@"Content-Type" value:@"text/xml;charset=UTF-8"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    if(req.headData!=nil){
        for (NSString* key in req.headData.allKeys) {
            [request addRequestHeader: key value:[req.headData objectForKey:key]];
        }
    }

    NSMutableData *body = [[[req.bodyData JSONString] dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
    //NSMutableData *body = [[NSJSONSerialization dataWithJSONObject:req.bodyData options:0 error:nil] mutableCopy];
    
    [request setPostBody:body];
    [body release];
    [request setRequestMethod:@"POST"];
    
    [request setCompletionBlock:^(void) {
        
        NSString *retResult = [request responseString];
        retResult = [retResult stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
        retResult = [retResult stringByReplacingOccurrencesOfString:@":null}" withString:@":\"\"}"];
        
        id result = [retResult JSONValue];
        
        HttpAppResponse* res = [HttpAppResponse responseWithDict:result];
        if (res.success) {
            sucessBlock(res);
        }
        else{
            NSError *error = [NSError errorWithDomain:[[NSBundle mainBundle] bundleName] code:res.errorCode userInfo:[NSDictionary dictionaryWithObjectsAndKeys:res.errorMessage,@"message", nil ]];
            
            failedBlock(error);
        }
        completionBlock();
    }];
    
    [request setFailedBlock:^(void) {
        failedBlock(request.error);
        completionBlock();
    }];
    [request startAsynchronous];
}

+(void)httpGetWithUrl:(NSString *)url req:(HttpAppRequest *)req sucessBlock:(SuccessBlock)sucessBlock failedBlock:(FailedBlock)failedBlock completionBlock:(FinalBlock)completionBlock{
    
    NSURL *nUrl = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    DebugLog(@"%@",url);
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:nUrl];
    [request setTimeOutSeconds:120];
    [request addRequestHeader:@"User-Agent" value:@"iphone"];
    [request addRequestHeader:@"Cache-control" value:@"no-cache"];
    [request addRequestHeader:@"Referer" value:url];
    //[request addRequestHeader:@"Content-Type" value:@"text/xml;charset=UTF-8"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    if(req.headData!=nil){
        for (NSString* key in req.headData.allKeys) {
            [request addRequestHeader: key value:[req.headData objectForKey:key]];
        }
    }
    
    [request setPostBody:nil];
    
    [request setRequestMethod:@"GET"];
    
    [request setCompletionBlock:^(void) {
        
        NSString *retResult = [request responseString];
        retResult = [retResult stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
        retResult = [retResult stringByReplacingOccurrencesOfString:@":null}" withString:@":\"\"}"];
        
        id result = [retResult JSONValue]; 
        HttpAppResponse* res = [HttpAppResponse responseWithDict:result];
        if (res.success) {
            sucessBlock(res);
        }
        else{
            
            NSError *error = [NSError errorWithDomain:[[NSBundle mainBundle] bundleName] code:res.errorCode userInfo:[NSDictionary dictionaryWithObjectsAndKeys:res.errorMessage,@"message", nil ]];
            
            failedBlock(error);
        }
        completionBlock();
    }];
    
    [request setFailedBlock:^(void) {
        failedBlock(request.error);
        completionBlock();
    }];
    [request startAsynchronous];
}

@end
