//
//  CoachImageDownloder.h
//  FitHealthy
//
//  Created by MacBook on 27/07/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "FHAppDelegate.h"
@class Coaches;
@interface CoachImageDownloder : NSObject

@property (nonatomic, strong) Coaches *coach;
@property (nonatomic, copy) void (^completionHandler)(void);

- (void)startDownload;
- (void)cancelDownload;

@end
