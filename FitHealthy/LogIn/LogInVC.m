//
//  LogInVC.m
//  ooVooSdkSampleShow
//
//  Created by Udi on 3/30/15.
//  Copyright (c) 2015 ooVoo LLC. All rights reserved.
//

#import "LogInVC.h"
#import "UIView-Extensions.h"
#import "ActiveUserManager.h"
#import "ViewController.h"

#import "SettingBundle.h"
#import "UserDefaults.h"

#define User_isInVideoView @"User_isInVideoView"

#define Segue_Authorization @"ToAuthorizationView"
#define Segue_PushTo_ConferenceVC @"ConferenceVC"

#define UserDefault_UserId @"UserID"


@interface LogInVC () {
  
    __weak IBOutlet UIActivityIndicatorView *spinner;
}

@end

@implementation LogInVC

@synthesize timer;
int hours, minutes, seconds;
int secondsLeft;



- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.

    self.sdk = [ooVooClient sharedInstance];
    self.sdk.Account.delegate = self;
    secondsLeft = _duration;
    [self countdownTimer];
}

- (void)updateCounter:(NSTimer *)theTimer {
    if(secondsLeft > 0 ){
        secondsLeft -- ;
        hours = secondsLeft / 3600;
        minutes = (secondsLeft % 3600) / 60;
        seconds = (secondsLeft %3600) % 60;
        NSString *str = [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
        
        NSLog(@"stringTime=%@\n",str);
        if ([_timerDelegate respondsToSelector:@selector(setTimeString:)]) {
            [_timerDelegate setTimeString:str];
        }
    }
    else{
        if ([_timerDelegate respondsToSelector:@selector(timerStopped)]) {
            [_timerDelegate timerStopped];
        }
        NSLog(@"Timer Ended");
        [timer invalidate];
        timer=nil;
    }
}

-(void)countdownTimer{
    
   
    if([timer isValid])
    {
        //[timer release];
    }
   
     timer = [NSTimer timerWithTimeInterval:1.0f target:self selector:@selector(updateCounter:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    //[pool release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    
    //_txt_userId.text = [self randomUser];
    
//    UIButton *btnLoging = [self.view viewWithTag:100];
//    btnLoging.enabled = true;
    self.navigationItem.title = @"Connecting...";
}
- (void)viewDidDisappear:(BOOL)animated {
    //self.txt_userId.text = @"";
}


#pragma mark - Navigation

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqualToString:Segue_Authorization]) {
        
        if ([UserDefaults getBoolForToKey:@"oovooLogged"]) {
            [self performSegueWithIdentifier:Segue_PushTo_ConferenceVC sender:nil];
            return NO;
        }
        if ([UserDefaults getBoolForToKey:User_isInVideoView]) {
            [self performSegueWithIdentifier:Segue_PushTo_ConferenceVC sender:nil];
            return NO;
        }
    }
    return YES;
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

    if ([segue.identifier isEqualToString:Segue_Authorization]) {
        AuthorizationLoaderVc *authoVC = segue.destinationViewController;
        authoVC.delegate = self;
    }
    if ([segue.identifier isEqualToString:Segue_PushTo_ConferenceVC]) {
         ViewController *viewC = segue.destinationViewController;
        
        [UserDefaults setBool:true ToKey:@"oovooLogged"];
        
        viewC.txtDisplayNameText=_userName;
        viewC.txt_conferenceIdText=_conferenceId;
        viewC.ratingView=_feedback;
        viewC.bookingId=_bookingId;
        
    }
}

#pragma mark - Authorization Delegate

- (void)AuthorizationDelegate_DidAuthorized {

    [UIView animateWithDuration:1
                     animations:^{

                       //        self.viewAuthorization_Container.y=-self.viewAuthorization_Container.height;
                       self.viewAuthorization_Container.alpha = 0;
                         [self act_LogIn:[[UIButton alloc]init]];
                     }];
}

#pragma mark - IBAction

- (IBAction)act_LogIn:(id)sender {
    
       //[UserDefaults setObject:@"1234567" ForKey:UserDefault_UserId];
    
    [sender setEnabled:false];
    [spinner startAnimating];
    
    NSLog(@"%@",_userId);
    
    [self.sdk.Account login:_userId
                 completion:^(SdkResult *result) {
                     NSLog(@"result code=%d result description %@", result.Result, result.description);
                     [spinner stopAnimating];
                     if (result.Result){
                         [[[UIAlertView alloc] initWithTitle:@"Connection Error" message:result.description delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
                     }
                     else
                         [self onLogin:result.Result];
                 }];
}


#pragma mark - private methods

- (void)onLogin:(BOOL)error {
    if (!error) {
        [ActiveUserManager activeUser].userId = _userId;
        [self performSegueWithIdentifier:Segue_PushTo_ConferenceVC sender:nil];
    }else{
        
    }
}




#pragma mark - ooVoo Account delegate

- (void)didAccountLogIn:(id<ooVooAccount>)account {
    
}
- (void)didAccountLogOut:(id<ooVooAccount>)account {
    
}


@end
