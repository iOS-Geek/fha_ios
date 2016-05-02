//
//  TrackingProgressController.h
//  FitHealthy
//
//  Created by MacBook on 27/07/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FHAppDelegate.h"
#import "TrackingCell.h"


@interface TrackingProgressController : UIViewController<SlideNavigationControllerDelegate,TrackingCellProtoCol,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UIAlertViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *trackingProgressTable;

- (IBAction)appLinkButtonPressed:(id)sender;

- (IBAction)uploadPicturePressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

- (IBAction)saveButtonPressed:(id)sender;


@end
