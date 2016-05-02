//
//  BookCoachDateController.h
//  FitHealthy
//
//  Created by MacBook on 15/08/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKCalendarView.h"
#import "FHAppDelegate.h"



@protocol CoachBookingDateDelegate
- (void)setDate:(NSDate*)selectedDate availableId:(NSString*)availableId;

@end

@interface BookCoachDateController : UIViewController<CKCalendarDelegate>

@property() id<CoachBookingDateDelegate>dateBookingDelegate;
@property(nonatomic,strong) NSArray *PreSelectedDates;
@property(nonatomic)NSMutableArray *AvailablityArray;
@end
