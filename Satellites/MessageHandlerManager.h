//
//  MessageHandlerManager.h
//  Satellites
//
//  Created by Nikita Demidov on 05/03/14.
//  Copyright (c) 2014 HORIS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SatellitesGroup.h"
#import "SatellitesActivity.h"

NSString* MessageHandlerDidUpdateSatelliteGroupNotification;
NSString* MessageHandlerSatelliteGroupkey;

NSString* MessageHandlerDidUpdateActiveSatellitesNotification;
NSString* MessafeHandlerActiveSatellitesKey;

@interface MessageHandlerManager : NSObject

-(void)handleMessage:(NSString*)message;

@end