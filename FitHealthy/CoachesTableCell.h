//
//  CoachesTableCell.h
//  FitHealthy
//
//  Created by MacBook on 26/07/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ASStarRatingView;

@interface CoachesTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *coachNameTitle;


@property (weak, nonatomic) IBOutlet UIImageView *coachProfileImage;


@property (weak, nonatomic) IBOutlet UILabel *coachDescriptionText;


@property (weak, nonatomic) IBOutlet UILabel *feedbackCountLabel;

@property (retain, nonatomic) IBOutlet ASStarRatingView *feedbackView;


@end
