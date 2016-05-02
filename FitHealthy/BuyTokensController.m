//
//  BuyTokensController.m
//  FitHealthy
//
//  Created by MacBook on 26/07/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import "BuyTokensController.h"
#import "RageIAPHelper.h"
#import "Reachability.h"

@interface BuyTokensController ()

@end

@implementation BuyTokensController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"Buy Tokens";
    [self updateView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkStatus:) name:@"TransactionNotificaiton" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkStatus:) name:@"TransactionNotificationFailed" object:nil];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void)checkStatus:(NSNotification*)notification{
    [FHDelegate hide_LoadingIndicator];
    NSDictionary *dict=notification.userInfo;
    NSLog(@"%@",notification.userInfo);
    if ([[dict valueForKey:@"status"] isEqualToString:@"success"]) {
        
    
    if ([[dict valueForKey:@"type"] isEqualToString:typeOne]) {
        NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithObjectsAndKeys:[FHDelegate.userInfo.info valueForKey:@"user_security_hash"],@"user_security_hash",[FHDelegate.userInfo.info valueForKey:@"user_id"],@"user_id",@"single_token_one",@"token_type", nil];
        
        [RequestManager getFromServer:@"purchase" parameters:dict completionHandler:^(NSDictionary *responseDict) {
            
            if ([[responseDict valueForKey:@"code"] isEqualToString:@"1"]) {
            
                
                NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithDictionary:FHDelegate.userInfo.info];
                
                [dic setValue:[[responseDict valueForKey:@"data"] valueForKey:@"user_token_count"] forKey:@"user_token_count"];
                FHDelegate.userInfo.info=dic;
                [FHDelegate saveCustomObject:FHDelegate.userInfo key:@"userinfo"];
                
                LeftMenuViewController *left=(LeftMenuViewController*)[SlideNavigationController sharedInstance].leftMenu;
                [left updateValues];
                [self updateView];
            }
            else if ([[responseDict valueForKey:@"code"] isEqualToString:@"0"]) {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error !!!" message:[responseDict valueForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
               [alert show];
            }
            
        }];
        
    
    }
    else if ([[dict valueForKey:@"type"] isEqualToString:typeTwo]){
        NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithObjectsAndKeys:[FHDelegate.userInfo.info valueForKey:@"user_security_hash"],@"user_security_hash",[FHDelegate.userInfo.info valueForKey:@"user_id"],@"user_id",@"single_token_two",@"token_type", nil];
        
        [RequestManager getFromServer:@"purchase" parameters:dict completionHandler:^(NSDictionary *responseDict) {
            
            if ([[responseDict valueForKey:@"code"] isEqualToString:@"1"]) {
                
                NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithDictionary:FHDelegate.userInfo.info];
                
                [dic setValue:[[responseDict valueForKey:@"data"] valueForKey:@"user_token_count"] forKey:@"user_token_count"];
                FHDelegate.userInfo.info=dic;
                [FHDelegate saveCustomObject:FHDelegate.userInfo key:@"userinfo"];
                LeftMenuViewController *left=(LeftMenuViewController*)[SlideNavigationController sharedInstance].leftMenu;
                [left updateValues];
                [self updateView];
            }
            else if ([[responseDict valueForKey:@"code"] isEqualToString:@"0"]) {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error !!!" message:[responseDict valueForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [alert show];
            }
            
        }];
    }
    else{
        NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithObjectsAndKeys:[FHDelegate.userInfo.info valueForKey:@"user_security_hash"],@"user_security_hash",[FHDelegate.userInfo.info valueForKey:@"user_id"],@"user_id",@"single_token_three",@"token_type", nil];
        
        [RequestManager getFromServer:@"purchase" parameters:dict completionHandler:^(NSDictionary *responseDict) {
            
            if ([[responseDict valueForKey:@"code"] isEqualToString:@"1"]) {
                
                
                NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithDictionary:FHDelegate.userInfo.info];
                
                [dic setValue:[[responseDict valueForKey:@"data"] valueForKey:@"user_token_count"] forKey:@"user_token_count"];
                FHDelegate.userInfo.info=dic;
                [FHDelegate saveCustomObject:FHDelegate.userInfo key:@"userinfo"];
                LeftMenuViewController *left=(LeftMenuViewController*)[SlideNavigationController sharedInstance].leftMenu;
                [left updateValues];
                [self updateView];
                
            }
            else if ([[responseDict valueForKey:@"code"] isEqualToString:@"0"]) {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error !!!" message:[responseDict valueForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [alert show];
            }
            
        }];
    }
    }
    
}


