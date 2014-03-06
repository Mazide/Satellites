//
//  SatellitesActivity.h
//  Satellites
//
//  Created by Nikita Demidov on 04/03/14.
//  Copyright (c) 2014 HORIS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SatellitesActivity : NSObject

-(id)initWithActiveID:(NSArray*)acitveIDs PDOP:(double)pdop hdop:(double)hdop vdop:(double)vdop;

@property (strong, nonatomic, readonly) NSArray* activeSatelliteIDs;
@property (nonatomic, readonly) double PDOP;
@property (nonatomic, readonly) double HDOP;
@property (nonatomic, readonly) double VDOP;



@end
