//
//  ViewController.m
//  FitHealthy
//
//  Created by MacBook on 18/07/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import "FirstViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self performSelector:@selector(calledStartup) withObject:nil afterDelay:1.0];
    
   
       // Do any additional setup after loading the view, typically from a nib.
}



-(void)calledStartup{
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    
    if([userDefaults valueForKey:@"logged"] && ![[userDefaults valueForKey:@"logged"] isEqualToString:@""]){
        
//        if ([[userDefaults valueForKey:@"logged"] isEqualToString:@"coach"]) {
//            
//        }
//        else{
//
//        }
        [self sessionLogin];
        
    }
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=true;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)facebookButtonPressed:(UIButton *)sender {
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    
    if ([FBSDKAccessToken currentAccessToken]) {
        [login logOut];
        //picView.profileID=[FBSDKAccessToken currentAccessToken].userID;
    }
   
   // FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions:@[@"email",@"public_profile"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            // Process error
        } else if (result.isCancelled) {
            // Handle cancellations
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Try Again" message:@"Login Failed from facebook" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
        } else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if ([result.grantedPermissions containsObject:@"email"]) {
                // Do work
                UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                                         bundle: nil];
               
                
                TermsViewController *terms=(TermsViewController*)[mainStoryboard
                                                                  instantiateViewControllerWithIdentifier: @"TermsViewController"];
                
                
                
                
                NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
                [parameters setValue:@"id,first_name,last_name,gender,email" forKey:@"fields"];
                
                [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:parameters]
                 startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                     if (!error) {
                         NSLog(@"fetched user:%@", result);
                         [RequestManager getFromServer:@"social_media_login" parameters:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"facebook",@"social_media_platform",[result valueForKey:@"id"],@"social_media_id",[result valueForKey:@"email"],@"user_email",[result valueForKey:@"first_name"],@"user_first_name",[result valueForKey:@"last_name"],@"user_last_name", nil] completionHandler:^(NSDictionary *responseDict) {
                             NSLog(@"Strign =%@",responseDict);
                             
                             
                             if (![[responseDict valueForKey:@"code"] isEqualToString:@"1"]) {
                                 return ;
                             }
                             
                              NSUserDefaults *defualts=[NSUserDefaults standardUserDefaults];
                             
                             
                            // [[responseDict valueForKey:@"data"] setValue:@"0" forKey:@"terms_accepted"];
                             
                             UserInfo *userinfo=[[UserInfo alloc]init];
                             userinfo.info=[responseDict valueForKey:@"data"];
                             FHDelegate.userInfo=userinfo;
                             [FHDelegate saveCustomObject:userinfo key:@"userinfo"];
                             
                             FHDelegate.logged=true;
                             
                             LeftMenuViewController *left=(LeftMenuViewController*)[SlideNavigationController sharedInstance].leftMenu;
                             
                             if ([[[responseDict valueForKey:@"data"] valueForKey:@"group_slug"] isEqualToString:@"user"]) {

                                 left.coachLogin=false;
                             }
                             else{
                                 left.coachLogin=true;
                             }
                             [defualts synchronize];
                             [left updateValues];
                             
                             GoalConsultationRoomController *goalRoom = (GoalConsultationRoomController*)[mainStoryboard
                                                                                                          instantiateViewControllerWithIdentifier: @"GoalConsultationRoomController"];
                             
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
                             
                         }];
//                         self.navigationController.navigationBarHidden=false;
//                         [self.navigationController pushViewController:coachLogin animated:YES];
                         
                         
                     }
                 }];
                
//                [[SlideNavigationController alloc]initWithRootViewController:coachLogin].leftMenu = FHDelegate.leftView;
//                [SlideNavigationController sharedInstance].menuRevealAnimationDuration = .4;
//                [SlideNavigationController sharedInstance].leftMenu=FHDelegate.leftView;
                
               // [RequestManager getFromServer:@"" parameters:<#(NSMutableDictionary *)#> completionHandler:<#^(NSDictionary *responseDict)handler#>]
                
                
            }
        }
    }];
    
}

