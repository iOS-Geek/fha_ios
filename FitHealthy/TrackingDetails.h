//
//  TrackingDetails.h
//  FitHealthy
//
//  Created by MacBook on 03/08/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FHAppDelegate.h"

@interface TrackingDetails : NSObject

@property (nonatomic) NSString *trackingId;
@property (nonatomic) NSString *trackingText;
@property (nonatomic)  NSString *topicText;
@property (nonatomic)  NSString *placeHolderText;
@property (nonatomic) CGFloat rowHeight;

@property (nonatomic) NSString *trackingDate;
@property (nonatomic) NSString *trackingWeight;
@property (nonatomic)  NSString *BMI;
@property (nonatomic)  NSString *bodyFat;
@property (nonatomic) UIImage *profileImage;
@property (nonatomic) NSString *profileImageUrl;
@property (nonatomic) NSMutableDictionary *trackingDict;

@end
