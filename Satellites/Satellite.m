//
//  Satellite.m
//  Satellites
//
//  Created by Nikita Demidov on 03/03/14.
//  Copyright (c) 2014 HORIS. All rights reserved.
//

#import "Satellite.h"

int const SNR_IS_EMPTY = -1;

@implementation Satellite

-(id)initWithID:(int)satelliteID elevation:(Elevation)elevation azimuth:(Azimuth)azimuth snr:(SNR)snr{
    self = [super init];
    if (self) {
        _satelliteID = satelliteID;
        _snr = snr;
        _coordinate.elevation = elevation;
        _coordinate.azimuth = azimuth;
    }
    return self;
}

@end
