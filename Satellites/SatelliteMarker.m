//
//  SatelliteIcon.m
//  Satellites
//
//  Created by Nikita Demidov on 11/03/14.
//  Copyright (c) 2014 HORIS. All rights reserved.
//

#import "SatelliteMarker.h"
#import "SatellitesViewConverter.h"

@implementation SatelliteMarker{
    SatellitesViewConverter* converter;
}

-(id)initWithID:(int)number elevation:(Elevation)elevation azimuth:(Azimuth)azimuth signalStrength:(double)signalStrength{
    self = [super init];
    if (self) {
        _satelliteID = number;
        _coordinate.elevation = elevation;
        _coordinate.azimuth = azimuth;
        _signalStrength = signalStrength;
        _active = NO;
    }
    return self;
}

-(id)initWithSatellite:(Satellite *)satellite{
    self = [super self];
    if (self) {
        _satelliteID = satellite.satelliteID;
        _coordinate.azimuth = satellite.coordinate.azimuth;
        _coordinate.elevation = satellite.coordinate.elevation;
        _signalStrength = satellite.snr;
        _active = NO;
    }
    return self;
}

@end
