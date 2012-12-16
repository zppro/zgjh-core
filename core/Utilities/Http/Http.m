//
//  Http.m
//  HttpTest
//
//  Created by shrek on 10-9-9.
//  Copyright 2010 mysays.com. All rights reserved.
//

#import "Http.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"
#import "MacroFunctions.h"
#import "BaseModel.h"
//#import "IFBase.h"
#import "NSError+Helper.h"

@interface Http()
+ (NSString *)load:(NSString *)url method:(NSString *)method params:(NSDictionary *)params error:(NSError **)error;
#if NS_BLOCKS_AVAILABLE
+ (void)loadAsync:(NSString *)url method:(NSString *)method params:(NSDictionary *)params completion:(HTTPCompletionBlock)completion failed:(HTTPFailedBlock)failed;
#endif
+ (void)loadAsync:(NSString *)url method:(NSString *)method params:(NSDictionary *)params completion:(SEL)completion fialed:(SEL)failed withObject:(id)obj;
@end

@implementation Http

+ (NSString *)get:(NSString *)url error:(NSError **)error 
{
    return [self load:url method:HTTP_GET params:nil error:error];
}

#if NS_BLOCKS_AVAILABLE
+ (void)getAsync:(NSString *)url completion:(HTTPCompletionBlock)completion failed:(HTTPFailedBlock)failed
{
    [self loadAsync:url method:HTTP_GET params:nil completion:completion failed:failed];
}
#endif

+ (void)getAsync:(NSString *)url completion:(SEL)completion failed:(SEL)failed withObject:(id)obj
{
    [self loadAsync:url method:HTTP_GET params:nil completion:completion fialed:failed withObject:obj];
}

+ (NSString *)post:(NSString *)url params:(NSDictionary *)params error:(NSError **)error 
{
    return [self load:url method:HTTP_POST params:params error:error];    
}

#if NS_BLOCKS_AVAILABLE
+ (void)postAsync:(NSString *)url params:(NSDictionary *)params completion:(HTTPCompletionBlock)completion failed:(HTTPFailedBlock)failed
{
    [self loadAsync:url method:HTTP_POST params:params completion:completion failed:failed];
}
#endif

+ (NSString *)put:(NSString *)url params:(NSDictionary *)params error:(NSError **)error 
{
    return [self load:url method:HTTP_PUT params:params error:error];
}

#if NS_BLOCKS_AVAILABLE
+ (void)putAsync:(NSString *)url params:(NSDictionary *)params completion:(HTTPCompletionBlock)completion failed:(HTTPFailedBlock)failed
{
    [self loadAsync:url method:HTTP_PUT params:params completion:completion failed:failed];
}
#endif

#if NS_BLOCKS_AVAILABLE
+ (void)loadAsync:(NSString *)url method:(NSString *)method params:(NSDictionary *)params completion:(void (^)(NSString *))completion failed:(void (^)(NSError *))failed
{
    NSURL *nUrl = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    DebugLog(@"HTTP URL:%@", nUrl);
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:nUrl];
    //DebugLog(@"Time Out:%d", kTimeOut);
    [request setTimeOutSeconds:kTimeOut];
    [request addRequestHeader:@"Content-Type" value:@"application/json"]; //@"application/json" //@"text/xml;charset=UTF-8"
    [request addRequestHeader:@"User-Agent" value:@"iPhone"];
    [request addRequestHeader:@"Referer" value:(url?:@"")];
    [request setRequestMethod:method];
    
    if ([params count] > 0) {
        NSData *jsonData = [[params JSONRepresentation] dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableData *data = [[NSMutableData alloc] initWithData:jsonData];
        [request setPostBody:data];
        [data release];
    }
    
    // 开始http异步请求
    [request startAsynchronous];
    
    // use __block avoid retain-cycle
    __block ASIHTTPRequest *req = request;
    [request setFailedBlock:^(void) {
        if (failed) {
            failed(req.error);
        }
    }];
    
    [request setCompletionBlock:^(void) {
        // 处理返回值
        int      statusCode     = req.responseStatusCode;
        NSString *statusMessage = req.responseStatusMessage;
        NSString *response      = req.responseString;
        
        //DebugLog(@"URL:%@", url);
        DebugLog(@"StatusCode:%d---StatusMessage:%@\nResponse:%@", statusCode, statusMessage, response);
        
        // 状态值不为成功
        if (statusCode != 200) {
            NSDictionary *userInfo = [[[NSDictionary alloc] initWithObjectsAndKeys:statusMessage,NSLocalizedDescriptionKey, nil] autorelease];
            NSError *error = [NSError errorWithDomain:@"http" code:statusCode userInfo:userInfo];
            if (failed) {
                failed(error);
            }
            return;
        } 
        
        // 状态值为200
        if (completion) {
            completion(response);
        }
    }];
}
#endif

