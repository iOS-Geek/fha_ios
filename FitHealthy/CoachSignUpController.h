//
//  CoachSignUpController.h
//  FitHealthy
//
//  Created by MacBook on 22/07/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoachSignUpController : UIViewController<UITextViewDelegate>{
    
    __weak IBOutlet UITextField *usernameTextField;
    __weak IBOutlet UITextField *phoneTextField;

    __weak IBOutlet UITextField *emailTextField;

     IBOutlet UITextView *descriptionTextView;

    __weak IBOutlet UIImageView *maleImageView;
    __weak IBOutlet UIImageView *femaleImageView;
    BOOL Gender;
    
}


- (IBAction)femaleButtonPressed:(id)sender;
- (IBAction)maleButtonPressed:(id)sender;

- (IBAction)registerButtonPressed:(id)sender;


@end
