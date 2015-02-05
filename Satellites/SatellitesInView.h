//
//  SatellitesGroup.h
//  Satellites
//
//  Created by Nikita Demidov on 03/03/14.
//  Copyright (c) 2014 HORIS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SatellitesInView : NSObject

@property (strong, nonatomic, readonly) NSArray* satellites;

-(id)initWithSatellitesGroup:(NSArray*)satellitesGroup;

@end