+ (NSString *)load:(NSString *)url method:(NSString *)method params:(NSDictionary *)params error:(NSError **)error 
{
    NSURL *nUrl = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    DebugLog(@"HTTP URL:%@", nUrl);
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:nUrl];
    //DebugLog(@"Time Out:%d", kTimeOut);
    [request setTimeOutSeconds:kTimeOut];
    [request addRequestHeader:@"Content-Type" value:@"application/json"]; //@"application/json" //@"text/xml;charset=UTF-8"
    [request addRequestHeader:@"User-Agent" value:@"iPhone"];
    [request addRequestHeader:@"Referer" value:(url?:@"")];
    [request setRequestMethod:method];
    
    if ([params count] > 0) {
        NSData *jsonData = [[params JSONRepresentation] dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableData *data = [[NSMutableData alloc] initWithData:jsonData];
        [request setPostBody:data];
        [data release];
    }
    
    // 开始http请求 同步
    [request startSynchronous];
    
    // 检测http错误
    NSError *requestError = [request error];
    if (requestError != nil) {
        DebugLog(@"HTTP ERROR:%@", requestError);
        
        if (error != nil) {
            NSString *domain = url;//[[NSURL URLWithString:url] host];
            NSString *errorMsg = [NSString stringWithFormat:@"%@:%@", 
                                  domain, requestError.localizedDescription];
            NSError *errorWithUrl = [NSError errorWithMsg:errorMsg];
            
            *error = errorWithUrl;
        }
        return nil;
    }
    
    // 处理返回值
    int      statusCode     = request.responseStatusCode;
    NSString *statusMessage = request.responseStatusMessage;
    NSString *response      = request.responseString;
    DebugLog(@"StatusCode:%d---StatusMessage:%@\nResponse:%@", statusCode, statusMessage, response);
    
    if (statusCode != 200) {
        if (error) {
            NSDictionary *userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:statusMessage,NSLocalizedDescriptionKey, nil];
            *error = [NSError errorWithDomain:@"http" code:statusCode userInfo:userInfo];
            [userInfo release];
        }
        return nil;
    }
    
    return response;
}

+ (void)loadAsync:(NSString *)url method:(NSString *)method params:(NSDictionary *)params completion:(SEL)completion fialed:(SEL)failed withObject:(id)obj
{
    NSURL *nUrl = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    //DebugLog(@"HTTP URL:%@", nUrl);
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:nUrl];
    //DebugLog(@"Time Out:%d", kTimeOut);
    [request setTimeOutSeconds:kTimeOut];
    [request addRequestHeader:@"Content-Type" value:@"application/json"]; //@"application/json" //@"text/xml;charset=UTF-8"
    [request addRequestHeader:@"User-Agent" value:@"iPhone"];
    [request addRequestHeader:@"Referer" value:(url?:@"")];
    [request setRequestMethod:method];
    
    if ([params count] > 0) {
        NSData *jsonData = [[params JSONRepresentation] dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableData *data = [[NSMutableData alloc] initWithData:jsonData];
        [request setPostBody:data];
        [data release];
    }
    
    // 开始http异步请求
    [request startAsynchronous];
    
    request.delegate = obj;
    request.didFinishSelector = completion;
    request.didFailSelector = failed;
}

+ (BOOL)download:(NSString *)url destination:(NSString *)path 
{
    NSURL *nUrl = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    //DebugLog(@"Download File From %@ to %@", url, path);
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:nUrl];
    [request setDownloadDestinationPath:path];
    [request startSynchronous];
    
    NSError *error = [request error];
    if (error) {
        //DebugLog(@"Download Error:%@", error);
        return NO;
    }
    
    int statusCode = request.responseStatusCode;
    //NSString *statusMessage = request.responseStatusMessage;
    if (statusCode != 200) {
        //DebugLog(@"Download Error - StatusCode:%d\nStatus Message:%@", statusCode, statusMessage);
        return NO;
    }
    
    //DebugLog(@"%@", @"Download Success!!!!!!");
    return YES;
}