-(void)updateView{
    _totalBalanceTokens.text=[NSString stringWithFormat:@"Balance : %@ Tokens",[FHDelegate.userInfo.info valueForKey:@"user_token_count"]];
    _pricesTextLabel.text=[[FHDelegate.userInfo.info valueForKey:@"configurations"]valueForKey:@"token_message"];
    _timeLabel.text=[[FHDelegate.userInfo.info valueForKey:@"configurations"]valueForKey:@"gmt_message"];
    
    
    [_freeTokenButton setTitle:[NSString stringWithFormat:@"Redeem:- %@ Tokens",[[FHDelegate.userInfo.info valueForKey:@"configurations"]valueForKey:@"free_tokens_per_month"]] forState:UIControlStateNormal];
    
    _internetUsageLabel.text=[[FHDelegate.userInfo.info valueForKey:@"configurations"]valueForKey:@"broadband_message"];
    // Do any additional setup after loading the view.
    
    _firstLabel.text=[NSString stringWithFormat:@"%@ Tokens\n £ %@",[[FHDelegate.userInfo.info valueForKey:@"configurations"]valueForKey:@"single_token_one"],[[FHDelegate.userInfo.info valueForKey:@"configurations"]valueForKey:@"single_token_one_price"]];
    _secondLabel.text=[NSString stringWithFormat:@"%@ Tokens\n £ %@",[[FHDelegate.userInfo.info valueForKey:@"configurations"]valueForKey:@"single_token_two"],[[FHDelegate.userInfo.info valueForKey:@"configurations"]valueForKey:@"single_token_two_price"]];
    _thirdLabel.text=[NSString stringWithFormat:@"%@ Tokens\n £ %@",[[FHDelegate.userInfo.info valueForKey:@"configurations"]valueForKey:@"single_token_three"],[[FHDelegate.userInfo.info valueForKey:@"configurations"]valueForKey:@"single_token_three_price"]];
    
    if ([[FHDelegate.userInfo.info valueForKey:@"user_free_tokens_available"] isEqualToString:@"0"]) {
        _freeTokenButton.hidden=true;
    }

}

#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return NO;
}


- (IBAction)firstButtonPressed:(id)sender {
    
    if (FHDelegate.isFetchedProducts) {
        [FHDelegate show_LoadingIndicator];
        [[RageIAPHelper sharedInstance] buyProduct:[FHDelegate.productDict objectForKey:typeOne]];
    }
    else{
        
        Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
        
        NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
        
        if (networkStatus == NotReachable) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!!!"
                                  
                                                            message:@"Please connect to internet"
                                  
                                                           delegate:self
                                  
                                                  cancelButtonTitle:@"OK"
                                  
                                                  otherButtonTitles:nil];
            
            [alert show];
            return;
        }
        
        [FHDelegate show_LoadingIndicator];
        [[RageIAPHelper sharedInstance] requestProductsWithCompletionHandler:^(BOOL success, NSArray *products) {
            if (success) {
                NSLog(@"Products ----------  %@", products);
                FHDelegate.isFetchedProducts=true;
                [[RageIAPHelper sharedInstance] buyProduct:[FHDelegate.productDict objectForKey:typeOne]];
            }
            else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!!!"
                                      
                                                                message:@"Error in Connection .Please Try Again Later"
                                      
                                                               delegate:self
                                      
                                                      cancelButtonTitle:@"OK"
                                      
                                                      otherButtonTitles:nil];
                
                [alert show];
                [FHDelegate hide_LoadingIndicator];
            }
            
        }];
    }
    
}



