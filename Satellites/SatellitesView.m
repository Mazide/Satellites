//
//  DrawView.m
//  Satellites
//
//  Created by Nikita Demidov on 07/03/14.
//  Copyright (c) 2014 HORIS. All rights reserved.
//

#import "SatellitesView.h"
#import "SatelliteMarker.h"
#import "SatellitesViewConverter.h"
#import "SatellitesActivity.h"
#import "SNRTableView.h"

@implementation SatellitesView {
    NSMutableDictionary* markers;
    SatellitesViewConverter* converter;
    NSMutableDictionary* markerLabels;
    NSMutableDictionary* highlightedMarkerlabels;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        markers = [[NSMutableDictionary alloc] init];
        markerLabels = [[NSMutableDictionary alloc] init];
        highlightedMarkerlabels = [[NSMutableDictionary alloc] init];
        int radius = self.frame.size.width/2;
        converter = [[SatellitesViewConverter alloc] initWithRadius:radius center:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)];
        [self initSNRTableViewNotification];
    }
    return self;
}

#pragma mark - Managing satellites

-(void)addSatelliteMarker:(SatelliteMarker *)marker{
    NSString* key = [NSString stringWithFormat:@"%d",[marker satelliteID]];
    if (markers.count == 0) {
        [self addMarkerObserver:marker];
        [markers setObject:marker forKey:key];
        [self setNeedsDisplay];
    } else {
        SatelliteMarker* repeatMarker = [markers objectForKey:key];
        if (repeatMarker) {
            repeatMarker.coordinate = marker.coordinate;
            repeatMarker.signalStrength = marker.signalStrength;
            repeatMarker.active = marker.active;
        } else {
            [self addMarkerObserver:marker];
            [markers setObject:marker forKey:key];
            [self setNeedsDisplay];
        }
    }
}

-(void)removeSatelliteMarkerWithNumber:(int)number{
    NSString* key = [NSString stringWithFormat:@"%d", number];
    SatelliteMarker* marker = [markers objectForKey:key];
    [self removeMarkerObservers:marker];
    [markers removeObjectForKey:key];
}

-(void)removeSatellitMarker:(SatelliteMarker*)mark{
    NSString* key = [NSString stringWithFormat:@"%d",[mark satelliteID]];
    [self removeMarkerObservers:[markers objectForKey:key]];
    [markers removeObjectForKey:key];
}

-(void)hightlightSatellitesWithIDs:(NSArray *)ids{
    for (SatelliteMarker* markKey in markers) {
        SatelliteMarker* currentMarker = [markers objectForKey:markKey];
        [currentMarker setActive:NO];
    }
    for (int i=0 ; i<ids.count; ++i) {
        NSString* key = [NSString stringWithFormat:@"%@",ids[i]];
        SatelliteMarker* marker = (SatelliteMarker*) [markers objectForKey:key];
        if (marker) {
            [marker setActive:YES];
        }
    }
}

-(void)dealloc{
    for (SatelliteMarker* marker in markers) {
        [self removeMarkerObservers:marker];
    }
}

#pragma mark - KVO notification

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    [self setNeedsDisplay];
}

-(void)addMarkerObserver:(SatelliteMarker*)mark{
    [mark addObserver:self forKeyPath:@"coordinate" options:0 context:nil];
    [mark addObserver:self forKeyPath:@"signalStrength" options:0 context:nil];
    [mark addObserver:self forKeyPath:@"active" options:0 context:nil];
}

-(void)removeMarkerObservers:(SatelliteMarker*)mark{
    [mark removeObserver:self forKeyPath:@"coordinate"];
    [mark removeObserver:self forKeyPath:@"signalStrength"];
    [mark removeObserver:self forKeyPath:@"active"];

}

#pragma mark - rendering

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, self.frame);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, self.frame);
    [self drawMarking:context step:40];
    [self drawMarkers:context];
}

-(void)drawMarking:(CGContextRef)context step:(int) step{
    for (int i = 10; i < self.frame.size.width/2 ; i += step) {
        [self drawCircle:context deltaX:i];
    }
}

-(void)drawMarkers:(CGContextRef)context{
    [self removeAllSubViews];
    
    for (SatelliteMarker* mark in markers) {
        SatelliteMarker* value = (SatelliteMarker*)[markers objectForKey:mark];
        [self drawSingleMarker:value context:context size:CGSizeMake(35.0f, 35.0f)];
    }
    [self drawNSWE];
}

