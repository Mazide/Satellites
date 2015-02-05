//
//  MessageHandlerManager.m
//  Satellites
//
//  Created by Nikita Demidov on 05/03/14.
//  Copyright (c) 2014 HORIS. All rights reserved.
//

#import "NMEAManager.h"
#import "GSVMessageHandler.h"
#import "GSAMessageHandler.h"
#import "NMEAMessageHandler.h"
#import "NMEAMessageParser.h"


@interface NMEAManager() <GSVMessageHandlerDelegate,GSAMessageHandlerDelegate>

@end

@implementation NMEAManager{
    NSMutableArray* messageHandlers;
}



-(id)init{
    self = [super init];
    if (self) {
        [self initMessageHandlers];
    }
    return self;
}

-(void)initMessageHandlers{
    messageHandlers = [[NSMutableArray alloc] init];
    GSVMessageHandler* gsvHandler = [[GSVMessageHandler alloc] init];
    GSAMessageHandler* gsaHandler = [[GSAMessageHandler alloc] init];
    gsvHandler.delegate = self;
    gsaHandler.delegate = self;
    [messageHandlers addObject:gsvHandler];
    [messageHandlers addObject:gsaHandler];

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)handleMessage:(NSString *)string{
    NMEAMessageParser* nmeaParser = [[NMEAMessageParser alloc] init];
    NMEAMessage* message = [nmeaParser generateNMEAMessageFromString:string];
    if (message.valid) {
        for (int i=0; i<messageHandlers.count; ++i) {
            NMEAMessageHandler* messageHandler = messageHandlers[i];
            [messageHandler handleMessage:message];
        }
    }
}

#pragma mark - GPGSVMessageHandler delegate

-(void)GSVMessageHandler:(GSVMessageHandler *)gsvMessageHandler didUpdateSatellitesInView:(SatellitesInView *)satellites{
    if (_delegate && [_delegate respondsToSelector:@selector(NMEAManager:didUpdateSatellitesInView:)]) {
		[_delegate performSelector:@selector(NMEAManager:didUpdateSatellitesInView:) withObject:satellites];
	}
}

#pragma mark - GPGSAMessageHandler delegate

-(void)GSAMessageHandler:(GSAMessageHandler *)gsaMessageHandler didUpdateSatellitesActivity:(SatellitesActivity *)satellitesActivity{
    if (_delegate && [_delegate respondsToSelector:@selector(NMEAManager:didUpdateSatellitesActivity:)]) {
		[_delegate performSelector:@selector(NMEAManager:didUpdateSatellitesActivity:) withObject:satellitesActivity];
	}
}


@end