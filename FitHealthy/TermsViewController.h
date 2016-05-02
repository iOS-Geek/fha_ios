//
//  TermsViewController.h
//  FitHealthy
//
//  Created by MacBook on 22/08/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FHAppDelegate.h"

@interface TermsViewController : UIViewController<SlideNavigationControllerDelegate>


- (IBAction)continueButtonPressed:(id)sender;


@property (weak, nonatomic) IBOutlet UITextView *termsView;


@end
