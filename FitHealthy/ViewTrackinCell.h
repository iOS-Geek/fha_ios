//
//  ViewTrackinCell.h
//  FitHealthy
//
//  Created by MacBook on 06/08/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewTrackinCell : UITableViewCell



@property (weak, nonatomic) IBOutlet UIImageView *profileImage;

@property (weak, nonatomic) IBOutlet UILabel *trackingDate;


@property (weak, nonatomic) IBOutlet UILabel *weightText;
@property (weak, nonatomic) IBOutlet UILabel *BMI;

@property (weak, nonatomic) IBOutlet UILabel *bodyFat;

@end
