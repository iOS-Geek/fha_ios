//
//  AnswerTableCell.h
//  FitHealthy
//
//  Created by MacBook on 28/07/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QuestionsList;
@class ASStarRatingView;

#import "ASStarRatingView.h"

@protocol AnswerCellDelegate <NSObject>
- (void)ButtonPressed:(QuestionsList*)answer;
@end


@interface AnswerTableCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *topic;

@property (weak, nonatomic) IBOutlet UIImageView *userImage;

@property (weak, nonatomic) IBOutlet UILabel *valueText;
@property (weak, nonatomic) IBOutlet UILabel *ansCount_time;
@property (weak, nonatomic) IBOutlet UIButton *talkToButton;

@property (weak, nonatomic) IBOutlet ASStarRatingView *FeebackView;

@property (weak, nonatomic) IBOutlet UILabel *feedbackCount;


@property (nonatomic, strong) QuestionsList *question;
@property (nonatomic, assign) id<AnswerCellDelegate>delegate;
- (IBAction)talkButtonPressed:(id)sender;


@end
