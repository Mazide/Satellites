//
//  NMEAMessageParser.h
//  Satellites
//
//  Created by Nikita Demidov on 07/03/14.
//  Copyright (c) 2014 HORIS. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NMEAMessage;

@interface NMEAMessageParser : NSObject

-(NMEAMessage*)generateNMEAMessageFromString:(NSString*)string;

@end
