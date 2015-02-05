//
//  SatellitesActivityMaker.m
//  Satellites
//
//  Created by Nikita Demidov on 05/03/14.
//  Copyright (c) 2014 HORIS. All rights reserved.
//

#import "GSAMessageHandler.h"
#import "SatellitesActivity.h"


double PDOP_LOWER_LIMIT = 1.0;
double PDOP_UPPER_LIMIT = 9.9;
double HDOP_LOWER_LIMIT = 1.0;
double HDOP_UPPER_LIMIT = 9.9;
double VDOP_LOWER_LIMIT = 1.0;
double VDOP_UPPER_LIMIT = 9.9;


NSString* GSAMessageHandlerDidActiveSatellitesUpdateNotification = @"activeSatellitesMessageHandledNotification";
NSString* GSAMessageHandlerActiveSatellitesKey = @"activeSatelliteMessageHandledKey";

@implementation GSAMessageHandler{
    NSMutableArray* activityIDs;
}


-(void)handleMessage:(NMEAMessage *)message{
    activityIDs = [[NSMutableArray alloc] init];
    if (message.type == NMEA_TYPE_GSA) {
        SatellitesActivity* activitySatellites;
        double pdop;
        double hdop;
        double vdop;
        for (int i=3; i<([message.fields count]-3); ++i) {
            NSString* field = message.fields[i];
            if (![field isEqualToString:@""]) {
                NSNumber* activituID = [NSNumber numberWithInt:[field integerValue]];
                [activityIDs addObject:activituID];
            }
        }
        pdop = [message.fields[15] doubleValue];
        hdop = [message.fields[16] doubleValue];
        vdop = [message.fields[17] doubleValue];
        if ([self checkDOP:hdop lowerLimit:HDOP_LOWER_LIMIT upperLimit:HDOP_UPPER_LIMIT] &&
            [self checkDOP:vdop lowerLimit:VDOP_LOWER_LIMIT upperLimit:VDOP_UPPER_LIMIT] &&
            [self checkDOP:pdop lowerLimit:PDOP_LOWER_LIMIT upperLimit:PDOP_UPPER_LIMIT]) {
            activitySatellites= [[SatellitesActivity alloc] initWithActiveID:activityIDs pdop:pdop hdop:hdop vdop:vdop];
            [self updateActivity:activitySatellites];
        }
    }
}

-(void)updateActivity:(SatellitesActivity*)newSatellitesActivity{
    if (self.delegate && [self.delegate respondsToSelector:@selector(GSAMessageHandler:didUpdateSatellitesActivity:)]) {
		[self.delegate performSelector:@selector(GSAMessageHandler:didUpdateSatellitesActivity:) withObject:newSatellitesActivity];
	}
}


-(BOOL)checkDOP:(double)dop lowerLimit:(double)lowerLimit upperLimit:(double)upperLimit{
//    if (dop < lowerLimit || dop >upperLimit) {
//        return NO;
//    } else {
//        return YES;
//    }
    return YES;
}


@end