-(void)drawSingleMarker:(SatelliteMarker*)marker context:(CGContextRef)context size:(CGSize)size{
    CGPoint coordinateOnScreen = [converter convertElevation:marker.coordinate.elevation azimuth:marker.coordinate.azimuth];
    NSString* key = [NSString stringWithFormat:@"%d",marker.satelliteID];
//    if (marker.active) {
//        CGContextSetRGBFillColor(context, 255, 0, 0, [self getSattelliteMarkerAlpha:marker.signalStrength]);
//    } else {
//        CGContextSetRGBFillColor(context, 102/255.0f, 102/255.0f, 102/255.0f, [self getSattelliteMarkerAlpha:marker.signalStrength]);
//    }
//    CGContextFillEllipseInRect(context, CGRectMake(coordinateOnScreen.x, coordinateOnScreen.y, size.width, size.height));
    UILabel* numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(coordinateOnScreen.x, coordinateOnScreen.y, size.width, size.height)];
    [numberLabel setText:[NSString stringWithFormat:@"%d",[marker satelliteID]]];
    numberLabel.layer.cornerRadius = numberLabel.frame.size.width/2;
    [numberLabel setTextColor:[UIColor whiteColor]];
    [numberLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
    numberLabel.textAlignment = NSTextAlignmentCenter;
    if (marker.active) {
        [numberLabel setBackgroundColor:[UIColor colorWithHue:0.0f saturation:[self getSattelliteMarkerSaturation:marker.signalStrength] brightness:1.0f alpha:1.0f]];
    } else {
        [numberLabel setBackgroundColor:[UIColor colorWithHue:167.0f saturation:[self getSattelliteMarkerSaturation:marker.signalStrength] brightness:0.5f alpha:1.0f]];
    }
    if ([highlightedMarkerlabels objectForKey:key]) {
        [numberLabel setBackgroundColor:[UIColor yellowColor]];
    }
    
    [markerLabels setObject:numberLabel forKey:[NSString stringWithFormat:@"%d",marker.satelliteID]];
    [self addSubview:numberLabel];
}

-(float)getSattelliteMarkerSaturation:(SNR)snr{
    return snr/99;
}

-(void)drawNSWE{
    UILabel* northLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2 - 10, 0, 20, 20)];
    UILabel* southLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2 - 10, self.frame.size.height - 20, 20, 20)];
    UILabel* westlLabel = [[UILabel alloc] initWithFrame:CGRectMake(0 , self.frame.size.height/2 - 20, 20, 20)];
    UILabel* eastLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 20, self.frame.size.height/2 - 20, 20, 20)];
    UIFont* helvBold20  = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    [westlLabel setFont:helvBold20];
    [southLabel setFont:helvBold20];
    [northLabel setFont:helvBold20];
    [eastLabel setFont:helvBold20];
    westlLabel.textAlignment = NSTextAlignmentCenter;
    northLabel.textAlignment = NSTextAlignmentCenter;
    southLabel.textAlignment = NSTextAlignmentCenter;
    eastLabel.textAlignment = NSTextAlignmentCenter;
    [northLabel setText:@"N"];
    [southLabel setText:@"S"];
    [westlLabel setText:@"W"];
    [eastLabel setText:@"E"];
    [self addSubview:northLabel];
    [self addSubview:southLabel];
    [self addSubview:westlLabel];
    [self addSubview:eastLabel];
}

-(void)drawCircle:(CGContextRef)context deltaX:(int)delta{
    CGContextSetRGBStrokeColor(context, 0, 255, 123, 0.7);
    CGContextSetLineWidth(context, 1.5);
    
    float lCurrentWidth = self.frame.size.width;
    CGRect circleRect = CGRectMake(delta, delta, lCurrentWidth - delta*2, lCurrentWidth - delta*2);
    CGContextStrokeEllipseInRect(context, circleRect);
}


-(void)removeAllSubViews{
    NSArray *viewsToRemove = [self subviews];
    for (UIView *v in viewsToRemove) {
        [v removeFromSuperview];
    }
}


#pragma SNRTableView notification

-(void)initSNRTableViewNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didTapOnRowSatellite:)
                                                 name:SNRTableViewDidTapOnSatellites
                                               object:nil];
}

-(void)didTapOnRowSatellite:(NSNotification*)notification{
    NSNumber* satelliteID = (NSNumber*)[notification.userInfo objectForKey:SNRTableViewNotificationKey];
    NSString* key = [NSString stringWithFormat:@"%d",[satelliteID integerValue]];
    [self highlightLabel:[markerLabels objectForKey:key]];
}

#pragma mark animation

-(void)highlightLabel:(UILabel*)label{
    [highlightedMarkerlabels setObject:label forKey:[label text]];
    [label setBackgroundColor:[UIColor yellowColor]];
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(deleteLabelFromHighlighted:) userInfo:[label text] repeats:NO];
}

-(void)deleteLabelFromHighlighted:(NSTimer*)timer{
    NSString* key = (NSString*)timer.userInfo;
    [highlightedMarkerlabels removeObjectForKey:key];
    [self setNeedsDisplay];
}

@end
