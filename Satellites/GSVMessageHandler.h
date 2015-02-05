//
//  SatellitesGroupMaker.h
//  Satellites
//
//  Created by Nikita Demidov on 04/03/14.
//  Copyright (c) 2014 HORIS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NMEAMessageHandler.h"


@class SatellitesInView;
@class GSVMessageHandler;
@protocol GSVMessageHandlerDelegate <NSObject>

-(void)GSVMessageHandler:(GSVMessageHandler*)gsvMessageHandler didUpdateSatellitesInView:(SatellitesInView*)satellites;

@end

@interface GSVMessageHandler : NMEAMessageHandler

@property (nonatomic, weak) id <GSVMessageHandlerDelegate> delegate;

-(void)handleMessage:(NMEAMessage*)message;

@end
