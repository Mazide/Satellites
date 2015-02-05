//
//  Message.h
//  Satellites
//
//  Created by Nikita Demidov on 05/03/14.
//  Copyright (c) 2014 HORIS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NMEATypes.h"

@interface NMEAMessage : NSObject

@property (strong, nonatomic, readonly) NSArray* fields;
@property (nonatomic, readonly) BOOL valid;

-(id)initWithFields:(NSArray*)fields validCheckSum:(BOOL)valid;
-(NMEAType)type;

@end
