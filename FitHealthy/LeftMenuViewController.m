//
//  MenuViewController.m
//  SlideMenu
//
//  Created by Aryan Gh on 4/24/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "SlideNavigationContorllerAnimatorFade.h"
#import "SlideNavigationContorllerAnimatorSlide.h"
#import "SlideNavigationContorllerAnimatorScale.h"
#import "SlideNavigationContorllerAnimatorScaleAndFade.h"
#import "SlideNavigationContorllerAnimatorSlideAndFade.h"
#import "LeftMenuTableCell.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "ASStarRatingView.h"

@implementation LeftMenuViewController
@synthesize coachLogin;
#pragma mark - UIViewController Methods -

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self.slideOutAnimationEnabled = YES;
	
	return [super initWithCoder:aDecoder];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
    if (!menuArray) {
        menuArray=[NSMutableArray array];
    }
    if (!iconArray) {
        iconArray=[NSMutableArray array];
    }
    
    if (coachLogin) {
        menuArray=[NSMutableArray arrayWithObjects:@"Goal Consultation Room",@"Edit Profile",@"Change Password",@"My Bookings",@"Availabilty", nil];
        iconArray=[NSMutableArray arrayWithObjects:@"navGoalConsultaionRoom",@"navEditProfile",@"changePassword",@"navMyBooking",@"navTrackingProgress", nil];
    }
    else{
        menuArray=[NSMutableArray arrayWithObjects:@"Goal Consultation Room",@"Coaches",@"Buy Tokens",@"My Bookings",@"Tracking Progress",@"Edit Profile",@"Ask Question", nil];
        iconArray=[NSMutableArray arrayWithObjects:@"navGoalConsultaionRoom",@"navCoaches",@"navBuyTokens",@"navMyBooking",@"navTrackingProgress",@"navEditProfile",@"navAskQuestion", nil];
    }
	self.tableView.separatorColor = [UIColor lightGrayColor];
    
    NSLog(@"%f %f %f ",self.tableView.frame.origin.y,self.tableView.bounds.size.height,[UIScreen mainScreen].bounds.size.height);
    if (self.tableView.frame.origin.y+self.tableView.frame.size.height> [UIScreen mainScreen].bounds.size.height) {
        self.tableView.scrollEnabled=true;
    }
    else{
        self.tableView.scrollEnabled=false;
    }
    
	//UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"leftMenu.jpg"]];
	//self.tableView.backgroundView = imageView;
    
    UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(00, 0, self.view.frame.size.width, 50)];
    headerView.backgroundColor=[UIColor FHThemeColor];
    
    UIButton *button =[[UIButton alloc]initWithFrame:CGRectMake(20, 8, self.view.frame.size.width-100, 36)];
    [button setTitle:@"Download Fit + Healthy App" forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont FHFontBoldWithSize:13];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.borderColor=[UIColor whiteColor].CGColor;
    button.layer.borderWidth=1.0;
    button.layer.cornerRadius=14;
    [button setClipsToBounds:YES];
    [button addTarget:self action:@selector(downloadButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    //[button setBackgroundColor:[UIColor grayColor]];
    [headerView addSubview:button];
    self.tableView.tableHeaderView=headerView;
    UIView *footerView=[[UIView alloc]initWithFrame:CGRectMake(00, 0, self.view.frame.size.width, 50)];
    footerView.backgroundColor=[UIColor FHThemeColor];
    
    UIButton *button2 =[[UIButton alloc]initWithFrame:CGRectMake(20, 8, self.view.frame.size.width-100, 36)];
    [button2 setTitle:@"Logout" forState:UIControlStateNormal];
    button2.titleLabel.font=[UIFont FHFontBoldWithSize:13];
    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button2 setBackgroundColor:[UIColor redColor]];
    button2.layer.borderColor=[UIColor whiteColor].CGColor;
    button2.layer.borderWidth=1.0;
    button2.layer.cornerRadius=14;
    [button2 setClipsToBounds:YES];
    [footerView addSubview:button2];
    [button2 addTarget:self action:@selector(logoutButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableFooterView=footerView;

   
}


-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"Appeared");
    [self updateValues];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     NSLog(@"viewWillAppear");
}

