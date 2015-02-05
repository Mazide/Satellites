//
//  DrawView.h
//  Satellites
//
//  Created by Nikita Demidov on 07/03/14.
//  Copyright (c) 2014 HORIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SatelliteMarker;

@interface SatellitesView : UIView

-(void)addSatelliteMarker:(SatelliteMarker *)marker;
-(void)removeSatellitMarker:(SatelliteMarker*)satellite;

@end
