//
//  LeblueRequest.m
//  core
//
//  Created by zppro on 12-12-16.
//
//

#import "LeblueRequest.h"
#import "JSON.h"
#import "MacroFunctions.h"

@implementation LeblueRequest
+(id)requestWithPostData:(NSDictionary*)postData{
    
    NSDictionary *content = [NSDictionary dictionaryWithObjectsAndKeys:
                             postData,@"Data",nil];
	NSDictionary *pData = [NSDictionary dictionaryWithObjectsAndKeys:content,@"Request",nil];
    
    
    DebugLog(@"请求信息：%@", [pData JSONRepresentation]);
    
    
    return pData;
}
@end
