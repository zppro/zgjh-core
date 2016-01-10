//
//  RomDevice.h
//  CheckDaily
//
//  Created by 钟 平 on 11-9-11.
//  Copyright 2011年 zppro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"
typedef enum{
    DeviceType_iPad = 1,
    DeviceType_iPodTouch,
    DeviceType_iPhone,
    DeviceType_Simulator
}DeviceType;

@interface RomDevice : NSObject
SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(RomDevice);
 

@property (nonatomic,readonly) NSString *deviceName;
@property (nonatomic,readonly) NSString *model;
//@property (nonatomic,readonly) NSString *sn;
@property (nonatomic,readonly) NSString *udid;
@property (nonatomic,readonly) NSString *osversion;
@property (nonatomic,readonly) DeviceType deviceType;
@property (nonatomic,readonly) NSString *mac;
@property (nonatomic,readonly) NSString *ipAddress;

@property (nonatomic,retain) NSString *applicationId;
@property (nonatomic,retain) NSString *deviceToken;

@end
