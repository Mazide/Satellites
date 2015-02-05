//
//  MessageHandler.h
//  Satellites
//
//  Created by Nikita Demidov on 05/03/14.
//  Copyright (c) 2014 HORIS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NMEAMessage.h"

@interface NMEAMessageHandler : NSObject

-(void)handleMessage:(NMEAMessage*)message;

@end
