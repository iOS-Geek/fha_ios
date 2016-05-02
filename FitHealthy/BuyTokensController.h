//
//  BuyTokensController.h
//  FitHealthy
//
//  Created by MacBook on 26/07/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FHAppDelegate.h"

@interface BuyTokensController : UIViewController<SlideNavigationControllerDelegate>


@property (weak, nonatomic) IBOutlet UILabel *pricesTextLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *internetUsageLabel;

- (IBAction)redeemButtonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *totalBalanceTokens;

- (IBAction)firstButtonPressed:(id)sender;

- (IBAction)secondButtonPressed:(id)sender;
- (IBAction)thirdButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdLabel;
@property (weak, nonatomic) IBOutlet UIButton *freeTokenButton;

@end
