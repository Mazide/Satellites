//
//  MessageHandlerManager.m
//  Satellites
//
//  Created by Nikita Demidov on 05/03/14.
//  Copyright (c) 2014 HORIS. All rights reserved.
//

#import "MessageHandlerManager.h"
#import "GPGSVMessageHandler.h"
#import "GPGSAMessageHandler.h"
#import "MessageHandler.h"

NSString* MessageHandlerDidUpdateSatelliteGroupNotification = @"satelliteGroupDidUpdate";
NSString* MessageHandlerSatelliteGroupkey = @"satelliteGroupKey";

NSString* MessageHandlerDidUpdateActiveSatellitesNotification = @"activeSatellitesDidUpdateNotification";
NSString* MessafeHandlerActiveSatellitesKey = @"activeSatellitesKey";

@implementation MessageHandlerManager{
    NSMutableArray* messageHandlers;
}



-(id)init{
    self = [super init];
    if (self) {
        [self initMessageHandlers];
        [self initNotifications];
    }
    return self;
}


-(void)initMessageHandlers{
    messageHandlers = [[NSMutableArray alloc] init];
    [messageHandlers addObject:[[GPGSVMessageHandler alloc] init]];
    [messageHandlers addObject:[[GPGSAMessageHandler alloc] init]];

}

-(void)initNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(satelliteGroupUpdate:)
                                                 name:GPGSVMessageHandlerDidSatellitesGroupUpdateNotification
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(activeSatelliteDidUpdate:)
                                                 name:GPGSAMessageHandlerDidActiveSatellitesUpdateNotification
                                               object:nil];


}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(NSArray*)divideMessage:(NSString*)message{
    NSMutableArray* propertes;
    NSArray* tailOfMessage;
    message = [message substringFromIndex:1]; // удаляем знак доллара ""
    propertes = [NSMutableArray arrayWithArray:[message componentsSeparatedByString:@","]];
    //после разбития строки на подстроки, разделяемые "," получаем массив свойств
    //в последнем элементе массива находится SNR последнего в списке свойств спутника и контрольная сумма,
    //разделенные звездочкой "*"
    tailOfMessage = [[propertes objectAtIndex:propertes.count - 1] componentsSeparatedByString:@"*"];
    [propertes replaceObjectAtIndex:propertes.count-1 withObject:[tailOfMessage objectAtIndex:0]];
    
    return propertes;
}

-(BOOL)checkMessageOnError:(NSString*)message{
    message = [message substringFromIndex:1]; // удаляем знак доллара "$" (контрольная сумма считается по строке, которая находится между знаком доллара ($) и звездочкой (*))
    NSArray* tailOfMessage = [message componentsSeparatedByString:@"*"];
    if (tailOfMessage.count != 2) {
        return NO;
    }
    NSString* checkSumStr = [tailOfMessage objectAtIndex:1];
    message = [[message componentsSeparatedByString:@"*"] objectAtIndex:0];
    unsigned checkSum = 0;
    NSScanner *scanner = [NSScanner scannerWithString:checkSumStr];
    [scanner scanHexInt:&checkSum];
    
    int result = 0;
    for ( int i = 0; i  < message.length; i++ )
    {
        char a = [message characterAtIndex:i];
        result ^= a;
    }
    if (result == checkSum) {
        return YES;
    } else {
        return NO;
    }
    
    // выполняем XOR для сообщения и сраниваем с контрольной суммой
    
}

-(void)handleMessage:(NSString *)message{
    if ([self checkMessageOnError:message]) {
        NSArray* fields = [self divideMessage:message];
        for (int i=0; i<messageHandlers.count; ++i) {
            MessageHandler* messageHandler = messageHandlers[i];
            [messageHandler handleMessage:[[Message alloc] initWithFields:fields]];
        }
    }
}


#pragma mark - GPGSVMessageHandler notification

-(void)satelliteGroupUpdate:(NSNotification *)notification {
    SatellitesGroup* satelliteGroup = [notification.userInfo objectForKey:GPGSVMessageHandlerSatellitesGroupKey];    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:satelliteGroup forKey:MessageHandlerSatelliteGroupkey];
    [[NSNotificationCenter defaultCenter] postNotificationName:MessageHandlerDidUpdateSatelliteGroupNotification
                                                        object:self userInfo:userInfo];

}



#pragma mark - GPGSAMessageHandler notification

-(void)activeSatelliteDidUpdate:(NSNotification *)notification {
    SatellitesActivity* satellitesActivity = [notification.userInfo objectForKey:GPGSAMessageHandlerActiveSatellitesKey];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:satellitesActivity forKey:MessafeHandlerActiveSatellitesKey];
    [[NSNotificationCenter defaultCenter] postNotificationName:MessageHandlerDidUpdateActiveSatellitesNotification
                                                        object:self userInfo:userInfo];
    
}



@end