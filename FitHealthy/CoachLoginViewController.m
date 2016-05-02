//
//  CoachLoginViewController.m
//  FitHealthy
//
//  Created by MacBook on 19/07/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import "CoachLoginViewController.h"

@interface CoachLoginViewController ()<UITextFieldDelegate>

@end

@implementation CoachLoginViewController
@synthesize usernameTextField,passwordTextField;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"Coach Login";
    UITapGestureRecognizer *gesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeKeyBoard)];
    [self.view addGestureRecognizer:gesture];
   // usernameTextField.text=@"ksingh.cec@gmail.com";
   // passwordTextField.text=@"123456789";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isEqual:usernameTextField]) {
        [usernameTextField resignFirstResponder];
        [passwordTextField becomeFirstResponder];
    }
    else{
        [usernameTextField resignFirstResponder];
        [passwordTextField resignFirstResponder];
    }
    return YES;
}

-(void)removeKeyBoard{
    [usernameTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return NO;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return NO;
}

- (IBAction)fogotButtonPressed:(id)sender {
}

- (IBAction)loginButtonPressed:(id)sender {
    
    
    [RequestManager getFromServer:@"login" parameters:[NSMutableDictionary dictionaryWithObjectsAndKeys:usernameTextField.text,@"user_login",passwordTextField.text,@"user_login_password",@"0",@"login_log_latitude",@"0",@"login_log_longitude", nil] completionHandler:^(NSDictionary *responseDict) {
        if (![[responseDict valueForKey:@"code"] isEqualToString:@"1"]) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error !!!" message:[responseDict valueForKey:@"message"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
        }
        else if([[responseDict valueForKey:@"code"] isEqualToString:@"1"]){
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                                     bundle: nil];
            
            GoalConsultationRoomController *goalRoom = (GoalConsultationRoomController*)[mainStoryboard
                                                                                         instantiateViewControllerWithIdentifier: @"GoalConsultationRoomController"];
            NSUserDefaults *defualts=[NSUserDefaults standardUserDefaults];
            [defualts setValue:@"coach" forKey:@"logged"];
            UserInfo *userinfo=[[UserInfo alloc]init];
            userinfo.info=[responseDict valueForKey:@"data"];
            FHDelegate.userInfo=userinfo;
            [FHDelegate saveCustomObject:userinfo key:@"userinfo"];
            [defualts synchronize];
            FHDelegate.logged=true;
            
            LeftMenuViewController *left=(LeftMenuViewController*)[SlideNavigationController sharedInstance].leftMenu;
            left.coachLogin=true;
            [left updateValues];
            
            
            TermsViewController *terms=(TermsViewController*)[mainStoryboard
                                                              instantiateViewControllerWithIdentifier: @"TermsViewController"];
            
            if ([[[responseDict valueForKey:@"data"] valueForKey:@"terms_accepted"] isEqualToString:@"1"]) {
                
                [defualts setValue:@"logged" forKey:@"logged"];
                FHDelegate.logged=true;
                self.navigationController.navigationBarHidden=false;
                [self.navigationController pushViewController:goalRoom animated:YES];
            }
            else{
                self.navigationController.navigationBarHidden=false;
                [self.navigationController pushViewController:terms animated:YES];
            }
            
        }
    }];
}

- (IBAction)signUpButtonPressed:(id)sender {
}
@end
