//
//  SatellitesActivityMaker.h
//  Satellites
//
//  Created by Nikita Demidov on 05/03/14.
//  Copyright (c) 2014 HORIS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageHandler.h"


NSString* GPGSAMessageHandlerDidActiveSatellitesUpdateNotification;
NSString* GPGSAMessageHandlerActiveSatellitesKey;

@interface GPGSAMessageHandler : MessageHandler

-(void)handleMessage:(Message *)message;

@end
