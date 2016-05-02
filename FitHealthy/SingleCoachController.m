//
//  SingleCoachController.m
//  FitHealthy
//
//  Created by MacBook on 08/08/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import "SingleCoachController.h"
#import "Coaches.h"
#import "ASStarRatingView.h"
@interface SingleCoachController ()

@end

@implementation SingleCoachController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^ {
        
        
        NSString *newImageurl=_coach.coachImageUrl;
        //newImageurl=[newImageurl stringByReplacingOccurrencesOfString:@"_small" withString:@""];
        NSData* dataim = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:newImageurl]];
        UIImage* image = [UIImage imageWithData:dataim];
        
        dispatch_async(dispatch_get_main_queue(), ^ {
           
            _coachImage.image=image;
            _coach.coachImage=image;
        });
    });
    
    _CoachNameLabel.text=_coach.coachName;
    _coachDescriptionLabel.text=_coach.coachDesc;
    _feedBackCount.text=_coach.user_rating_count;
    _FeedBackView.rating=[_coach.user_rating_average floatValue];
    _FeedBackView.canEdit=false;
    
    self.title=_coach.coachName;
    
    
    CGSize maximumLabelSize = CGSizeMake(_coachDescriptionLabel.frame.size.width, 9999); // this width will be as per your requirement
    
    CGSize expectedSize = [_coachDescriptionLabel sizeThatFits:maximumLabelSize];
    
    if (expectedSize.height>162) {
        _descLabelHeight.constant=162;
    }
    else{
        _descLabelHeight.constant=expectedSize.height;
    }
   
    
    _firstLabel.text=[NSString stringWithFormat:@"1-2-1 Coaching \n %@ Tokens/min",[[FHDelegate.userInfo.info valueForKey:@"configurations"]valueForKey:@"one_to_one_coaching"]];
     _thirdLabel.text=[NSString stringWithFormat:@"Group Coaching \n %@ Tokens/min",[[FHDelegate.userInfo.info valueForKey:@"configurations"]valueForKey:@"group_coaching"]];
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

- (IBAction)firstButtonPressed:(id)sender {
    
     NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithObjectsAndKeys:[FHDelegate.userInfo.info valueForKey:@"user_security_hash"],@"user_security_hash",[FHDelegate.userInfo.info valueForKey:@"user_id"],@"user_id",nil];
    [dict setValue:_coach.coachId forKey:@"users_id"];
    [dict setValue:@"2" forKey:@"availability_for"];
    
    NSLog(@"%@",dict);
    [RequestManager getFromServer:@"get_coach_availabilities" parameters:dict completionHandler:^(NSMutableDictionary *responseDict) {
       if ([[responseDict valueForKey:@"code"] isEqualToString:@"1"]) {
           NSLog(@"%@",responseDict);
           
           
           
           UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                                    bundle: nil];
           
           CoachBookingController *vc ;
           vc = (CoachBookingController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"CoachBookingController"];
           vc.coach=_coach;
           vc.dataDict=[responseDict valueForKey:@"data"];
           [self.navigationController pushViewController:vc animated:YES];
       }
       else if ([[responseDict valueForKey:@"code"] isEqualToString:@"0"]){
           UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:[responseDict valueForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
           [alert show];
       }
    }];
    
}

- (IBAction)secondButtonPressed:(id)sender {
    
}
- (IBAction)thirdButtonPressed:(id)sender {
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithObjectsAndKeys:[FHDelegate.userInfo.info valueForKey:@"user_security_hash"],@"user_security_hash",[FHDelegate.userInfo.info valueForKey:@"user_id"],@"user_id",nil];
    [dict setValue:_coach.coachId forKey:@"users_id"];
    [dict setValue:@"3" forKey:@"availability_for"];
    [RequestManager getFromServer:@"get_coach_availabilities" parameters:dict completionHandler:^(NSMutableDictionary *responseDict) {
        if ([[responseDict valueForKey:@"code"] isEqualToString:@"1"]) {
            NSLog(@"%@",responseDict);
            
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                                     bundle: nil];
            
            CoachBookingController *vc ;
            vc = (CoachBookingController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"CoachBookingController"];
            vc.coach=_coach;
            vc.dataDict=[responseDict valueForKey:@"data"];
            [self.navigationController pushViewController:vc animated:YES];

        }
        else if ([[responseDict valueForKey:@"code"] isEqualToString:@"0"]){
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:[responseDict valueForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
        }
    }];
}
@end