- (IBAction)secondButtonPressed:(id)sender {
    
    if (FHDelegate.isFetchedProducts) {
        [FHDelegate show_LoadingIndicator];
        [[RageIAPHelper sharedInstance] buyProduct:[FHDelegate.productDict objectForKey:typeTwo]];
    }
    else{
        
        Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
        
        NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
        
        if (networkStatus == NotReachable) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!!!"
                                  
                                                            message:@"Please connect to internet"
                                  
                                                           delegate:self
                                  
                                                  cancelButtonTitle:@"OK"
                                  
                                                  otherButtonTitles:nil];
            
            [alert show];
            return;
        }
        
        [FHDelegate show_LoadingIndicator];
        [[RageIAPHelper sharedInstance] requestProductsWithCompletionHandler:^(BOOL success, NSArray *products) {
            if (success) {
                NSLog(@"Products ----------  %@", products);
                FHDelegate.isFetchedProducts=true;
                [[RageIAPHelper sharedInstance] buyProduct:[FHDelegate.productDict objectForKey:typeTwo]];
            }
            else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!!!"
                                      
                                                                message:@"Error in Connection .Please Try Again Later"
                                      
                                                               delegate:self
                                      
                                                      cancelButtonTitle:@"OK"
                                      
                                                      otherButtonTitles:nil];
                
                [alert show];
                [FHDelegate hide_LoadingIndicator];
            }
            
        }];
    }

}
- (IBAction)thirdButtonPressed:(id)sender {
    
    if (FHDelegate.isFetchedProducts) {
        [FHDelegate show_LoadingIndicator];
        [[RageIAPHelper sharedInstance] buyProduct:[FHDelegate.productDict objectForKey:typeThree]];
    }
    else{
        
        Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
        
        NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
        
        if (networkStatus == NotReachable) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!!!"
                                  
                                                            message:@"Please connect to internet"
                                  
                                                           delegate:self
                                  
                                                  cancelButtonTitle:@"OK"
                                  
                                                  otherButtonTitles:nil];
            
            [alert show];
            return;
        }
        
        [FHDelegate show_LoadingIndicator];
        [[RageIAPHelper sharedInstance] requestProductsWithCompletionHandler:^(BOOL success, NSArray *products) {
            if (success) {
                NSLog(@"Products ----------  %@", products);
                FHDelegate.isFetchedProducts=true;
                [[RageIAPHelper sharedInstance] buyProduct:[FHDelegate.productDict objectForKey:typeThree]];
            }
            else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!!!"
                                      
                                                                message:@"Error in Connection .Please Try Again Later"
                                      
                                                               delegate:self
                                      
                                                      cancelButtonTitle:@"OK"
                                      
                                                      otherButtonTitles:nil];
                
                [alert show];
                [FHDelegate hide_LoadingIndicator];
            }
            
        }];
    }

}


- (IBAction)redeemButtonPressed:(id)sender {
    
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithObjectsAndKeys:[FHDelegate.userInfo.info valueForKey:@"user_security_hash"],@"user_security_hash",[FHDelegate.userInfo.info valueForKey:@"user_id"],@"user_id", nil];
    
    [RequestManager getFromServer:@"redeem_free_tokens" parameters:dict completionHandler:^(NSDictionary *responseDict) {
        
        if ([[responseDict valueForKey:@"code"] isEqualToString:@"1"]) {
            
            NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithDictionary:FHDelegate.userInfo.info];
            
            [dic setValue:[[responseDict valueForKey:@"data"] valueForKey:@"user_token_count"] forKey:@"user_token_count"];
            [dic setValue:@"0" forKey:@"user_free_tokens_available"];
            FHDelegate.userInfo.info=dic;
            [FHDelegate saveCustomObject:FHDelegate.userInfo key:@"userinfo"];
            LeftMenuViewController *left=(LeftMenuViewController*)[SlideNavigationController sharedInstance].leftMenu;
            [left updateValues];
            [self updateView];
            
        }
        else if ([[responseDict valueForKey:@"code"] isEqualToString:@"0"]) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error !!!" message:[responseDict valueForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
        }
        
    }];
    
}

@end
