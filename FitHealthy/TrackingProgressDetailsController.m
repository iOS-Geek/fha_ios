//
//  TrackingProgressDetailsController.m
//  FitHealthy
//
//  Created by MacBook on 06/08/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import "TrackingProgressDetailsController.h"
#import "TrackingDetails.h"

@interface TrackingProgressDetailsController (){
    
    __weak IBOutlet UILabel *lable1;
    
    
    
    __weak IBOutlet UILabel *lable2;
    
    __weak IBOutlet UILabel *lable3;
    
    
    __weak IBOutlet UILabel *lable4;
    
    __weak IBOutlet UILabel *lable5;
    
    __weak IBOutlet UILabel *lable6;
    
    
    __weak IBOutlet UILabel *lable7;
    
    
    __weak IBOutlet UILabel *lable8;
    
    
    __weak IBOutlet UILabel *lable9;
    
    __weak IBOutlet UILabel *lable10;
    
    __weak IBOutlet UILabel *lable11;
    
    __weak IBOutlet UILabel *lable12;
    
    __weak IBOutlet UILabel *lable13;
    
    __weak IBOutlet UILabel *lable14;
    
    __weak IBOutlet UILabel *lable15;
    
    __weak IBOutlet UILabel *lable16;
    
    __weak IBOutlet UILabel *lable17;
    
    __weak IBOutlet UILabel *lable18;
    
    __weak IBOutlet UILabel *lable19;
    
    __weak IBOutlet UILabel *lable20;
    
    __weak IBOutlet UILabel *lable21;
    
    __weak IBOutlet UILabel *lable22;
    
    
    __weak IBOutlet UILabel *lable23;
    
    __weak IBOutlet UILabel *lable24;
    
    __weak IBOutlet UILabel *lable25;
    
    __weak IBOutlet UIImageView *profileView;
    
    __weak IBOutlet UILabel *trackingDateLabel;
    
    __weak IBOutlet UIActivityIndicatorView *LoadingImage;
}

@end

@implementation TrackingProgressDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    trackingDateLabel.text= _tdetails.trackingDate;
    
    NSDictionary *dict = _tdetails.trackingDict;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^ {
        
        NSData* dataim = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[dict valueForKey:@"tracking_image_url"]]];
        UIImage* image = [UIImage imageWithData:dataim];
        
        dispatch_async(dispatch_get_main_queue(), ^ {
            [LoadingImage stopAnimating];
            [LoadingImage removeFromSuperview];
            profileView.image=image;
        });
    });
    
    lable1.text=[dict valueForKey:@"weight"];
    lable2.text=[dict valueForKey:@"bmi"];
    lable3.text=[dict valueForKey:@"body_fat"];
    lable4.text=[dict valueForKey:@"calories_consumed"];
    lable5.text=[dict valueForKey:@"calories_burned"];
    lable6.text=[dict valueForKey:@"fat_consumed"];
    lable7.text=[dict valueForKey:@"protein_consumed"];
    lable8.text=[dict valueForKey:@"body_area"];
    lable9.text=[dict valueForKey:@"measurement_difference"];
    lable10.text=[dict valueForKey:@"sports_performance"];
    lable11.text=[dict valueForKey:@"distance_performance"];
    lable12.text=[dict valueForKey:@"time_performance"];
    lable13.text=[dict valueForKey:@"position_performance"];
    lable14.text=[dict valueForKey:@"win_lose_performance"];
    lable15.text=[dict valueForKey:@"training_sessions_performance"];
    lable16.text=[dict valueForKey:@"exercise_performance"];
    lable17.text=[dict valueForKey:@"load_performance"];
    lable18.text=[dict valueForKey:@"average_repetitions_performance"];
    lable19.text=[dict valueForKey:@"average_sets_performance"];
    lable20.text=[dict valueForKey:@"average_pace_performance"];
    lable21.text=[dict valueForKey:@"average_heart_rate_performance"];
    lable22.text=[dict valueForKey:@"average_watts_performance"];
    lable23.text=[dict valueForKey:@"average_cadence"];
    lable24.text=[dict valueForKey:@"recovery_sessions"];
    lable25.text=[dict valueForKey:@"flexibility_sessions"];
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

@end
