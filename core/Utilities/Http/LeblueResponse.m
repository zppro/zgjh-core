//
//  LeblueResponse.m
//  core
//
//  Created by zppro on 12-12-16.
//
//

#import "LeblueResponse.h"

@implementation LeblueResponse
@synthesize code,message,records,isSuccess,extInfo;
- (void)dealloc {
    self.code = nil;
    self.message = nil;
    self.records = nil;
    self.extInfo = nil;
    [super dealloc];
}
+(id)responseWithDict:(NSDictionary*)aDictInfo{
    LeblueResponse* res =[[[LeblueResponse alloc] init] autorelease]; 
    res.records = [aDictInfo objectForKey:@"ResultCollection"];
    res.message = [aDictInfo objectForKey:@"ErrorMessage"];
    res.isSuccess= [[aDictInfo objectForKey:@"Result"] boolValue]; 
    return res;
}
@end
