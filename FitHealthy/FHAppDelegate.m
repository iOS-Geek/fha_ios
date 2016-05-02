//
//  FHAppDelegate.m
//  FitHealthy
//
//  Created by MacBook on 18/07/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import "FHAppDelegate.h"

@interface FHAppDelegate ()

@end

@implementation FHAppDelegate
@synthesize firstView,leftView,userInfo,logged;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _productDict=[NSMutableDictionary dictionary];
    _requestCount=0;
    logged=false;
    [FBSDKProfilePictureView class];
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    //[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navBarImage"] forBarMetrics:UIBarMetricsDefault];
    
    [UserDefaults setBool:false ToKey:@"oovooLogged"];
    
    //Tweeter Fabric
    //[Fabric with:@[CrashlyticsKit, TwitterKit]];

[[Twitter sharedInstance] startWithConsumerKey:@"GVgx8ZxMftq0aZOJqkMTFJtLV" consumerSecret:@"fcE51Bg9LhFHZAzDsaF1j987WHY8sHv2NMDTFuAa1LDIIcOgZA"];
    
    
    
    
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor FHThemeColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTranslucent:NO];//:[UIColor greenColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor whiteColor], NSForegroundColorAttributeName,
      [UIFont systemFontOfSize:18.0f], NSFontAttributeName,nil]];
    
     self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    
    
    InitialViewController *initialView=(InitialViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"InitialViewController"];
    
    
    
    
    
    /*
    
    
    firstView = (FirstViewController*)[mainStoryboard
                                                               instantiateViewControllerWithIdentifier: @"firstView"];
    
    //navController = [[UINavigationController alloc]initWithRootViewController:navController];
    firstView.navigationController.navigationBarHidden=true;
   
    //[self.window setRootViewController:firstView];
   
    
    // set up for slider view
    
    leftView = (LeftMenuViewController*)[mainStoryboard
                                                                 instantiateViewControllerWithIdentifier: @"LeftMenuViewController"];
    
    
    
    GoalConsultationRoomController *fisrtLoggedView =(GoalConsultationRoomController*)[mainStoryboard
                                                                               instantiateViewControllerWithIdentifier: @"GoalConsultationRoomController"];
   
    
    
    id <SlideNavigationContorllerAnimator> revealAnimator;
    //CGFloat animationDuration = 0;
    revealAnimator = [[SlideNavigationContorllerAnimatorScaleAndFade alloc] initWithMaximumFadeAlpha:.6 fadeColor:[UIColor blackColor] andMinimumScale:.8];
    //animationDuration = .22;
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    if([userDefaults valueForKey:@"logged"]){
        
        
        
        if ([[userDefaults valueForKey:@"logged"] isEqualToString:@"fb"]) {
            if ([FBSDKAccessToken currentAccessToken]) {
               // dispatch_after(dispatch_time(DISPATCH_TIME_NOW, .5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                   
                
               // [[SlideNavigationController sharedInstance] pushViewController:fisrtLoggedView animated:YES];
//                [SlideNavigationController sharedInstance].navigationBarHidden=false;
//                [[SlideNavigationController sharedInstance] setViewControllers:@[fisrtLoggedView] animated:YES];//:fisrtLoggedView animated:YES];
//                [SlideNavigationController sharedInstance].navigationBarHidden=false;
                
                [[SlideNavigationController alloc]initWithRootViewController:fisrtLoggedView].leftMenu = leftView;
                
                userInfo=[self loadCustomObjectWithKey:@"userinfo"];
                [leftView updateValues];
                
                //[self sessionLogin];
                //    });
            }
            else{
                [[SlideNavigationController alloc]initWithRootViewController:firstView].leftMenu = leftView;
            }
        }
        else if ([[userDefaults valueForKey:@"logged"] isEqualToString:@"twitter"]) {
            [[SlideNavigationController alloc]initWithRootViewController:fisrtLoggedView].leftMenu = leftView;
            
            userInfo=[self loadCustomObjectWithKey:@"userinfo"];
            [leftView updateValues];
            //[self sessionLogin];

        }
        else if ([[userDefaults valueForKey:@"logged"] isEqualToString:@"coach"]) {
            leftView.coachLogin=true;
          [[SlideNavigationController alloc]initWithRootViewController:fisrtLoggedView].leftMenu = leftView;
            userInfo=[self loadCustomObjectWithKey:@"userinfo"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                 [leftView updateValues];
            });
            //[self sessionLogin];
           
        }
        else{
            [[SlideNavigationController alloc]initWithRootViewController:firstView].leftMenu = leftView;
        }
    }
    else{
        
        logged=false;
         [[SlideNavigationController alloc]initWithRootViewController:firstView].leftMenu = leftView;
        
    }
    
    
    
    [SlideNavigationController sharedInstance].menuRevealAnimationDuration = .4;
    [SlideNavigationController sharedInstance].menuRevealAnimator = revealAnimator;
    [[SlideNavigationController sharedInstance].view setBackgroundColor:[UIColor FHBackgroundColor]];
     
     
    [self.window setRootViewController:[SlideNavigationController sharedInstance]];
    
     */
    
    
    
    [self.window setRootViewController:initialView];
    
    
    [UserDefaults setBool:NO ToKey:User_isInVideoView];
    
    [self setupConnectionParameters];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserverForName:SlideNavigationControllerDidClose object:nil queue:nil usingBlock:^(NSNotification *note) {
        NSString *menu = note.userInfo[@"menu"];
        NSLog(@"Closed %@", menu);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:SlideNavigationControllerDidOpen object:nil queue:nil usingBlock:^(NSNotification *note) {
        NSString *menu = note.userInfo[@"menu"];
        NSLog(@"Opened %@", menu);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:SlideNavigationControllerDidReveal object:nil queue:nil usingBlock:^(NSNotification *note) {
        NSString *menu = note.userInfo[@"menu"];
        NSLog(@"Revealed %@", menu);
    }];

    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self.window makeKeyAndVisible];
    
    
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
       
    
    [[RageIAPHelper sharedInstance] requestProductsWithCompletionHandler:^(BOOL success, NSArray *products) {
        if (success) {
            NSLog(@"Products ----------  %@", products);
            _isFetchedProducts=true;
        }
        else{
            _isFetchedProducts=false;
        }
        
    }];
        });
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    ooVooClient *sdk = [ooVooClient sharedInstance];
    [sdk.AVChat.VideoController stopTransmitVideo];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    ooVooClient *sdk = [ooVooClient sharedInstance];
    [sdk.AVChat.VideoController startTransmitVideo];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [FBSDKAppEvents activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}


