//
//  CoachAvailabilityStartDateController.h
//  FitHealthy
//
//  Created by MacBook on 15/08/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKCalendarView.h"
#import "FHAppDelegate.h"

@interface CoachAvailabilityStartDateController : UIViewController<CKCalendarDelegate>

@property(nonatomic,assign) BOOL startDate;
@end
