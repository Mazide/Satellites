//
//  snrTableViewCell.h
//  Satellites
//
//  Created by Nikita Demidov on 14/03/14.
//  Copyright (c) 2014 HORIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SnrTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *satelliteIDLsbel;
@property (weak, nonatomic) IBOutlet UILabel *snrLabel;

@end

