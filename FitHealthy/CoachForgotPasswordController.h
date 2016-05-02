//
//  CoachForgotPasswordController.h
//  FitHealthy
//
//  Created by MacBook on 21/07/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FHAppDelegate.h"

@interface CoachForgotPasswordController : UIViewController<SlideNavigationControllerDelegate>



{
    
    __weak IBOutlet UITextField *emailField;
}
- (IBAction)sendButtonPressed:(id)sender;


@end
