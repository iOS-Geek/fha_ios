//
//  InitialViewController.m
//  FitHealthy
//
//  Created by MacBook on 22/08/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import "InitialViewController.h"

@interface InitialViewController ()

@end

@implementation InitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self calledWebService];
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



-(void)calledWebService{
    
    [RequestManager configureApp:^(NSMutableDictionary *responseDict) {
        if ([[responseDict valueForKey:@"code"] isEqualToString:@"1"]) {
            
            NSLog(@"%@",responseDict);
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                                     bundle: nil];
            
             FHDelegate.firstView = (FirstViewController*)[mainStoryboard
             instantiateViewControllerWithIdentifier: @"firstView"];
            
            
            [[NSUserDefaults standardUserDefaults] setValue:[[responseDict valueForKey:@"data"] valueForKey:@"configurations"] forKey:@"config"];
            
            
            
            
            FHDelegate.logged=false;
            FHDelegate.leftView = (LeftMenuViewController*)[mainStoryboard
                                                 instantiateViewControllerWithIdentifier: @"LeftMenuViewController"];
            
            id <SlideNavigationContorllerAnimator> revealAnimator;
            //CGFloat animationDuration = 0;
            revealAnimator = [[SlideNavigationContorllerAnimatorScaleAndFade alloc] initWithMaximumFadeAlpha:.6 fadeColor:[UIColor blackColor] andMinimumScale:.8];
            
            
            [[SlideNavigationController alloc]initWithRootViewController:FHDelegate.firstView].leftMenu = FHDelegate.leftView;
            [SlideNavigationController sharedInstance].menuRevealAnimationDuration = .4;
            [SlideNavigationController sharedInstance].menuRevealAnimator = revealAnimator;
            [[SlideNavigationController sharedInstance].view setBackgroundColor:[UIColor FHBackgroundColor]];
            
            
            
            
            
            
            [UIView
             transitionWithView:FHDelegate.window
             duration:1.2
             options:UIViewAnimationOptionTransitionCrossDissolve
             animations:^(void) {
                 BOOL oldState = [UIView areAnimationsEnabled];
                 [UIView setAnimationsEnabled:NO];
                 
                 [FHDelegate.window setRootViewController:[SlideNavigationController sharedInstance]];
                 
                 [UIView setAnimationsEnabled:oldState];
             }
             completion:nil];
            
        }
        else if ([[responseDict valueForKey:@"requestStatus"] isEqualToString:@"1"]){
            [self performSelector:@selector(calledWebService) withObject:nil afterDelay:2.0];
            NSLog(@"drama");
        }
    
    }];

}

@end
