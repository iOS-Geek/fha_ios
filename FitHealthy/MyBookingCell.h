//
//  MyBookingCell.h
//  FitHealthy
//
//  Created by MacBook on 16/08/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ASStarRatingView;

@interface MyBookingCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;


@property (weak, nonatomic) IBOutlet UILabel *callStartLabel;

@property (weak, nonatomic) IBOutlet UILabel *callEndLabel;

@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *feedbackCountLabel;

@property (weak, nonatomic) IBOutlet ASStarRatingView *feedbackView;

@end
