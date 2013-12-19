//
//  HttpAsynchronous.m
//  GreenTownSales
//
//  Created by loufq on 11-9-11.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "HttpAsynchronous.h"
#import "JSONKit.h"
#import "NSObject+JSON.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "LeblueRequest.h"
#import "LeblueResponse.h"
#import "NSBundle+ECUtilities.h"

#define AESKey @"01234567890123456789012345678901"

@implementation HttpAsynchronous
 




+(void)httpPostWithRequestInfo:(NSString *)url req:(LeblueRequest *)req  sucessBlock:(SuccessBlock)sucessBlock failedBlock:(FailedBlock)failedBlock completionBlock:(FinalBlock)completionBlock{
 
    
    NSURL *nUrl = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:nUrl];
    [request setTimeOutSeconds:60];
    [request addRequestHeader:@"User-Agent" value:@"iphone"];
    [request addRequestHeader:@"Cache-control" value:@"no-cache"];
    [request addRequestHeader:@"Referer" value:url];
    [request addRequestHeader:@"Content-Type" value:@"text/xml;charset=UTF-8"]; 
    //[request addRequestHeader:@"Content-Type" value:@"application/json"]; 
    [request addRequestHeader:@"Accept" value:@"application/json"];
    

    NSMutableData *body = [[[req JSONString]  dataUsingEncoding:NSUTF8StringEncoding] mutableCopy]; 
    [request setPostBody:body]; 
    [body release];  
    [request setRequestMethod:@"POST"];  
    
    [request setCompletionBlock:^(void) {
        
        NSString *retResult = [request responseString];
        retResult = [retResult stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
        retResult = [retResult stringByReplacingOccurrencesOfString:@":null}" withString:@":\"\"}"];
        
        id result = [retResult JSONValue];
        
        LeblueResponse* res = [LeblueResponse responseWithDict:result]; 
        if (res.isSuccess) {
            sucessBlock(res);
        }
        else{
            
            NSError *error = [NSError errorWithDomain:[[NSBundle mainBundle] bundleName] code:res.code.intValue userInfo:[NSDictionary dictionaryWithObjectsAndKeys:res.message,@"message", nil ]];
            
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


+(void)httpGetWithInfo:(NSString *)url sucessBlock:(SuccessBlock)sucessBlock failedBlock:(FailedBlock)failedBlock completionBlock:(FinalBlock)completionBlock{
    
    
    NSURL *nUrl = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:nUrl];
    [request setTimeOutSeconds:30];
    [request addRequestHeader:@"User-Agent" value:@"iphone"];
    [request addRequestHeader:@"Cache-control" value:@"no-cache"];
    [request addRequestHeader:@"Referer" value:url];
    [request addRequestHeader:@"Content-Type" value:@"text/xml;charset=UTF-8"]; 
    [request addRequestHeader:@"Accept" value:@"application/json"];
    
    
    [request setPostBody:nil]; 

    [request setRequestMethod:@"GET"];  
    
    [request setCompletionBlock:^(void) {
        
        NSString *retResult = [request responseString];
        retResult = [retResult stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
        retResult = [retResult stringByReplacingOccurrencesOfString:@":null}" withString:@":\"\"}"];
        
        id result = [retResult JSONValue];
        
 //       sucessBlock(result);
        
//        BResponse* res = [BResponse responseWithDict:result]; 
//        if (res.isSuccess) {
//            sucessBlock(res);
//        }
//        else{
//            
//            NSError *error = [NSError errorWithDomain:@"hotel" code:res.code.intValue userInfo:nil];
//            failedBlock(error);
//        } 
        LeblueResponse* res = [LeblueResponse responseWithDict:result]; 
        if (res.isSuccess) {
            sucessBlock(res);
        }
        else{
            
            NSError *error = [NSError errorWithDomain:[[NSBundle mainBundle] bundleName] code:res.code.intValue userInfo:[NSDictionary dictionaryWithObjectsAndKeys:res.message,@"message", nil ]];
            
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
