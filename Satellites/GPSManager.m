//
//  SatellitesManager.m
//  Satellites
//
//  Created by Nikita Demidov on 04/03/14.
//  Copyright (c) 2014 HORIS. All rights reserved.
//

#import "GPSManager.h"
#import "FileReader.h"
#import "NMEAManager.h"
#import "SatellitesInView.h"
#import "SatellitesActivity.h"
#import "InputStream.h"
#import "NMEAManager.h"


NSString* SatellitesManagerDidUpdateSatellitesNotification = @"satellitesGroupCompleteNotification";
NSString* SatellitesManagerSatellitesGroupKey = @"satellitesGroup";

NSString* SatellitesManagerDidUpdateActiveSatellitesNotification = @"satellitesActivityCompleteNotification";
NSString* SatellitesActiveKey = @"satellitesActivityKey";

@interface GPSManager () <NMEAManagerDelegate>

@end

@implementation GPSManager {
    NMEAManager* messageHandlerManager;
    InputStream* inStream;
}

-(id)initWithInputStream:(InputStream*)inputStream{
    self = [super init];
    if (self) {
        messageHandlerManager = [[NMEAManager alloc] init];
        messageHandlerManager.delegate = self;
        [self initNotifications];
        _updateEnabled = YES;
        inStream = inputStream;
    }
    return self;
}

-(void)initNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceivedNewMessage:)
                                                 name:InputStreamDidMessageReceivedNotification
                                               object:inStream];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - InputStream Notification

-(void)didReceivedNewMessage:(NSNotification*)notification{
    if (_updateEnabled) {
        NSString* message = [notification.userInfo objectForKey:InputStreamMessageKey];
//        NSLog(@"%@", message);
       [messageHandlerManager handleMessage:message];
    }
}

#pragma mark - NMEAMEssageHandler delegate methods

-(void)NMEAManager:(NMEAManager *)nmeaManager didUpdateSatellitesInView:(SatellitesInView *)satellites{
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:satellites forKey:SatellitesManagerSatellitesGroupKey];
    [[NSNotificationCenter defaultCenter] postNotificationName:SatellitesManagerDidUpdateSatellitesNotification
                                                        object:self userInfo:userInfo];

}

-(void)NMEAManager:(NMEAManager *)nmeaManager didUpdateSatellitesActivity:(SatellitesActivity *)satellitesActivity{
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:satellitesActivity forKey:SatellitesActiveKey];
    [[NSNotificationCenter defaultCenter] postNotificationName:SatellitesManagerDidUpdateActiveSatellitesNotification
                                                        object:self userInfo:userInfo];

}

@end
