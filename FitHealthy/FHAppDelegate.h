//
//  FHAppDelegate.h
//  FitHealthy
//
//  Created by MacBook on 18/07/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

//#define BaseUrl @"http://192.168.0.7/blendedd_web/api/"
#define BaseUrl @"http://fandh.co/app/api/"
#define FHDelegate ((FHAppDelegate *)[[UIApplication sharedApplication] delegate])

#define typeOne @"com.fitandhealthyclinic.fithealthy.PAYG_120"
#define typeTwo @"com.fitandhealthyclinic.fithealthy.PAYG_240"
#define typeThree @"com.fitandhealthyclinic.fithealthy.PAYG_480"

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "RequestManager.h"
#import "MBProgressHUD.h"
#import "FirstViewController.h"
#import "UIColor+FHColor.h"
#import "UIFont+FHFont.h"
#import "SlideNavigationController.h"
#import "LeftMenuViewController.h"
#import "RightMenuViewController.h"
#import "CoachLoginViewController.h"
#import "CoachForgotPasswordController.h"
#import "UserInfo.h"
#import "GoalConsultationRoomController.h"
#import "CoachesViewController.h"
#import "BuyTokensController.h"
#import "QuestionsList.h"
#import "IconDownloader.h"
#import "SVPullToRefresh.h"
#import "Coaches.h"
#import "CoachImageDownloder.h"
#import "AskQuestionController.h"
#import "MyBookingController.h"
#import "EditProfileController.h"
#import "TrackingProgressController.h"
#import "BuyTokensController.h"
#import "QuestionAnswerController.h"
#import "GoalRoomTableCell.h"
#import "AnswerTableCell.h"
#import "THChatInput.h"
#import "ChangePasswordController.h"
#import "UserEditProfileController.h"
#import "UIImage+fixOrientation.h"
#import "ViewTrackingProgressController.h"
#import "TrackingDetails.h"
#import "TrackingCell.h"
#import "TrackingDownload.h"
#import "TrackingProgressDetailsController.h"
#import "ASStarRatingView.h"
#import "SingleCoachController.h"
#import "RageIAPHelper.h"
#import "CoachAvailabilityController.h"
#import "CoachAvailabilityStartDateController.h"
#import "CoachAvailabilityTopicCell.h"
#import "CoachBookingController.h"
#import "BookCoachDateController.h"
#import "MyBookingCell.h"
#import "MyBookingImageDownloader.h"
#import "InitialViewController.h"
#import "TermsViewController.h"
#import "SurveyViewController.h"
//#import <Fabric/Fabric.h>
//#import <Crashlytics/Crashlytics.h>
#import <TwitterKit/TwitterKit.h>
#import <ooVooSDK/ooVooSDK.h>
#import "FileLogger.h"
#import "LogInVC.h"

#import "UserDefaults.h"
#import "SettingBundle.h"
#define User_isInVideoView @"User_isInVideoView"



#define APP_TOKEN_SETTINGS_KEY    @"MDAxMDAxAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACicrMR%2FSiLH1peUsPW%2BMgncJhfUhwRqcoiBhwd7CxkJzHE0xKjsffVXQMvbDmcZ9VpP4BGQTnL2aHVnjwnnMPdX4Yr8CrHCXKWupGzXHPhOBMjoE8qYVqgWdZAuVYWGFA%3D"

#define LOG_LEVEL_SETTINGS_KEY    @"12349983354331"

@class FirstViewController;
@class LeftMenuViewController;
@class SlideNavigationController;
@class UserInfo;

@interface FHAppDelegate : UIResponder <UIApplicationDelegate,MBProgressHUDDelegate>{
    MBProgressHUD *HUD,*configureHUD;
}

@property (strong, nonatomic) UIWindow *window;
//@property(strong,nonatomic ) UINavigationController *navController;
@property(strong,nonatomic ) FirstViewController *firstView;
@property(strong,nonatomic ) LeftMenuViewController *leftView;
@property(retain,nonatomic ) UserInfo *userInfo;
@property(assign,nonatomic )BOOL logged;
@property(assign,nonatomic )BOOL isFetchedProducts,isSessionLogged;
@property (nonatomic,retain) NSDate *startDate,*endDate;
@property (nonatomic)NSMutableDictionary *productDict;
@property(nonatomic)int requestCount;

-(void)show_LoadingIndicator;
-(void)hide_LoadingIndicator;
-(void)show_LoadingIndicatorConfigure;
-(void)hide_LoadingIndicatorConfigure;
- (void)saveCustomObject:(UserInfo *)object key:(NSString *)key;
- (UserInfo *)loadCustomObjectWithKey:(NSString *)key;
-(void)goToFitAndHealthyApp;
@end

