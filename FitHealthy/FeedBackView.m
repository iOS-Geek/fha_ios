//
//  FeedBackView.m
//  FitHealthy
//
//  Created by MacBook on 23/08/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import "FeedBackView.h"

@interface FeedBackView ()

@end

@implementation FeedBackView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _rateMessage.text=[[FHDelegate.userInfo.info valueForKey:@"configurations"]
                           valueForKey:@"rate_message"];
    
    
    
    CGSize maximumLabelSize = CGSizeMake(_rateMessage.frame.size.width, 9999); // this width will be as per your requirement
    
    CGSize expectedSize = [_rateMessage sizeThatFits:maximumLabelSize];
    
    _rateMessageHeightConstraint.constant=expectedSize.height;
    if (expectedSize.height>64) {
        _rateMessageHeightConstraint.constant=64;
    }
    else if (expectedSize.height<25){
        _rateMessageHeightConstraint.constant=25;
    }

    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancelButtonPressed:(id)sender {
    if ([_ratingDelegate respondsToSelector:@selector(cancelPressed:)]) {
        [_ratingDelegate cancelPressed:sender];
    }
}


- (IBAction)okButtonPressed:(id)sender {
    if ([_ratingDelegate respondsToSelector:@selector(okPressed:)]) {
        [_ratingDelegate okPressed:(int)_ratingV.rating];
    }
}
@end
