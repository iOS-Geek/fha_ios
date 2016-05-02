//
//  CoachAvailabilityController.h
//  FitHealthy
//
//  Created by MacBook on 14/08/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FHAppDelegate.h"
#import "VSDropdown.h"
#import <QuartzCore/QuartzCore.h>

@interface CoachAvailabilityController : UIViewController<SlideNavigationControllerDelegate>{
    VSDropdown * vsDropDown;
    NSMutableArray *pickerOneData;
    NSMutableArray *pickerTwoData;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableHieghtConstraint;


@property (weak, nonatomic) IBOutlet UITextField *typeTextfield;
- (IBAction)typeButtonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *topictextfield;

@property (weak, nonatomic) IBOutlet UITextField *startTextfield;
@property (weak, nonatomic) IBOutlet UITextField *endTextfield;
@property (weak, nonatomic) IBOutlet UILabel *gmtMessage;
- (IBAction)updateButtonPressed:(id)sender;
- (IBAction)startButtonPressed:(id)sender;
- (IBAction)endButtonPressed:(id)sender;



@end
