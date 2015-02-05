//
//  SatellitesConverter.h
//  Satellites
//
//  Created by Nikita Demidov on 11/03/14.
//  Copyright (c) 2014 HORIS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UnitsOfMeasure.h"

@class SatelliteMarker;


@interface SatellitesViewConverter : NSObject

-(id)initWithRadius:(int)rad center:(CGPoint)centerPoints;
-(CGPoint)convertElevation:(Elevation)elevation azimuth:(Azimuth)azimuth;

@end
