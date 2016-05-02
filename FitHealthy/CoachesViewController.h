//
//  CoachesViewController.h
//  FitHealthy
//
//  Created by MacBook on 26/07/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FHAppDelegate.h"
#import "CoachesTableCell.h"

@interface CoachesViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,SlideNavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *coachesSearchBar;

@property (weak, nonatomic) IBOutlet UITableView *coachesTableView;





@end
