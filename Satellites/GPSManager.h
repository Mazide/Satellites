//
//  SatellitesManager.h
//  Satellites
//
//  Created by Nikita Demidov on 04/03/14.
//  Copyright (c) 2014 HORIS. All rights reserved.
//

#import <Foundation/Foundation.h>


NSString* SatellitesManagerDidUpdateSatellitesNotification;
NSString* SatellitesManagerSatellitesGroupKey;
NSString* SatellitesManagerDidUpdateActiveSatellitesNotification;
NSString* SatellitesActiveKey;

@class InputStream;
@interface GPSManager : NSObject

@property (nonatomic) BOOL updateEnabled;

-(id)initWithInputStream:(InputStream*)inputStream;

@end
