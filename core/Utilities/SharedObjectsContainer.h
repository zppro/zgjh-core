//
//  SharedObjectsContainer.h
//  core
//
//  Created by zppro on 12-12-25.
//
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "SynthesizeSingleton.h"
#define soc [SharedObjectsContainer sharedInstance]

@class Reachability;
@class RomDevice;

@interface SharedObjectsContainer : NSObject
SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(SharedObjectsContainer);

@property (nonatomic, retain) NSString* skinName;
@property (nonatomic, retain) Reachability *reach;
@property (nonatomic, retain) CLLocationManager  *locationManager;
@property (nonatomic, retain) CLLocation  *myLocation;
@property (nonatomic, retain) CLLocation  *offsetMyLocation;
@property (nonatomic) BOOL canLocation;
@property (nonatomic, retain) CLLocation  *DebugMyLocation;
@property (nonatomic, retain) RomDevice *rom;
@end
