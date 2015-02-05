//
//  Satellite.h
//  Satellites
//
//  Created by Nikita Demidov on 03/03/14.
//  Copyright (c) 2014 HORIS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UnitsOfMeasure.h"

extern const int SNR_IS_EMPTY;

@interface Satellite : NSObject

-(id)initWithID:(int)satelliteID elevation:(Elevation)elevation azimuth:(Azimuth)azimuth snr:(SNR)snr;

@property (nonatomic, readonly) int satelliteID;
@property (nonatomic, readonly) SphericalCoordSystem coordinate;
@property (nonatomic, readonly) SNR snr;

@end
