//
//  SatellitesGroupMaker.h
//  Satellites
//
//  Created by Nikita Demidov on 04/03/14.
//  Copyright (c) 2014 HORIS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageHandler.h"

NSString* GPGSVMessageHandlerDidSatellitesGroupUpdateNotification;
NSString* GPGSVMessageHandlerSatellitesGroupKey;

@interface GPGSVMessageHandler : MessageHandler

-(void)handleMessage:(Message*)message;

@end
