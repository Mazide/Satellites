//
//  SNRTableViewDelegate.m
//  Satellites
//
//  Created by Nikita Demidov on 13/03/14.
//  Copyright (c) 2014 HORIS. All rights reserved.
//

#import "SNRTableView.h"
#import "Satellite.h"
#import "SnrTableViewCell.h"

NSString* SNRTableViewNotificationKey = @"SNRTableViewKey";
NSString* SNRTableViewDidTapOnSatellites = @"SNRTableViewDidSelectRow";

@implementation SNRTableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _satellites.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    SnrTableViewCell *cell = (SnrTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[SnrTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:CellIdentifier];
    }
    Satellite* temp = (Satellite*)_satellites[indexPath.row];
    NSString* idText = [NSString stringWithFormat:@"%@ %d",NSLocalizedString(@"id", nil),temp.satelliteID];
    [cell.satelliteIDLsbel setText:idText];
    if ([temp snr] == -1.0) {
        [cell.snrLabel setText:NSLocalizedString(@"noSNR", nil)];
        [cell.snrLabel setBackgroundColor:[UIColor clearColor]];
    } else {
        [cell.snrLabel setText:[NSString stringWithFormat:@"%d",(int)[temp snr]]];
        [cell.snrLabel setBackgroundColor:[UIColor redColor]];
        CGRect frame = cell.snrLabel.frame;
        frame.size.width = 300*temp.snr/99;
        [cell.snrLabel setFrame:frame];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Satellite* tempSat = (Satellite*)_satellites[indexPath.row];
    NSNumber* satID = [NSNumber numberWithInt:tempSat.satelliteID];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:satID forKey:SNRTableViewNotificationKey];
    [[NSNotificationCenter defaultCenter] postNotificationName:SNRTableViewDidTapOnSatellites
                                                        object:self userInfo:userInfo];
}

-(void)loadSatellites:(NSArray *)satellites
{
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"snr"
                                                 ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    _satellites = [satellites sortedArrayUsingDescriptors:sortDescriptors];
}

@end
