//
//  SatellitesActivity.m
//  Satellites
//
//  Created by Nikita Demidov on 04/03/14.
//  Copyright (c) 2014 HORIS. All rights reserved.
//

#import "SatellitesActivity.h"


@implementation SatellitesActivity

-(id)initWithActiveID:(NSArray*)acitveIDs pdop:(DOP)pdop hdop:(DOP)hdop vdop:(DOP)vdop{
    self = [super init];
    if (self) {
        _activeSatellitesIDs = acitveIDs;
        _PDOP = pdop;
        _HDOP = hdop;
        _VDOP = vdop;
    }
    return self;
}

@end
