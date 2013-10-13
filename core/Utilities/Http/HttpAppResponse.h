//
//  HttpAppResponse.h
//  core
//
//  Created by zppro on 13-7-15.
//
//

#import <Foundation/Foundation.h>

@interface HttpAppResponse : NSObject

+(id)responseWithDict:(NSDictionary*)aDictInfo;

@property(nonatomic,retain) NSString* error;
@property(nonatomic,assign) NSInteger errorCode;
@property(nonatomic,retain) NSString* errorMessage;
@property(nonatomic,assign) BOOL success;
@property(nonatomic,retain) id ret;
@property(nonatomic,retain) NSArray *rows;
@end
