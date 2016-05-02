//
//  ChangePasswordController.m
//  FitHealthy
//
//  Created by MacBook on 31/07/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import "ChangePasswordController.h"

@interface ChangePasswordController (){
    
    __weak IBOutlet UITextField *confirmPasswordField;
    __weak IBOutlet UITextField *newPasswordField;
}
- (IBAction)changeButtonPressed:(id)sender;

@end

@implementation ChangePasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)tapScreen:(UITapGestureRecognizer *)sender {
   [newPasswordField resignFirstResponder];
   [confirmPasswordField  resignFirstResponder];
   
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - Slider Method

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return NO;
}





- (IBAction)changeButtonPressed:(id)sender {
    
    
    if (newPasswordField.text.length==0 || confirmPasswordField.text.length==0) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error!!" message:@"Please fill all the fields" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        return;
    }
    NSMutableDictionary *sendingDict=[NSMutableDictionary dictionaryWithObjectsAndKeys:[FHDelegate.userInfo.info valueForKey:@"user_security_hash"],@"user_security_hash",[FHDelegate.userInfo.info valueForKey:@"user_id"],@"user_id",nil];
    [sendingDict setValue:newPasswordField.text forKey:@"user_login_password"];
    [sendingDict setValue:confirmPasswordField.text forKey:@"confirm_login_password"];
        [RequestManager getFromServer:@"change_password" parameters:sendingDict completionHandler:^(NSMutableDictionary *responseDict) {
    
    
            if ([[responseDict valueForKey:@"code"] isEqualToString:@"1"]) {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Success !!!" message:[responseDict valueForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [alert show];
                newPasswordField.text=@"";
                confirmPasswordField.text=@"";
                
                NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithDictionary:FHDelegate.userInfo.info];
                
                
                
                NSArray *dictKeys=[[responseDict valueForKey:@"data"] allKeys];
                
                
                for (NSString *key in dictKeys){
                    if ([dic valueForKey:key]) {
                        
                        [dic setValue:[[responseDict valueForKey:@"data"] valueForKey:key] forKey:key];
                        
                    }
                }
                
                
                FHDelegate.userInfo.info=dic;
                [FHDelegate saveCustomObject:FHDelegate.userInfo key:@"userinfo"];
                
                
            } else if ([[responseDict valueForKey:@"code"] isEqualToString:@"0"]) {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error !!!" message:[responseDict valueForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [alert show];
            }
        }];
}
@end
