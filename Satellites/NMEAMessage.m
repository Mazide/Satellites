//
//  Message.m
//  Satellites
//
//  Created by Nikita Demidov on 05/03/14.
//  Copyright (c) 2014 HORIS. All rights reserved.
//

#import "NMEAMessage.h"

@implementation NMEAMessage

-(id)initWithFields:(NSArray *)fields validCheckSum:(BOOL)valid{
    self = [super init];
    if (self) {
        _fields = [NSArray arrayWithArray:fields];
        _valid = valid;
    }
    return self;
}

-(NMEAType)type{
    NMEAType nmeaType = 0;
    if ([_fields[0] isEqualToString:@"GPGSV"]) {
        nmeaType = NMEA_TYPE_GSV;
    }
    
    if ([_fields[0] isEqualToString:@"GPGSA"]) {
        nmeaType = NMEA_TYPE_GSA;
    }
    return nmeaType;
}

@end
