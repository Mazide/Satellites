 //
//  MainViewController.m
//  Satellites
//
//  Created by Nikita Demidov on 03/03/14.
//  Copyright (c) 2014 HORIS. All rights reserved.
//

#import "MainViewController.h"
#import "SatellitesInView.h"
#import "SatellitesActivity.h"
#import "GPSManager.h"
#import "Satellite.h"
#import "InputStream.h"
#import "SatellitesView.h"
#import "SatellitesViewConverter.h"
#import "SatelliteMarker.h"
#import "SNRTableView.h"

int SLIDER_TAG = 5;

@interface MainViewController (){
    GPSManager* gpsManager;
    InputStream* inputStream;
    SatellitesView *drawView;
    __weak IBOutlet UISlider *readSpeedslider;
    __weak IBOutlet UITableView *strongSignalTableView;
    __weak IBOutlet UILabel *readSpeedLabel;
    SatellitesInView* newSatellitesInview;
    SatellitesInView* previosSatellitesInView;
    NSMutableDictionary* previosMarkers;
    NSMutableDictionary* newMarkers;
    SNRTableView* snrTableViewDelegate;
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
    [self initDrawView];
    [self initSNRTableView];
    newSatellitesInview = nil;
    previosSatellitesInView = nil;
    [readSpeedLabel setText:[NSString stringWithFormat:@"%d %@",(int)readSpeedslider.value,NSLocalizedString(@"readSpeedLabel", nil)]];
    inputStream = [[InputStream alloc] initWithFile:@"GPS_log.txt" linesPerSecond:readSpeedslider.value];
    [self startUpdating];
    gpsManager = [[GPSManager alloc] initWithInputStream:inputStream];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)initNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateSatellitesInView:)
                                                 name:SatellitesManagerDidUpdateSatellitesNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateSatellitesActivity:)
                                                 name:SatellitesManagerDidUpdateActiveSatellitesNotification
                                               object:nil];
}

-(void)initSNRTableView{
    snrTableViewDelegate = [[SNRTableView alloc] init];
    strongSignalTableView.delegate = snrTableViewDelegate;
    strongSignalTableView.dataSource = snrTableViewDelegate;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)startUpdating{
    
}

-(void)stopUpdating{
    [inputStream stop];
}

#pragma mark - satellites handling

-(void)deleteNotRelevantSatellites{
    SatelliteMarker* tempMarker;
    
    for (NSString* key in previosMarkers) {
        tempMarker = (SatelliteMarker*)[previosMarkers objectForKey:key];
        if (![newMarkers objectForKey:key]) {
            [drawView removeSatellitMarker:tempMarker];
        }
    }
}

#pragma mark - SatellitesManager notification

-(void)updateSatellitesInView:(NSNotification *) notification{
    previosMarkers = newMarkers;
    newMarkers = [[NSMutableDictionary alloc] init];
    NSString* key;
    newSatellitesInview = (SatellitesInView*)[notification.userInfo objectForKey:SatellitesManagerSatellitesGroupKey];
    
    for (int i=0; i < newSatellitesInview.satellites.count; ++i) {
        Satellite* newSat = (Satellite*)newSatellitesInview.satellites[i];
        SatelliteMarker* newMarker = [[SatelliteMarker alloc] initWithSatellite:newSat];
        key = [NSString stringWithFormat:@"%d",newMarker.satelliteID];
        if ([previosMarkers objectForKey:key]) {
            if ([[previosMarkers objectForKey:key] active]) {
                [newMarker setActive:YES];
            }
        }
        [newMarkers setObject:newMarker forKey:key];
        [drawView addSatelliteMarker:newMarker];
    }

    [snrTableViewDelegate loadSatellites:newSatellitesInview.satellites];
    [strongSignalTableView reloadData];
    [self deleteNotRelevantSatellites];

}

-(void)updateSatellitesActivity:(NSNotification *)notification{
    SatellitesActivity* satellitesActivity = (SatellitesActivity*)[notification.userInfo objectForKey:SatellitesActiveKey];   
    SatelliteMarker* tempMarker;
    NSString* key;
    NSArray* ids = [satellitesActivity activeSatellitesIDs];
    NSMutableDictionary* idsDict = [[NSMutableDictionary alloc] init];
    
    for (int i=0; i<ids.count; ++i) {
        key = [NSString stringWithFormat:@"%d",[ids[i] integerValue]];
        [idsDict setObject:ids[i] forKey:key];
    }
    
    for (NSString* key in newMarkers) {
        tempMarker = (SatelliteMarker*)[newMarkers objectForKey:key];
        [tempMarker setActive:NO];
        if ([idsDict objectForKey:key]) {
            [tempMarker setActive:YES];
            [drawView addSatelliteMarker:tempMarker];
        }
    }
}

#pragma mark - controll Action

- (IBAction)startButtonAction:(id)sender {
    [inputStream run];
}

- (IBAction)stopButtonAction:(id)sender {
    [inputStream stop];
}

- (IBAction)slideChanged:(UISlider*)sender {
    [readSpeedLabel setText:[NSString stringWithFormat:@"%d %@",(int)readSpeedslider.value,NSLocalizedString(@"readSpeedLabel", nil)]];
    [inputStream changeReadSpeed:(int)sender.value];
}

#pragma mark - rendering

-(void)initDrawView{
    CGRect drawViewFrame = CGRectMake(260.0f, 60.0f, self.view.frame.size.width * 0.6, self.view.frame.size.width * 0.6);
    drawView = [[SatellitesView alloc] initWithFrame:drawViewFrame];
    [drawView setBackgroundColor:[UIColor clearColor]];
    [drawView setClipsToBounds:NO];
    [self.view addSubview:drawView];
    [self.view sendSubviewToBack:drawView];
}



@end
