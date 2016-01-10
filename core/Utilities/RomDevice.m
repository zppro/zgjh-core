//
//  RomDevice.m
//  CheckDaily
//
//  Created by 钟 平 on 11-9-11.
//  Copyright 2011年 zppro. All rights reserved.
//

#import "RomDevice.h"
#import "UIDevice+serialNumber.h"
#import "UIDevice+ZP.h"
//#import "e0571DES.h"

@implementation RomDevice
SYNTHESIZE_LESSER_SINGLETON_FOR_CLASS(RomDevice);

@synthesize deviceName;
@synthesize model;
//@synthesize sn;
@synthesize udid;
@synthesize osversion;
@synthesize mac;
@synthesize deviceType;
@synthesize ipAddress;

@synthesize applicationId;
@synthesize deviceToken;

- (void)dealloc
{  
    
    [deviceName release];
    [model release];
    //[sn release];
    [udid release];
    [osversion release]; 
    [mac release]; 
    [ipAddress release];
    [deviceToken release];
    [applicationId release];
    [super dealloc];
}

- (id)init
{ 
    self = [super init];
    if (self) {
        // Initialization code here.
        UIDevice *device = [UIDevice currentDevice];
        
        
        deviceName = device.name;
        [deviceName retain];
        model = device.model;
        [model retain];
        //sn = device.serialNumber;
        //[sn retain];
        udid = device.uniqueDeviceIdentifier;
        [udid retain];
        osversion = device.systemVersion;
        [osversion retain];
        deviceType = device.deviceType;
        mac = device.MAC;
        [mac retain];
        ipAddress = device.IP;
        [ipAddress retain];
    }
    
   
    
    return self;
}
 

@end
