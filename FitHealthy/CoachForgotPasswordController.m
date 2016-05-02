//
//  CoachForgotPasswordController.m
//  FitHealthy
//
//  Created by MacBook on 21/07/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import "CoachForgotPasswordController.h"

@interface CoachForgotPasswordController ()

@end

@implementation CoachForgotPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return NO;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return NO;
}

- (IBAction)sendButtonPressed:(id)sender {
    if (emailField.text.length==0) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Please Fill the email address" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
    }
 [RequestManager getFromServer:@"recover" parameters:[NSMutableDictionary dictionaryWithObjectsAndKeys:emailField.text ,@"email_address", nil] completionHandler:^(NSMutableDictionary *responseDict) {
     if ([[responseDict valueForKey:@"code"] isEqualToString:@"1"]) {
         UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Success !!!" message:[responseDict valueForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
         [alert show];
         
         
         
         
     } else if ([[responseDict valueForKey:@"code"] isEqualToString:@"0"]) {
         UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error !!!" message:[responseDict valueForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
         [alert show];
     }
 }];
}
@end