+ (void)download:(NSString *)url destination:(NSString *)path complete:(HTTPCompletionBlock)complete failed:(HTTPFailedBlock)failed {
    NSURL *nUrl = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:nUrl];
    [request setDownloadDestinationPath:path];
    [request startAsynchronous];
    
    __block ASIHTTPRequest *req = request;
    [request setFailedBlock:^{
        if (failed) {
            failed(req.error);
        }
    }];
    [request setCompletionBlock:^{
        // 处理返回值
        int      statusCode     = req.responseStatusCode;
        NSString *statusMessage = req.responseStatusMessage;
        //NSString *response      = req.responseString;
        //DebugLog(@"StatusCode:%d---StatusMessage:%@\nResponse:%@", statusCode, statusMessage, response);
        
        // 状态值不为成功
        if (statusCode != 200) {
            NSDictionary *userInfo = [[[NSDictionary alloc] initWithObjectsAndKeys:statusMessage,NSLocalizedDescriptionKey, nil] autorelease];
            NSError *error = [NSError errorWithDomain:@"http" code:statusCode userInfo:userInfo];
            if (failed) {
                failed(error);
            }
            return;
        } 
        
        // 状态值为200
        if (complete) {
            complete(nil);
        }
    }];
}

+ (NSDictionary*) requestTo:(NSString*)urlString byDelegate:(id) delegate withSendData:(NSDictionary*) dataOfSend andMethod:(NSString*) method  andHeads:(NSDictionary*) headOfSend usingConnection:(NSURLConnection**) connection{
    @try {
        //NSLog(@"dataOfSend:%@",dataOfSend);
        //NSLog(@"urlString:%@",urlString); 
        NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
        NSHTTPURLResponse *response = nil;  
        NSError *error = [[[NSError alloc] init] autorelease];  
        NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] initWithURL:url] autorelease]; 
        for (NSString* key in headOfSend.allKeys) {
            [request setValue:[headOfSend objectForKey:key] forHTTPHeaderField:key];
        } 
        [request setHTTPMethod:method];
        
        NSData *returnData;
        if ([method isEqualToString:@"GET"]) {
            if(delegate != nil){
                *connection = [NSURLConnection connectionWithRequest:request delegate:delegate];
                return nil;
            }
            else{
                returnData = [NSURLConnection sendSynchronousRequest:request 
                                                   returningResponse:&response error:&error]; 
            }              
            
        }
        else if([method isEqualToString:@"POST"]){
            
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            if(dataOfSend != nil && [dataOfSend count] > 0){
                NSData* postData = [[dataOfSend JSONRepresentation] dataUsingEncoding:NSUTF8StringEncoding]; 
                [request setHTTPBody:postData];
            }
            
            if(delegate != nil){
                *connection = [NSURLConnection connectionWithRequest:request delegate:delegate];
                return nil;
            }
            else{
                returnData = [NSURLConnection sendSynchronousRequest:request 
                                                   returningResponse:&response error:&error];
            }
        } 
        
        //NSLog(@"statusCode : %d", [response statusCode] );
        /*
        if ([response statusCode] >= 200 && [response statusCode] < 300) { 
            
            NSString* newStr = [[[NSString alloc] initWithData:returnData
                                                      encoding:NSUTF8StringEncoding] autorelease];
            //NSLog(@"newStr: %@",newStr);
            return [newStr JSONValue];
            
        }
        else{
            return nil;
        }
         */
        NSMutableDictionary *result = nil;
        int statusCode = [response statusCode];
        if (statusCode >= 200 && statusCode < 300) { 
            
            NSString* newStr = [[[NSString alloc] initWithData:returnData
                                                      encoding:NSUTF8StringEncoding] autorelease];
            result = [NSMutableDictionary dictionaryWithDictionary:[newStr JSONValue]]; 
        }
        else{
            if(statusCode == Unauthorized){
                result = [NSMutableDictionary dictionaryWithDictionary:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:0],@"Success",@"未授权",@"ErrorMessage", nil]];
            }
            else if(statusCode == Forbidden){
                result = [NSMutableDictionary dictionaryWithDictionary:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:0],@"Success",@"禁止访问",@"ErrorMessage", nil]];
            }
            else{
                result = [NSMutableDictionary dictionary];
            }
        }
        [result setObject:NI(statusCode) forKey:@"StatusCode"]; 
        return result;
    }
    @catch (NSException *exception) { 
        NSDictionary *exceptionResult = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:0],@"Success",[exception description],@"ErrorMessage", nil];
        return exceptionResult;
    }
}