-(void)updateValues{
    if (coachLogin) {
        menuArray=[NSMutableArray arrayWithObjects:@"Goal Consultation Room",@"Edit Profile",@"Change Password",@"My Bookings",@"Availabilty", nil];
        _userTokens.hidden=true;
        _feedbackView.hidden=false;
        _feedbackView.maxRating=5;
        _feedbackView.canEdit=false;
        float f=[[FHDelegate.userInfo.info valueForKey:@"user_rating_average"] floatValue];
        _feedbackView.rating=f;
        iconArray=[NSMutableArray arrayWithObjects:@"navGoalConsultaionRoom",@"navEditProfile",@"changePassword",@"navMyBooking",@"navTrackingProgress", nil];
        
        //_feedbackView.myint=[[FHDelegate.userInfo.info valueForKey:@"user_rating_average"] floatValue];
    }
    else{
        menuArray=[NSMutableArray arrayWithObjects:@"Goal Consultation Room",@"Coaches",@"Buy Tokens",@"My Bookings",@"Tracking Progress",@"Edit Profile",@"Ask Question", nil];
        iconArray=[NSMutableArray arrayWithObjects:@"navGoalConsultaionRoom",@"navCoaches",@"navBuyTokens",@"navMyBooking",@"navTrackingProgress",@"navEditProfile",@"navAskQuestion", nil];
        _userTokens.hidden=false;
        _feedbackView.hidden=true;
    }
    
    _UserName.text=[NSString stringWithFormat:@"%@ %@",[FHDelegate.userInfo.info valueForKey:@"user_first_name"],[FHDelegate.userInfo.info valueForKey:@"user_last_name"]];
    NSLog(@"%@",FHDelegate.userInfo.info);
    _profileImage.backgroundColor=[UIColor lightGrayColor];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^ {
        
        NSString *newImageurl=[FHDelegate.userInfo.info valueForKey:@"user_profile_image_url"];
        //newImageurl=[newImageurl stringByReplacingOccurrencesOfString:@"_small" withString:@""];
        
        NSData* dataim = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:newImageurl]];
        UIImage* image = [UIImage imageWithData:dataim];
        
        dispatch_async(dispatch_get_main_queue(), ^ {
            _profileImage.image=image;
        });
    });
    _userTokens.text=[NSString stringWithFormat:@"%@ Tokens",[FHDelegate.userInfo.info valueForKey:@"user_token_count"]];
    [self.tableView reloadData];
}
#pragma mark - UITableView Delegate & Datasrouce -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return menuArray.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 2)];
	view.backgroundColor = [UIColor whiteColor];
	return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	LeftMenuTableCell *cell = (LeftMenuTableCell*)[tableView dequeueReusableCellWithIdentifier:@"leftMenuCell"];
	
    cell.leftMenuText.text = [menuArray objectAtIndex:indexPath.row];
    cell.iconImage.image= [UIImage imageNamed:[iconArray objectAtIndex:indexPath.row]];
	cell.backgroundColor = [UIColor clearColor];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
															 bundle: nil];
	
	UIViewController *vc ;
	
    if (coachLogin) {
	switch (indexPath.row)
	{
            
        case 0:
			vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"GoalConsultationRoomController"];
			break;
			
		case 1:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"CoachEditProfileController"];
			break;
			
		case 2:
			vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"ChangePasswordController"];
			break;
			
		case 3:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"MyBookingController"];
			break;
        
        case 4:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"CoachAvailabilityController"];
            break;
            
        

	}
	[[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
															 withSlideOutAnimation:self.slideOutAnimationEnabled
																	 andCompletion:nil];
    }
    else{
        switch (indexPath.row)
        {
                
            case 0:
                vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"GoalConsultationRoomController"];
            break;
                
            case 1:
                vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"CoachesViewController"];
                break;
                
            case 2:
                vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"BuyTokensController"];
                break;
                
            case 3:
                vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"MyBookingController"];
                break;
                
            case 4:
                vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"ViewTrackingProgressController"];
                break;
                
            case 5:
                vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"UserEditProfileController"];
                break;
                
            case 6:
                vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"AskQuestionController"];
                break;
                
            
        }
        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
                                                                 withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                         andCompletion:nil];
    }
}

-(void)logoutButtonPressed{
    
    
   
    NSUserDefaults *defualts=[NSUserDefaults standardUserDefaults];
    
    if ([[FHDelegate.userInfo.info valueForKey:@"group_slug"] isEqualToString:@"coach"]) {
        [defualts setValue:@"" forKey:@"logged"];
        FHDelegate.userInfo=nil;
        [defualts removeObjectForKey:@"userinfo"];
        [defualts synchronize];
        [[SlideNavigationController sharedInstance] popToRootViewControllerAnimated:YES];
        [[SlideNavigationController sharedInstance] setViewControllers:@[FHDelegate.firstView] animated:YES];
    }
    else{
        FBSDKLoginManager *logMangaer = [[FBSDKLoginManager alloc] init];
        [logMangaer logOut];
        [[Twitter sharedInstance] logOut];
        [defualts setValue:@"" forKey:@"logged"];
        FHDelegate.userInfo=nil;
        [defualts removeObjectForKey:@"userinfo"];
        [defualts synchronize];
        [[SlideNavigationController sharedInstance] popToRootViewControllerAnimated:YES];
        [[SlideNavigationController sharedInstance] setViewControllers:@[FHDelegate.firstView] animated:YES];
    }
    
}

-(void)downloadButtonPressed{
    [FHDelegate goToFitAndHealthyApp];
}

@end