-(void)show_LoadingIndicator
{
    if(!HUD)
    {
        HUD = [[MBProgressHUD alloc] initWithView:self.window];
        [self.window addSubview:HUD];
        HUD.delegate = self;
        HUD.labelText = @"Loading . . .";
        
    }
    [HUD show:YES];
    [self.window performSelector:@selector(bringSubviewToFront:) withObject:HUD afterDelay:0.1];
    NSLog(@"Hud Shown");
}


-(void)hide_LoadingIndicator
{
    if(HUD)
    {
        [HUD hide:YES];
    }
    NSLog(@"Hud hidden");
}

- (void)saveCustomObject:(UserInfo *)object key:(NSString *)key {
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:object];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedObject forKey:key];
    [defaults synchronize];
    
}

- (UserInfo *)loadCustomObjectWithKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:key];
    UserInfo *object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    return object;
}


-(void)goToFitAndHealthyApp
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://itunes.apple.com/us/app/fit-+-healthy/id616802017?ls=1&mt=8"]];
}


#pragma mark - Configuration
- (void)setupConnectionParameters
{
    NSDictionary *curParameters =
    @{
      APP_TOKEN_SETTINGS_KEY   : [[SettingBundle sharedSetting] getSettingForKey:@"settingBundle_AppToken"],
      LOG_LEVEL_SETTINGS_KEY   : [[SettingBundle sharedSetting] getSettingForKey:@"settingBundle_SDK_LogLevel"]
      };
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:curParameters];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSString *curAppToken = [[NSUserDefaults standardUserDefaults] stringForKey:APP_TOKEN_SETTINGS_KEY];
    int curLogLevel = (int)[[NSUserDefaults standardUserDefaults]  integerForKey:LOG_LEVEL_SETTINGS_KEY];
    
    NSString *appToken = curAppToken;
    NSNumber *logLevel = [NSNumber numberWithInt:curLogLevel];
    
    [[SettingBundle sharedSetting] setSettingKey:@"settingBundle_AppToken" WithValue:appToken];
    [[SettingBundle sharedSetting] setSettingKey:@"settingBundle_SDK_LogLevel" WithValue:[NSString stringWithFormat:@"%d",curLogLevel]];
    
    [[NSUserDefaults standardUserDefaults] setValue:appToken forKey:APP_TOKEN_SETTINGS_KEY];
    [[NSUserDefaults standardUserDefaults] setValue:logLevel forKey:LOG_LEVEL_SETTINGS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}


///
-(void)show_LoadingIndicatorConfigure
{
    if(!configureHUD)
    {
        configureHUD = [[MBProgressHUD alloc] initWithView:self.window];
        [self.window addSubview:configureHUD];
        configureHUD.delegate = self;
        configureHUD.labelText = @"Loading. . .";
        
    }
    [configureHUD show:YES];
    [self.window performSelector:@selector(bringSubviewToFront:) withObject:configureHUD afterDelay:0.1];
    NSLog(@"Hud Shown");
}


-(void)hide_LoadingIndicatorConfigure
{
    if(configureHUD)
    {
        [configureHUD hide:YES];
    }
    NSLog(@"Hud hidden");
}


@end
