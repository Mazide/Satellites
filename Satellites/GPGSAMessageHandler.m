//
//  SatellitesActivityMaker.m
//  Satellites
//
//  Created by Nikita Demidov on 05/03/14.
//  Copyright (c) 2014 HORIS. All rights reserved.
//

#import "GPGSAMessageHandler.h"
#import "SatellitesActivity.h"

NSString* GPGSAMessageHandlerDidActiveSatellitesUpdateNotification = @"activeSatellitesMessageHandledNotification";
NSString* GPGSAMessageHandlerActiveSatellitesKey = @"activeSatelliteMessageHandledKey";

@implementation GPGSAMessageHandler{
    NSMutableArray* activityIDs;
}


-(void)handleMessage:(Message *)message{
    activityIDs = [[NSMutableArray alloc] init];
    if ([message.fields[0] isEqualToString:@"GPGSA"]) {
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
        activitySatellites= [[SatellitesActivity alloc] initWithActiveID:activityIDs PDOP:pdop hdop:hdop vdop:vdop];
        [self updateActivity:activitySatellites];
    }
}

-(void)updateActivity:(SatellitesActivity*)newSatelliteActivity{
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:newSatelliteActivity forKey:GPGSAMessageHandlerActiveSatellitesKey];
    [[NSNotificationCenter defaultCenter] postNotificationName:GPGSAMessageHandlerDidActiveSatellitesUpdateNotification
                                                        object:self userInfo:userInfo];
}

@end
