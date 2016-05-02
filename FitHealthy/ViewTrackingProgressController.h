//
//  ViewTrackingProgressController.h
//  FitHealthy
//
//  Created by MacBook on 03/08/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FHAppDelegate.h"

@interface ViewTrackingProgressController : UIViewController<SlideNavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *viewTrackingTable;
@property (nonatomic, strong) NSMutableDictionary *imageDownloadsInProgress;


@end
