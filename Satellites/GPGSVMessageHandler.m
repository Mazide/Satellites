//
//  SatellitesGroupMaker.m
//  Satellites
//
//  Created by Nikita Demidov on 04/03/14.
//  Copyright (c) 2014 HORIS. All rights reserved.
//

#import "GPGSVMessageHandler.h"
#import "SatellitesGroup.h"
#import "Message.h"
#import "Satellite.h"


NSString* GPGSVMessageHandlerDidSatellitesGroupUpdateNotification = @"satellitesGroupUpdate";
NSString* GPGSVMessageHandlerSatellitesGroupKey = @"satellitionGroupKey";


@implementation GPGSVMessageHandler{
    SatellitesGroup* satelliteGroup;
    NSMutableArray* satellitesStorage;
    int messageNumber;
    int countOfMessages;
}


-(void)handleMessage:(Message *)message{
    
    if ([message.fields[0] isEqualToString:@"GPGSV"]) {
        messageNumber = [message.fields[2] integerValue];
        if (messageNumber == 1) {
            countOfMessages = [message.fields[1] integerValue];
            satellitesStorage = [[NSMutableArray alloc] init];
        }
        
        for (int i=4; i<[message.fields count]; i+=4) {
            int satellitinId = [message.fields[i] integerValue];
            double elevation = [message.fields[i+1] doubleValue];
            double azimuth = [message.fields[i+2] doubleValue];
            double snr;
            if ([message.fields[i+3] isEqualToString:@""]) {
                snr = SNR_IS_EMPTY;
            } else {
                snr = [message.fields[i+3] doubleValue];
            }
            Satellite* newSatellite = [[Satellite alloc] initWithID:satellitinId elevation:elevation azimuth:azimuth snr:snr];
            [satellitesStorage addObject:newSatellite];
        }
        
        if (messageNumber == countOfMessages) {
            satelliteGroup = [[SatellitesGroup alloc] initWithSatellitesGroup:satellitesStorage];
            [self updateSatelliteGroup:satelliteGroup];
        }
    }
}


-(void)updateSatelliteGroup:(SatellitesGroup*)newSatelliteGroup{
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:newSatelliteGroup forKey:GPGSVMessageHandlerSatellitesGroupKey];
    [[NSNotificationCenter defaultCenter] postNotificationName:GPGSVMessageHandlerDidSatellitesGroupUpdateNotification
                                                        object:self userInfo:userInfo];
}

@end
