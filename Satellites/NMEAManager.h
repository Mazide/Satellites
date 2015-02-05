//
//  MessageHandlerManager.h
//  Satellites
//
//  Created by Nikita Demidov on 05/03/14.
//  Copyright (c) 2014 HORIS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SatellitesInView.h"
#import "SatellitesActivity.h"

@class NMEAManager;
@class NMEAMessage;

@protocol NMEAManagerDelegate <NSObject>

-(void)NMEAManager:(NMEAManager*)nmeaManager didUpdateSatellitesInView:(SatellitesInView*)satellites;
-(void)NMEAManager:(NMEAManager*)nmeaManager didUpdateSatellitesActivity:(SatellitesActivity*)satellitesActivity;

@end

@interface NMEAManager : NSObject

@property (nonatomic, weak) id <NMEAManagerDelegate> delegate;

-(void)handleMessage:(NSString*)message;

@end