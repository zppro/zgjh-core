//
//  SharedObjectsContainer.m
//  core
//
//  Created by zppro on 12-12-25.
//
//

#import "SharedObjectsContainer.h"
#import "RomDevice.h"

@implementation SharedObjectsContainer
SYNTHESIZE_LESSER_SINGLETON_FOR_CLASS(SharedObjectsContainer);
@synthesize skinName;
@synthesize reach;
@synthesize locationManager;
@synthesize myLocation;
@synthesize offsetMyLocation;
@synthesize canLocation;
@synthesize DebugMyLocation;

- (RomDevice*) rom{
    return [RomDevice sharedInstance];
}

@end
