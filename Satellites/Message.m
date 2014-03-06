//
//  Message.m
//  Satellites
//
//  Created by Nikita Demidov on 05/03/14.
//  Copyright (c) 2014 HORIS. All rights reserved.
//

#import "Message.h"

@implementation Message

-(id)initWithFields:(NSArray *)fields{
    self = [super init];
    if (self) {
        _fields = [NSArray arrayWithArray:fields];
    }
    return self;
}

@end
