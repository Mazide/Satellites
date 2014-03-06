//
//  Message.h
//  Satellites
//
//  Created by Nikita Demidov on 05/03/14.
//  Copyright (c) 2014 HORIS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject

@property (strong, nonatomic, readonly) NSArray* fields;

-(id)initWithFields:(NSArray*)fields;
@end
