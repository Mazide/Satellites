//
//  MainViewController.m
//  Satellites
//
//  Created by Nikita Demidov on 03/03/14.
//  Copyright (c) 2014 HORIS. All rights reserved.
//

#import "MainViewController.h"
#import "SatellitesGroup.h"
#import "SatellitesManager.h"
#import "Satellite.h"

@interface MainViewController (){
    SatellitesManager* satelliteManager;
}

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNotifications];
    satelliteManager = [[SatellitesManager alloc] initWithFile:@"GPS_log.txt" frequency:0.001f];
    [satelliteManager startUpdating];
    
      	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initNotifications
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateSatellitesGroup:)
                                                 name:SatellitesManagerDidUpdateSatellitesNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateActiveSatellites:)
                                                 name:SatellitesManagerDidUpdateActiveSatellitesNotification
                                               object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - SatellitesManager notification

-(void)updateSatellitesGroup:(NSNotification *) notification{
    SatellitesGroup* temp = [notification.userInfo objectForKey:SatellitesManagerSatellitesGroupKey];
//    for (int i=0; i<temp.satellites.count; ++i) {
//        SatellitesGroup* satelliteGroup = temp;
//        NSLog(@"%d", [satelliteGroup.satellites[i] satelliteID]);
//    }
}

-(void)updateActiveSatellites:(NSNotification *)notification{
    SatellitesActivity* temp = [notification.userInfo objectForKey:SatellitesActiveKey];
    for (int i=0; i<temp.activeSatelliteIDs.count; ++i) {
        NSLog(@"%d", [temp.activeSatelliteIDs[i] integerValue]);
    }
    
    NSLog(@"  ");NSLog(@"  ");
}

@end
