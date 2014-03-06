//
//  SatellitesManager.m
//  Satellites
//
//  Created by Nikita Demidov on 04/03/14.
//  Copyright (c) 2014 HORIS. All rights reserved.
//

#import "SatellitesManager.h"
#import "FileReader.h"
#import "MessageHandlerManager.h"
#import "SatellitesGroup.h"
#import "SatellitesActivity.h"
#import "InputStream.h"

NSString* SatellitesManagerDidUpdateSatellitesNotification = @"satellitesGroupCompleteNotification";
NSString* SatellitesManagerSatellitesGroupKey = @"satellitesGroup";

NSString* SatellitesManagerDidUpdateActiveSatellitesNotification = @"satellitesActivityCompleteNotification";
NSString* SatellitesActiveKey = @"satellitesActivityKey";

@implementation SatellitesManager {
    MessageHandlerManager* messageHandlerManager;
    InputStream* inputStream;
}


-(id)initWithFile:(NSString*)fileName frequency:(double)streamFrequency{
    self = [super init];
    if (self) {
        inputStream = [[InputStream alloc] initWithFile:fileName frequency:streamFrequency];
        messageHandlerManager = [[MessageHandlerManager alloc] init];
        [self initNotifications];
    }
    return self;
}

-(void)initNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceivedNewMessage:)
                                                 name:InputStreamDidMessageReceivedNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(satellitesGroupUpdate:)
                                                 name:MessageHandlerDidUpdateSatelliteGroupNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(activeSatellitesUpdate:)
                                                 name:MessageHandlerDidUpdateActiveSatellitesNotification
                                               object:nil];

}

-(void)startUpdating{
    [inputStream run];
}

-(void)stopUpdating{
    [inputStream stop];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - MessageManager notification


-(void)satellitesGroupUpdate:(NSNotification *)notification{
    SatellitesGroup* satellites = [notification.userInfo objectForKey:MessageHandlerSatelliteGroupkey];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:satellites forKey:SatellitesManagerSatellitesGroupKey];
    [[NSNotificationCenter defaultCenter] postNotificationName:SatellitesManagerDidUpdateSatellitesNotification
     object:self userInfo:userInfo];
}

-(void)activeSatellitesUpdate:(NSNotification *)notification{
    SatellitesActivity* satellites = [notification.userInfo objectForKey:MessafeHandlerActiveSatellitesKey];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:satellites forKey:SatellitesActiveKey];
    [[NSNotificationCenter defaultCenter] postNotificationName:SatellitesManagerDidUpdateActiveSatellitesNotification
                                                        object:self userInfo:userInfo];
}


#pragma mark - InputStream Notification

-(void)didReceivedNewMessage:(NSNotification*)notification{
    NSString* message = [notification.userInfo objectForKey:InputStreamMessageKey];
    [messageHandlerManager handleMessage:message];

}

@end
