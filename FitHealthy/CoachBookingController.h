//
//  CoachBookingController.h
//  FitHealthy
//
//  Created by MacBook on 15/08/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FHAppDelegate.h"
#import "BookCoachDateController.h"



@interface CoachBookingController : UIViewController


@property(nonatomic,retain)Coaches *coach;
@property(nonatomic,retain)NSMutableDictionary *dataDict;
@end
