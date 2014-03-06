//
//  SatellitesManager.h
//  Satellites
//
//  Created by Nikita Demidov on 04/03/14.
//  Copyright (c) 2014 HORIS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageHandlerManager.h"

NSString* SatellitesManagerDidUpdateSatellitesNotification;
NSString* SatellitesManagerSatellitesGroupKey;
NSString* SatellitesManagerDidUpdateActiveSatellitesNotification;
NSString* SatellitesActiveKey;

@interface SatellitesManager : NSObject 


-(id)initWithFile:(NSString*)fileName frequency:(double)streamFrequency;
-(void)startUpdating;
-(void)stopUpdating;

@end
