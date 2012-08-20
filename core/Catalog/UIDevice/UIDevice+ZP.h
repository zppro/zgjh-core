//
//  UIDevice+ZP.h
//  core
//
//  Created by zppro on 12-8-17.
//  Copyright 2012年 zppro.com. All rights reserved.
//

#import "IpAddressC.h"
#import "UIDevice+serialNumber.h"
#import "UIDevice+IdentifierAddition.h"

//#define DEVICE_UDID [[UIDevice currentDevice] uniqueIdentifier] 
#define DEVICE_UDID DEVICE_ID
//设备ID
#define DEVICE_ID [[UIDevice currentDevice] uniqueGlobalDeviceIdentifier]
#define DEVICE_NAME [[UIDevice currentDevice] name]
#define DEVICE_MODEL [[UIDevice currentDevice] model]
#define DEVICE_OSVERSION [[UIDevice currentDevice] systemVersion]
#define DEVICE_TYPE [[UIDevice currentDevice] deviceType]
#define DEVICE_BUNDLEVERSION [[UIDevice currentDevice] bundleVersion]
#define DEVICE_MAC [[UIDevice currentDevice] MAC]
#define DEVICE_IP [[UIDevice currentDevice] IP]
#define DEVICE_SERIALNUMBER [[UIDevice currentDevice] serialNumber]

@interface UIDevice (ZP)

@property (nonatomic, readonly) int deviceType;
@property (nonatomic, readonly) NSString *bundleVersion;
@property (nonatomic, readonly) NSString *IP;
@property (nonatomic, readonly) NSString *MAC;

int instr(NSString *searchIn,NSString *searchFor, int startingAt);

@end
