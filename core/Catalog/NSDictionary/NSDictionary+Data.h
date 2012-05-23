//
//  NSDictionary+Data.h
//  CodansShareLibrary10
//
//  Created by 钟 平 on 11-10-19.
//  Copyright (c) 2011年 codans. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Data)

- (NSDictionary*)mixIn:(NSDictionary*) dict;

+ (NSDictionary*)fromObject:(id) obj;

@end
