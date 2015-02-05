//
//  SatellitesGroupMaker.m
//  Satellites
//
//  Created by Nikita Demidov on 04/03/14.
//  Copyright (c) 2014 HORIS. All rights reserved.
//

#import "GSVMessageHandler.h"
#import "SatellitesInView.h"
#import "NMEAMessage.h"
#import "Satellite.h"
#import "NMEATypes.h"

@implementation GSVMessageHandler{
    SatellitesInView* satelliteGroup;
    NSMutableArray* satellitesStorage;
    int messageNumber;
    int countOfMessages;
}

-(void)handleMessage:(NMEAMessage *)message{
    if (message.type == NMEA_TYPE_GSV) {
        
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
            
            if ([self checkAzimuth:azimuth] && [self checkElevation:elevation] && [self checkSNR:snr]) {
                Satellite* newSatellite = [[Satellite alloc] initWithID:satellitinId elevation:elevation azimuth:azimuth snr:snr];
                [satellitesStorage addObject:newSatellite];
            }
        }
        
        if (messageNumber == countOfMessages) {
            satelliteGroup = [[SatellitesInView alloc] initWithSatellitesGroup:satellitesStorage];
            [self updateSatelliteGroup:satelliteGroup];
        }
    }
}

-(BOOL)checkElevation:(Elevation)elevation{
    if(elevation >= 0 && elevation <= 90 ){
        return YES;
    } else {
        return NO;
    }
}

-(BOOL)checkAzimuth:(Azimuth)azimuth{
    if (azimuth >= 0 && azimuth <=359 ) {
        return YES;
    } else {
        return NO;
    }
}

-(BOOL)checkSNR:(SNR)snr{
    if ((snr >= 0 && snr <=99) || snr == SNR_IS_EMPTY) {
        return YES;
    } else {
        return NO;
    }
}

-(void)updateSatelliteGroup:(SatellitesInView*)newSattellitesInView{
    if (self.delegate && [self.delegate respondsToSelector:@selector(GSVMessageHandler:didUpdateSatellitesInView:)]) {
		[self.delegate performSelector:@selector(GSVMessageHandler:didUpdateSatellitesInView:) withObject:newSattellitesInView];
	}

}

@end
