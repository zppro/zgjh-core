//
//  HttpAppRequest.h
//  core
//
//  Created by zppro on 13-7-15.
//
//

#import <Foundation/Foundation.h>
@class HttpAppRequest;

@interface HttpAppRequest : NSObject

+(HttpAppRequest*)requestWithHead:(NSDictionary*)head andBody:(NSDictionary*)body;

@property (nonatomic, retain) NSMutableDictionary* headData;
@property (nonatomic, retain) NSDictionary* bodyData;

@end
