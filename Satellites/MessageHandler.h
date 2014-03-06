//
//  MessageHandler.h
//  Satellites
//
//  Created by Nikita Demidov on 05/03/14.
//  Copyright (c) 2014 HORIS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Message.h"

@interface MessageHandler : NSObject

-(void)handleMessage:(Message*)message;

@end
