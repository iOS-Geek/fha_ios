//
//  ViewController.h
//  FitHealthy
//
//  Created by MacBook on 18/07/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "CoachLoginViewController.h"
#import "FHAppDelegate.h"
@class FBSDKProfilePictureView;

@interface FirstViewController : UIViewController


- (IBAction)facebookButtonPressed:(UIButton *)sender;
- (IBAction)tweeterButtonPressed:(id)sender;
- (IBAction)coachButtonPressed:(id)sender;



@end

