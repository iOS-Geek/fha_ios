//
//  FeedBackView.h
//  FitHealthy
//
//  Created by MacBook on 23/08/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FHAppDelegate.h"

@class ASStarRatingView;

@protocol ratingDelegate <NSObject>

-(void)okPressed:(int)rating;
-(void)cancelPressed:(id)sender;

@end
@interface FeedBackView : UIViewController


@property(nonatomic)NSString *ratingMessage;


@property (weak, nonatomic) IBOutlet UILabel *rateMessage;


- (IBAction)cancelButtonPressed:(id)sender;

- (IBAction)okButtonPressed:(id)sender;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rateMessageHeightConstraint;
@property (weak, nonatomic) IBOutlet ASStarRatingView *ratingV;
@property(nonatomic)id<ratingDelegate>ratingDelegate;



@end
