//
//  TestTableViewCell.h
//  FitHealthy
//
//  Created by MacBook on 01/08/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TestTableViewCell : UITableViewCell

@property(assign)float values;

@property (weak, nonatomic) IBOutlet UILabel *labl;
@property (weak, nonatomic) IBOutlet UILabel *tLabel;

-(void)setChangeValue;
@end
