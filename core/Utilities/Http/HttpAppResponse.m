//
//  HttpAppResponse.m
//  core
//
//  Created by zppro on 13-7-15.
//
//

#import "HttpAppResponse.h"

@implementation HttpAppResponse
@synthesize error,errorCode,errorMessage,success,ret,rows;
- (void)dealloc {
    self.error = nil; 
    self.errorMessage = nil;
    self.ret = nil;
    self.rows = nil;
    [super dealloc];
}

+(id)responseWithDict:(NSDictionary*)aDictInfo{
    HttpAppResponse* res =[[[HttpAppResponse alloc] init] autorelease];
    res.error = [aDictInfo objectForKey:@"Error"];
    res.errorCode = [[aDictInfo objectForKey:@"ErrorCode"] intValue];
    res.errorMessage = [aDictInfo objectForKey:@"ErrorMessage"];
    res.success= [[aDictInfo objectForKey:@"Success"] boolValue];
    if([aDictInfo objectForKey:@"ret"]){
        res.ret = [aDictInfo objectForKey:@"ret"];
    }
    if([aDictInfo objectForKey:@"rows"]){
        res.rows = [aDictInfo objectForKey:@"rows"];
    }
    return res;
}

@end
