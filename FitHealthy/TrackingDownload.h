//
//  TrackingDownload.h
//  FitHealthy
//
//  Created by MacBook on 06/08/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FHAppDelegate.h"
@class TrackingDetails;
@interface TrackingDownload : NSObject



@property (nonatomic, strong) TrackingDetails *details;
@property (nonatomic, copy) void (^completionHandler)(void);

- (void)startDownload;
- (void)cancelDownload;

@end