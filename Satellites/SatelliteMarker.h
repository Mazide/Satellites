//
//  SatelliteIcon.h
//  Satellites
//
//  Created by Nikita Demidov on 11/03/14.
//  Copyright (c) 2014 HORIS. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Satellite.h"
#import "UnitsOfMeasure.h"

@interface SatelliteMarker : NSObject

@property (nonatomic) SphericalCoordSystem coordinate;
@property (nonatomic) SNR signalStrength;
@property (nonatomic) int satelliteID;
@property (nonatomic) BOOL active;

-(id)initWithID:(int)number elevation:(Elevation)elevation azimuth:(Azimuth)azimuth signalStrength:(double)signalStrength;
-(id)initWithSatellite:(Satellite*)satellite;

@end
