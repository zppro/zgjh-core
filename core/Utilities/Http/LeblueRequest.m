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
#import "Functions.h"

@implementation LeblueRequest

+(id)requestWithHead:(NSInteger)NWCode WithPostData:(NSDictionary*)postData{
    if(NWCode == -1){
        DebugLog(@"无效的NWCode：%@", NI(NWCode));
        return nil;
    }
    NSDictionary *head = [NSDictionary dictionaryWithObjectsAndKeys:
                          GetCurrentDateString(@"yyyyMMddHHmm"),@"NWGUID",NI(NWCode),@"NWCode",NI(1),@"NWVersion",@"",@"NWExID",nil];
    NSDictionary *content = [NSDictionary dictionaryWithObjectsAndKeys:
                             postData,@"Data",head,@"Head",nil];
	NSDictionary *pData = [NSDictionary dictionaryWithObjectsAndKeys:content,@"Request",nil];
    
    
    DebugLog(@"请求信息：%@", [pData JSONRepresentation]); 
    
    return pData;
}


@end
