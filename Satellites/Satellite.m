//
//  Satellite.m
//  Satellites
//
//  Created by Nikita Demidov on 03/03/14.
//  Copyright (c) 2014 HORIS. All rights reserved.
//

#import "Satellite.h"

@implementation Satellite

-(id)initWithID:(int)satelliteID elevation:(double)elevation azimuth:(double)azimuth snr:(double)snr{
    self = [super init];
    if (self) {
        _satelliteID = satelliteID;
        _elevation = elevation;
        _azimuth = azimuth;
        _snr = snr;

    }
    return self;
}

@end
