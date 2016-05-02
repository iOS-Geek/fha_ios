//
//  SingleCoachController.h
//  FitHealthy
//
//  Created by MacBook on 08/08/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FHAppDelegate.h"

@class Coaches;
@class ASStarRatingView;
@interface SingleCoachController : UIViewController

@property(nonatomic)Coaches* coach;

- (IBAction)firstButtonPressed:(id)sender;

- (IBAction)secondButtonPressed:(id)sender;

- (IBAction)thirdButtonPressed:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdLabel;


@property (weak, nonatomic) IBOutlet UIImageView *coachImage;


@property (weak, nonatomic) IBOutlet UILabel *coachDescriptionLabel;

@property (weak, nonatomic) IBOutlet UILabel *CoachNameLabel;

@property (weak, nonatomic) IBOutlet ASStarRatingView *FeedBackView;
@property (weak, nonatomic) IBOutlet UILabel *feedBackCount;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descLabelHeight;


@end
