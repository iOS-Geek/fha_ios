//
//  AnswerTableCell.m
//  FitHealthy
//
//  Created by MacBook on 28/07/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import "AnswerTableCell.h"

@implementation AnswerTableCell
@synthesize question;
- (void)awakeFromNib {
    // Initialization code
    _FeebackView.canEdit=false;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (IBAction)talkButtonPressed:(id)sender {
    
    [_delegate ButtonPressed:question];
}
@end
