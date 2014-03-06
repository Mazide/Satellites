//
//  Satellite.h
//  Satellites
//
//  Created by Nikita Demidov on 03/03/14.
//  Copyright (c) 2014 HORIS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Satellite : NSObject

-(id)initWithID:(int)satelliteID elevation:(double)elevation azimuth:(double)azimuth snr:(double)snr;

@property (nonatomic, readonly) int satelliteID;
@property (nonatomic, readonly) double elevation;
@property (nonatomic, readonly) double azimuth;
@property (nonatomic, readonly) double snr;


@end
