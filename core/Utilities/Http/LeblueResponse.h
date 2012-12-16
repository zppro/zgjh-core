//
//  LeblueResponse.h
//  core
//
//  Created by zppro on 12-12-16.
//
//

#import <Foundation/Foundation.h>
/*
 {"Response":
 {
 "Head":{"NWVersion":"1","NWCode":1,"NWGUID":"","NWExID":"a0e694bba34643aea26887d8796ad2b2"},
 "Data":{"NWRespCode":"0003","NWErrMsg":"登录帐号不能为空！","Record":[]}
 }
 }
 */
@interface LeblueResponse : NSObject

@property(nonatomic,retain) NSString* code;
@property(nonatomic,retain) NSString* message;
@property(nonatomic,retain) NSArray* records;
@property(nonatomic,assign) BOOL isSuccess;
@property(nonatomic,retain) id extInfo;

+(id)responseWithDict:(NSDictionary*)aDictInfo;

@end
