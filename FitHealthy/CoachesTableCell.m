//
//  CoachesTableCell.m
//  FitHealthy
//
//  Created by MacBook on 26/07/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import "CoachesTableCell.h"
#import "ASStarRatingView.h"

@implementation CoachesTableCell

- (void)awakeFromNib {
    // Initialization code
    _feedbackView.maxRating=5;
    _feedbackView.canEdit=false;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