- (IBAction)tweeterButtonPressed:(id)sender {
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    
   
    TermsViewController *terms=(TermsViewController*)[mainStoryboard
                                                      instantiateViewControllerWithIdentifier: @"TermsViewController"];
    [[Twitter sharedInstance] logInWithCompletion:^(TWTRSession *session, NSError *error) {
                if (session) {
                    NSLog(@"signed in as %@", [session userName]);
                    NSLog(@"signed in as %@", [session userID]);
                    [[[Twitter sharedInstance] APIClient] loadUserWithID:[session userID]
                                                              completion:^(TWTRUser *user,
                                                                           NSError *error)
                     {
                         // handle the response or error
                         if (![error isEqual:nil]) {
                             NSLog(@"Twitter info   -> user = %@ ",user.name);
//                             NSString *urlString = [[NSString alloc]initWithString:user.profileImageLargeURL];
//                             NSURL *url = [[NSURL alloc]initWithString:urlString];
//                             NSData *pullTwitterPP = [[NSData alloc]initWithContentsOfURL:url];
//                             
//                             UIImage *profImage = [UIImage imageWithData:pullTwitterPP];
                             
                             NSMutableArray *array = [NSMutableArray arrayWithArray:[user.name componentsSeparatedByString:@" "]];
                             NSString *firstName= [array objectAtIndex:0];
                             
                             [array replaceObjectAtIndex:0 withObject:@""];
                             NSString *lastName=[array componentsJoinedByString:@" "];
                             NSLog(@"first name =%@, last name=%@",firstName,lastName);
                             
                             [RequestManager getFromServer:@"social_media_login" parameters:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"twitter",@"social_media_platform",user.userID,@"social_media_id",@"",@"user_email",firstName,@"user_first_name",lastName,@"user_last_name", nil] completionHandler:^(NSDictionary *responseDict) {
                                 NSLog(@"Strign =%@",responseDict);
                                 if (![[responseDict valueForKey:@"code"] isEqualToString:@"1"]) {
                                     return ;
                                 }
                                 
                                 NSUserDefaults *defualts=[NSUserDefaults standardUserDefaults];
                                 //[defualts setValue:@"logged" forKey:@"logged"];
                                 UserInfo *userinfo=[[UserInfo alloc]init];
                                 userinfo.info=[responseDict valueForKey:@"data"];
                                 FHDelegate.userInfo=userinfo;
                                 [FHDelegate saveCustomObject:userinfo key:@"userinfo"];
                                 [defualts synchronize];
                                 //FHDelegate.logged=true;
                                 
                                 LeftMenuViewController *left=(LeftMenuViewController*)[SlideNavigationController sharedInstance].leftMenu;
                                 left.coachLogin=false;
                                 [left updateValues];
                                 
                                 
                                 GoalConsultationRoomController *goalRoom = (GoalConsultationRoomController*)[mainStoryboard
                                                                                                              instantiateViewControllerWithIdentifier: @"GoalConsultationRoomController"];
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
                                 
                             }];
                             
                             
                         } else {
                             NSLog(@"Twitter error getting profile : %@", [error localizedDescription]);
                         }
                     }];
                    
        
                } else {
                    NSLog(@"error: %@", [error localizedDescription]);
                }
            }];
    
}

- (IBAction)coachButtonPressed:(id)sender {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    
    CoachLoginViewController *coachLogin = (CoachLoginViewController*)[mainStoryboard
                                                            instantiateViewControllerWithIdentifier: @"coachLoginView"];
    self.navigationController.navigationBarHidden=false;
    [self.navigationController pushViewController:coachLogin animated:YES];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}


-(void)sessionLogin{
    
    FHDelegate.userInfo =[FHDelegate loadCustomObjectWithKey:@"userinfo"];
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithObjectsAndKeys:[FHDelegate.userInfo.info valueForKey:@"user_security_hash"],@"user_security_hash",[FHDelegate.userInfo.info valueForKey:@"user_id"],@"user_id", nil];
    
    [RequestManager sessionLogin:@"session_login" parameters:dict completionHandler:^(NSMutableDictionary *responseDict) {
        
        if ([[responseDict valueForKey:@"code"] isEqualToString:@"1"] ) {
           
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                                     bundle: nil];
            
            GoalConsultationRoomController *goalRoom = (GoalConsultationRoomController*)[mainStoryboard
                                                                                         instantiateViewControllerWithIdentifier: @"GoalConsultationRoomController"];
            
            
            NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithDictionary:FHDelegate.userInfo.info];
            
            NSArray *dictKeys=[[responseDict valueForKey:@"data"] allKeys];
            
            
            for (NSString *key in dictKeys){
                if ([dic valueForKey:key]) {
                    
                    [dic setValue:[[responseDict valueForKey:@"data"] valueForKey:key] forKey:key];
                    
                }
            }
            
            
            FHDelegate.userInfo.info=dic;
            [FHDelegate saveCustomObject:FHDelegate.userInfo key:@"userinfo"];
            LeftMenuViewController*left=(LeftMenuViewController*) [SlideNavigationController sharedInstance].leftMenu;
            [left updateValues];
           
            FHDelegate.logged=true;
            
            if ([[[responseDict valueForKey:@"data"] valueForKey:@"group_slug"] isEqualToString:@"user"]) {
                left.coachLogin=false;
            }
            else{
                left.coachLogin=true;
            }
            
            self.navigationController.navigationBarHidden=false;
            [self.navigationController pushViewController:goalRoom animated:YES];
            
            NSLog(@"session updated Success");
        }
        else if ([[responseDict valueForKey:@"requestStatus"] isEqualToString:@"1"]){
            [self performSelector:@selector(sessionLogin) withObject:nil afterDelay:3.0];
            NSLog(@"drama");
        }

    }];
}



@end
