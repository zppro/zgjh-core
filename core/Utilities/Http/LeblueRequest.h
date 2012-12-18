//
//  LeblueRequest.h
//  core
//
//  Created by zppro on 12-12-16.
//
//

#import <Foundation/Foundation.h>

@interface LeblueRequest : NSDictionary
+(id)requestWithHead:(NSInteger)NWCode WithPostData:(NSDictionary*)postData;
@end
