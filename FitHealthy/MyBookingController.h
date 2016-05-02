//
//  MyBookingController.h
//  FitHealthy
//
//  Created by MacBook on 27/07/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FHAppDelegate.h"

@interface MyBookingController : UIViewController<SlideNavigationControllerDelegate>


@property (weak, nonatomic) IBOutlet UITableView *bookingTableView;
@property (weak, nonatomic) IBOutlet UIImageView *bookingBackImage;

@end
