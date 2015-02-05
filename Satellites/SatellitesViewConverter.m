//
//  SatellitesConverter.m
//  Satellites
//
//  Created by Nikita Demidov on 11/03/14.
//  Copyright (c) 2014 HORIS. All rights reserved.
//

#import "SatellitesViewConverter.h"
#import "SatelliteMarker.h"
#import "Satellite.h"
#import "SatellitesInView.h"
#import "SatellitesActivity.h"

@implementation SatellitesViewConverter {
    int radius;
    CGPoint center;
}

-(id)initWithRadius:(int)rad center:(CGPoint)centerPoints{
    self = [super init];
    if (self) {
        radius = rad;
        center = centerPoints;
    }
    return self;
}

-(NSArray*)convertSatellitesInView:(SatellitesInView*)newSatellitesInView{
    NSMutableArray* sat = [[NSMutableArray alloc] init];
    for (int i=0; i< [newSatellitesInView.satellites count]; ++i) {
        [sat addObject:[self convertSatellite:newSatellitesInView.satellites[i]]];
    }
    return sat;
}


-(SatelliteMarker*)convertSatellite:(Satellite*)satellite{
    SatelliteMarker* marker = [[SatelliteMarker alloc] init];
    marker.satelliteID = satellite.satelliteID;
    marker.signalStrength = satellite.snr;
    return marker;
}

-(CGPoint)convertElevation:(Elevation)elevation azimuth:(Azimuth)azimuth{
    float RP =radius * cosf(elevation); // RP - radius projection
    float x = RP * cosf(azimuth);
    float y = RP * sinf(azimuth) * (-1);
    CGPoint point;
    point.x = x + center.x;
    point.y = y + center.y;
    return point;
}

@end
