//
//  GoalConsultationRoomController.h
//  FitHealthy
//
//  Created by MacBook on 26/07/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FHAppDelegate.h"
#import "GoalRoomTableCell.h"

@interface GoalConsultationRoomController : UIViewController<SlideNavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate>




@property (weak, nonatomic) IBOutlet UITableView *goalTable;


@property (weak, nonatomic) IBOutlet UISearchBar *goalSearchBar;
@property (nonatomic, strong) NSMutableDictionary *imageDownloadsInProgress;





@end
