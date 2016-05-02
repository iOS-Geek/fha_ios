//
//  CoachLoginViewController.h
//  FitHealthy
//
//  Created by MacBook on 19/07/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FHAppDelegate.h"
#import "SlideNavigationController.h"

@interface CoachLoginViewController : UIViewController<SlideNavigationControllerDelegate>{
    
}

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)fogotButtonPressed:(id)sender;
- (IBAction)loginButtonPressed:(id)sender;
- (IBAction)signUpButtonPressed:(id)sender;

@end
