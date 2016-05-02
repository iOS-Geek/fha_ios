//
//  QuestionsList.h
//  FitHealthy
//
//  Created by MacBook on 26/07/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class Coaches;

@interface QuestionsList : NSObject

@property (nonatomic) NSString *qId;
@property (nonatomic) NSString *topic;
@property (nonatomic) NSString *value;
@property (nonatomic) NSString *answersCount_time,*answerCount;
@property (nonatomic) UIImage *userImage;
@property (nonatomic) NSString *imageUrl;
@property (nonatomic) NSString *feedbackAverage;
@property (nonatomic) NSString *feedbackCount;
@property(nonatomic,retain) Coaches *coach;
@property(nonatomic) float rowHeight;
@end