+ (NSDictionary*) post:(NSString*)urlString withFile:(NSData*) fileData andFileName:(NSString*)fileName andHeads:(NSDictionary*) headOfSend usingConnection:(NSURLConnection**) connection{
    @try {
        NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
        NSHTTPURLResponse *response = nil;  
        NSError *error = [[[NSError alloc] init] autorelease];  
        NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
        [request setURL:url];
        [request setHTTPMethod:@"POST"]; 
        for (NSString* key in headOfSend.allKeys) {
            [request setValue:[headOfSend objectForKey:key] forHTTPHeaderField:key];
        }  
        NSString *boundary = @"---------------------------14737809831466499882746641449";
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
        [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
        
        /*
         now lets create the body of the post
         */
        NSMutableData *body = [NSMutableData data];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        NSString *contentDisposition = MF_SWF(@"Content-Disposition: form-data; name=\"userfile\"; filename=\"%@\"\r\n", fileName);
        [body appendData:[contentDisposition dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:fileData];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        // setting the body of the post to the reqeust
        [request setHTTPBody:body];
        
        // now lets make the connection to the web
        NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        NSMutableDictionary *result = nil;
        int statusCode = [response statusCode];
        if (statusCode >= 200 && statusCode < 300) { 
            
            NSString* newStr = [[[NSString alloc] initWithData:returnData
                                                      encoding:NSUTF8StringEncoding] autorelease];
            result = [NSMutableDictionary dictionaryWithDictionary:[newStr JSONValue]]; 
        }
        else{
            if(statusCode == Unauthorized){
                result = [NSMutableDictionary dictionaryWithDictionary:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:0],@"Success",@"未授权",@"ErrorMessage", nil]];
            }
            else if(statusCode == Forbidden){
                result = [NSMutableDictionary dictionaryWithDictionary:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:0],@"Success",@"禁止访问",@"ErrorMessage", nil]];
            }
            else if(statusCode == NotAcceptable){
                result = [NSMutableDictionary dictionaryWithDictionary:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:0],@"Success",@"未接受",@"ErrorMessage", nil]];
            }
            else{
                result = [NSMutableDictionary dictionary];
            }
        }
        [result setObject:NI(statusCode) forKey:@"StatusCode"]; 
        return result;
    }
    @catch (NSException *exception) { 
        NSDictionary *exceptionResult = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:0],@"Success",[exception description],@"ErrorMessage", nil];
        return exceptionResult;
    }
}


+ (void)loadAsync:(NSString *)url method:(NSString *)method headers:(NSDictionary *)headers params:(NSDictionary *)params completion:(void (^)(NSString *))completion failed:(void (^)(NSError *))failed
{
    NSURL *nUrl = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    DebugLog(@"HTTP URL:%@", nUrl);
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:nUrl];
    //DebugLog(@"Time Out:%d", kTimeOut);
    [request setTimeOutSeconds:kTimeOut];
    [request addRequestHeader:@"Content-Type" value:@"application/json"]; //@"application/json" //@"text/xml;charset=UTF-8"
    [request addRequestHeader:@"User-Agent" value:@"iPhone"];
    [request addRequestHeader:@"Referer" value:(url?:@"")];
    [request setRequestMethod:method];
    
    for (NSString *key in headers.allKeys) {
        [request addRequestHeader:key value:[headers objectForKey:key]];
    } 
    
    if ([params count] > 0) {
        NSData *jsonData = [[params JSONRepresentation] dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableData *data = [[NSMutableData alloc] initWithData:jsonData];
        [request setPostBody:data];
        [data release];
    }
    
    // 开始http异步请求
    [request startAsynchronous];
    
    // use __block avoid retain-cycle
    __block ASIHTTPRequest *req = request;
    [request setFailedBlock:^(void) {
        if (failed) {
            
            NSString *domain = [[NSURL URLWithString:url] host];
            NSString *errorMsg = [NSString stringWithFormat:@"%@:%@", 
                                  domain, req.error.localizedDescription];
            
            NSError *errorWithUrl = [NSError errorWithMsg:errorMsg];
            failed(errorWithUrl);
        }
    }];
    
    [request setCompletionBlock:^(void) {
        // 处理返回值
        int      statusCode     = req.responseStatusCode;
        NSString *statusMessage = req.responseStatusMessage;
        NSString *response      = req.responseString;
        
        //DebugLog(@"URL:%@", url);
        DebugLog(@"StatusCode:%d---StatusMessage:%@\nResponse:%@", statusCode, statusMessage, response);
        
        // 状态值不为成功
        if (statusCode != 200) {
            NSDictionary *userInfo = [[[NSDictionary alloc] initWithObjectsAndKeys:statusMessage,NSLocalizedDescriptionKey, nil] autorelease];
            NSError *error = [NSError errorWithDomain:@"http" code:statusCode userInfo:userInfo];
            if (failed) {
                failed(error);
            }
            return;
        } 
        
        // 状态值为200
        if (completion) {
            completion(response);
        }
    }];
}

@end
