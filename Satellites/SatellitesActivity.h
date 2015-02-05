//
//  SatellitesActivity.h
//  Satellites
//
//  Created by Nikita Demidov on 04/03/14.
//  Copyright (c) 2014 HORIS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UnitsOfMeasure.h"

@interface SatellitesActivity : NSObject

-(id)initWithActiveID:(NSArray*)activeIDs pdop:(DOP)pdop hdop:(DOP)hdop vdop:(DOP)vdop;

@property (strong, nonatomic, readonly) NSArray* activeSatellitesIDs;
@property (nonatomic, readonly) DOP PDOP;
@property (nonatomic, readonly) DOP HDOP;
@property (nonatomic, readonly) DOP VDOP;

@end
