//
//  MenuViewController.h
//  SlideMenu
//
//  Created by Aryan Gh on 4/24/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
#import "FHAppDelegate.h"
@class ASStarRatingView;

@interface LeftMenuViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray *menuArray;
    NSMutableArray *iconArray;
}

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, assign) BOOL slideOutAnimationEnabled;
@property (nonatomic, assign) BOOL coachLogin;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;

@property (weak, nonatomic) IBOutlet UILabel *UserName;
@property (weak, nonatomic) IBOutlet ASStarRatingView *feedbackView;

@property (weak, nonatomic) IBOutlet UILabel *userTokens;
-(void)updateValues;
@end
