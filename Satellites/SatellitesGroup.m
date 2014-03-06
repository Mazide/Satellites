//
//  SatellitesGroup.m
//  Satellites
//
//  Created by Nikita Demidov on 03/03/14.
//  Copyright (c) 2014 HORIS. All rights reserved.
//

#import "SatellitesGroup.h"

@implementation SatellitesGroup


-(id)initWithSatellitesGroup:(NSArray*)satellitesGroup{
    self = [super init];
    if (self) {
        _satellites = satellitesGroup;
    }
    return self;
}

@end
