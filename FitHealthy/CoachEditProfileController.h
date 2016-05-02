//
//  CoachEditProfileController.h
//  FitHealthy
//
//  Created by MacBook on 31/07/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VSDropdown.h"
#import <QuartzCore/QuartzCore.h>
#import "FHAppDelegate.h"

@interface CoachEditProfileController : UIViewController{
    
    VSDropdown * dropDownVar;
}
@property (weak, nonatomic) IBOutlet UIButton *doneButton;

@property (weak, nonatomic) IBOutlet UILabel *skillLabel;

- (IBAction)doneButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *dropdownImage;

- (IBAction)selectSkillsButtonPressed:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextView *selectedTexts;

@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;


@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;

@property (weak, nonatomic) IBOutlet UIImageView *maleButtonImage;

@property (weak, nonatomic) IBOutlet UIImageView *femaleButtonImage;

@property (weak, nonatomic) IBOutlet UILabel *skillsLabel;


@property (weak, nonatomic) IBOutlet UIImageView *profileImage;

- (IBAction)imageButtonPressed:(id)sender;
- (IBAction)updateButtonPressed:(id)sender;

@end
