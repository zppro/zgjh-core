//
//  HttpAppRequest.m
//  core
//
//  Created by zppro on 13-7-15.
//
//

#import "HttpAppRequest.h"
#import "JSON.h"
#import "MacroFunctions.h"
#import "Functions.h"

@implementation HttpAppRequest

+(HttpAppRequest*)requestWithHead:head andBody:(NSDictionary*)body{
    
    HttpAppRequest *request = [[[HttpAppRequest alloc] init] autorelease];
    if (head == nil) {
        request.headData = [NSMutableDictionary dictionary];
    }
    else{
        request.headData = [NSMutableDictionary dictionaryWithDictionary: head];
    }
    
    request.bodyData = body;
    
    return request;
}

@end
