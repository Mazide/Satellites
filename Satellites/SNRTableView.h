//
//  SNRTableViewDelegate.h
//  Satellites
//
//  Created by Nikita Demidov on 13/03/14.
//  Copyright (c) 2014 HORIS. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString* SNRTableViewNotificationKey;
NSString* SNRTableViewDidTapOnSatellites;

@class SNRTableView;

@interface SNRTableView : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray* satellites;

-(void)loadSatellites:(NSArray*)satellites;

@end
