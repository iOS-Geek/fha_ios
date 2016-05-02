//
//  MyBookingImageDownloader.h
//  FitHealthy
//
//  Created by MacBook on 16/08/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyBookingImageDownloader : NSObject

@property (nonatomic, strong)NSMutableDictionary *dict;
@property (nonatomic, copy) void (^completionHandler)(void);

- (void)startDownload;
- (void)cancelDownload;

@end
