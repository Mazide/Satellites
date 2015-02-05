//
//  SatellitesActivityMaker.h
//  Satellites
//
//  Created by Nikita Demidov on 05/03/14.
//  Copyright (c) 2014 HORIS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NMEAMessageHandler.h"


@class SatellitesActivity;
@class GSAMessageHandler;

@protocol GSAMessageHandlerDelegate <NSObject>

-(void)GSAMessageHandler:(GSAMessageHandler*)gsaMessageHandler didUpdateSatellitesActivity:(SatellitesActivity*)satellitesActivity;

@end

@interface GSAMessageHandler : NMEAMessageHandler

@property (nonatomic, weak) id <GSAMessageHandlerDelegate> delegate;

-(void)handleMessage:(NMEAMessage *)message;

@end
