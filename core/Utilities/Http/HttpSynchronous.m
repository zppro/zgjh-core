//
//  HttpSynchronous.m
//  core
//
//  Created by zppro on 13-1-18.
//
//

#import "HttpSynchronous.h"
#import "ASIHTTPRequest.h"
#import "LeblueRequest.h"
#import "LeblueResponse.h" 
#import "BlocksKit.h"
#import "JSONKit.h"
#import "NSObject+JSON.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "LeblueRequest.h"
#import "LeblueResponse.h"
#import "ASIHTTPRequestDelegate.h"
#import "ASIProgressDelegate.h"
#import "NSString+Formatter.h"

@implementation HttpSynchronous
/*
 ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:NHURL(baseURL2)];
 [request setPostValue:servieRecord.callServiceId forKey:@"callServiceId"];
 [request setPostValue:appSession.userId forKey:@"userId"];
 [request setPostValue:recordedFile forKey:@"LogSoundFile"];
 [request setFile:JOINP(destDir,recordedFile) forKey:@"SoundFile"];
 
 
 request.delegate=self;
 [request setRequestMethod:@"POST"];
 request.uploadProgressDelegate = self;
 [request startSynchronous];
 
 if ([request complete])
 {
 HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
 HUD.mode = MBProgressHUDModeCustomView;
 HUD.labelText = @"上传成功";
 DebugLog(@"%@",@"上传成功");
 }
 else
 {
 HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
 HUD.mode = MBProgressHUDModeCustomView;
 HUD.labelText = @"上传失败";
 DebugLog(@"%@",@"上传失败");
 
 }
 */
+(void)httpUploadTo:(NSString *)url file:(NSString *) path data:(NSDictionary *)dict delegate:(id) delegate sucessBlock:(SuccessBlock)sucessBlock failedBlock:(FailedBlock)failedBlock completionBlock:(FinalBlock)completionBlock{
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:NHURL(url)];
    [[dict allKeys] each:^(id obj) {
        [request setPostValue:[dict objectForKey:obj] forKey:obj];
    }];
    
    [request setFile:path forKey:@"File1"];
    [request setRequestMethod:@"POST"];
    
    request.delegate=delegate;
    request.uploadProgressDelegate = delegate;
    [request startSynchronous];
    
    if ([request complete])
    {
        sucessBlock(request);
    }
    else
    {
       failedBlock(request.error);
    }
    completionBlock();
    
}

+ (void)httpDownload:(NSString *)url destination:(NSString *)path delegate:(id) delegate sucessBlock:(SuccessBlock)sucessBlock failedBlock:(FailedBlock)failedBlock completionBlock:(FinalBlock)completionBlock{
    
    NSURL *nUrl;
    if([url indexOf:@"http://"] == -1 ){
        nUrl = [NSURL URLWithString:MF_SWF(@"http://%@",url)];
    }
    else{
        nUrl = [NSURL URLWithString:url];
    }
    
    NSError *fileError;
    NSMutableArray *dirs = [NSMutableArray arrayWithArray:SPLITP(path)];
    [dirs removeLastObject];
    NSString *destDir = JOINAP(dirs);
    if(!destDir){
        fileError = [NSError errorWithDomain:@"core" code:102 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"path is not valid",@"message", nil ]];
        failedBlock(fileError);
        completionBlock();
        return;
    }
    BOOL isDir;
    if (![FMR fileExistsAtPath:destDir isDirectory:&isDir]) {
        if(isDir && ![FMR createDirectoryAtPath:destDir withIntermediateDirectories:YES attributes:nil error:&fileError]){
            failedBlock(fileError);
            completionBlock();
            return;
        }
    }
    //DebugLog(@"Download File From %@ to %@", url, path);
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:nUrl];
    request.delegate=delegate;
    request.uploadProgressDelegate = delegate;
    [request setDownloadDestinationPath:path];
    [request startSynchronous];
    
    NSError *error = [request error];
    if (error) {
        failedBlock(error);
    }
    
    int statusCode = request.responseStatusCode;

    //NSString *statusMessage = request.responseStatusMessage;
    if (statusCode != 200) {
        //DebugLog(@"Download Error - StatusCode:%d\nStatus Message:%@", statusCode, statusMessage);
        NSError *error = [NSError errorWithDomain:@"download" code:-99 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:NI(statusCode),@"statusCode", nil ]];
       failedBlock(error);
    }
    else{
        sucessBlock(request);
    }
    completionBlock();
}

@end
