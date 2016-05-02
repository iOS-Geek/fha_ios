//
//  GoalRoomTableCell.h
//  FitHealthy
//
//  Created by MacBook on 26/07/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoalRoomTableCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *topic;

@property (weak, nonatomic) IBOutlet UIImageView *userImage;

@property (weak, nonatomic) IBOutlet UILabel *valueText;
@property (weak, nonatomic) IBOutlet UILabel *ansCount_time;

@end
