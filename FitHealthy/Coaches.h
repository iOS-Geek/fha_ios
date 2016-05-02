//
//  Coaches.h
//  FitHealthy
//
//  Created by MacBook on 27/07/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Coaches : NSObject


@property (nonatomic) NSString *coachName;
@property(nonatomic) NSString *coachId;
@property (nonatomic) NSString *coachDesc;
@property (nonatomic) UIImage *coachImage;
@property (nonatomic) NSString *coachImageUrl;
@property (nonatomic) NSString *user_rating_average;
@property (nonatomic) NSString *user_rating_count;
@property(nonatomic) float rowHeight;
@end
