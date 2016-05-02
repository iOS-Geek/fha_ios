//
//  CoachBookingController.m
//  FitHealthy
//
//  Created by MacBook on 15/08/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import "CoachBookingController.h"
#import "VSDropdown.h"
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface CoachBookingController ()<VSDropdownDelegate,CoachBookingDateDelegate,UIAlertViewDelegate>{
    NSMutableArray *pickerOneData;
    NSMutableArray *pickerTwoData;

    VSDropdown * vdropDown;
    NSMutableArray *preSelectedDates;
    NSMutableArray *AvailabilityIdArray;
    NSString *availId;
    
}

@property (weak, nonatomic) IBOutlet UILabel *coachName;
@property (weak, nonatomic) IBOutlet UIImageView *coachImage;

@property (weak, nonatomic) IBOutlet UILabel *coachDesc;

@property (weak, nonatomic) IBOutlet UIView *coachHeaderView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *coachHeightConstraint;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descHeightCotraint;

@property (weak, nonatomic) IBOutlet UITextField *topicTextfield;


- (IBAction)topicButton:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *bookingTextField;
- (IBAction)bookingButtonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *timeTextField;

- (IBAction)timeButtonPressed:(id)sender;


- (IBAction)continueButtonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewConstraint;


@end



@implementation CoachBookingController

- (void)viewDidLoad {
    [super viewDidLoad];

    _coachImage.image=_coach.coachImage;
    _coachName.text=_coach.coachName;
    _coachDesc.text=_coach.coachDesc;
    
    pickerOneData=[NSMutableArray array];
    pickerTwoData=[NSMutableArray arrayWithObjects:@"20 Minutes",@"30 Minutes",@"40 Minutes",@"50 Minutes",@"60 Minutes", nil];
    
    preSelectedDates=[NSMutableArray array];
    AvailabilityIdArray=[NSMutableArray array];
    
    for(NSDictionary *dict in _dataDict){
        
        if (![pickerOneData containsObject:[dict valueForKey:@"topic_name"]]) {
            [pickerOneData addObject:[dict valueForKey:@"topic_name"]];
        }
        
    }
    
    
    CGSize maximumLabelSize = CGSizeMake(_coachDesc.frame.size.width, 9999); // this width will be as per your requirement
    
    CGSize expectedSize = [_coachDesc sizeThatFits:maximumLabelSize];
    
    _descHeightCotraint.constant=expectedSize.height;
    [_coachDesc setNeedsUpdateConstraints];
    
    if (expectedSize.height>80) {
        _coachHeightConstraint.constant=expectedSize.height+43;
        [_coachHeaderView setNeedsUpdateConstraints];
        _contentViewConstraint.constant=504-110+_coachHeightConstraint.constant;

    }
    
    vdropDown = [[VSDropdown alloc]initWithDelegate:self];
    [vdropDown setAdoptParentTheme:YES];
    [vdropDown setShouldSortItems:YES];
    vdropDown.shouldSortItems=false;
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
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

- (IBAction)topicButton:(id)sender {
     [self showDropDownForButton:_topicTextfield adContents:pickerOneData multipleSelection:false];
}


- (IBAction)bookingButtonPressed:(id)sender {
    
    if (_topicTextfield.text.length==0) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Warning!!!" message:@"Please Choose Topic First." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDateFormatter *formatter2=[[NSDateFormatter alloc]init];
    [formatter2 setDateFormat:@"yyyy-MM-dd hh:mm a"];
    
    //NSString *selectedTime=[formatter stringFromDate:self.datePicker.date];
    [preSelectedDates removeAllObjects];
    [AvailabilityIdArray removeAllObjects];
    NSMutableArray *availabilityStringArray =[NSMutableArray array];
      for(NSDictionary *dict in _dataDict){
          
          if ([[dict valueForKey:@"topic_name"] isEqualToString:_topicTextfield.text]) {
              NSDate *date=[formatter dateFromString:[dict valueForKey:@"availability_from"]];
              [preSelectedDates addObject:date];
              [AvailabilityIdArray addObject:dict];
          }
      }
    
    
    
    
    NSString *finalString=[availabilityStringArray componentsJoinedByString:@"\n"];
    
    
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    
    BookCoachDateController *vc ;
    vc = (BookCoachDateController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"BookCoachDateController"];
    vc.PreSelectedDates=preSelectedDates;
    vc.AvailablityArray=AvailabilityIdArray;
    vc.dateBookingDelegate=self;
    
    //vc.dataDict=[responseDict valueForKey:@"data"];
    [self.navigationController pushViewController:vc animated:YES];
}



- (IBAction)timeButtonPressed:(id)sender {
     [self showDropDownForButton:_timeTextField adContents:pickerTwoData multipleSelection:false];
}



- (IBAction)continueButtonPressed:(id)sender {
    if (_topicTextfield.text.length==0 || _bookingTextField.text.length==0 || _timeTextField.text.length==0) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Warning !!!" message:@"Please fill all the fields" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    else{
        
        NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithObjectsAndKeys:[FHDelegate.userInfo.info valueForKey:@"user_security_hash"],@"user_security_hash",[FHDelegate.userInfo.info valueForKey:@"user_id"],@"user_id",nil];

        
        
        [dict setValue:availId forKey:@"availabilities_id"];
        [dict setValue:[_timeTextField.text stringByReplacingOccurrencesOfString:@" Minutes" withString:@""] forKey:@"booking_length"];
        [dict setValue:_bookingTextField.text forKey:@"booking_start_time"];
        
        [RequestManager getFromServer:@"book" parameters:dict completionHandler:^(NSMutableDictionary *responseDict) {
            if ([[responseDict valueForKey:@"code"] isEqualToString:@"1"]) {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Success !!!" message:[responseDict valueForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [alert show];
                alert.tag=1;
                
                
                
                NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithDictionary:FHDelegate.userInfo.info];
                
                
                        [dic setValue:[[responseDict valueForKey:@"data"] valueForKey:@"user_token_count"] forKey:@"user_token_count"];
               
                
                FHDelegate.userInfo.info=dic;
                [FHDelegate saveCustomObject:FHDelegate.userInfo key:@"userinfo"];
                
                LeftMenuViewController*left=(LeftMenuViewController*) [SlideNavigationController sharedInstance].leftMenu;
                [left updateValues];
               
            }
            else{
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error !!!" message:[responseDict valueForKey:@"message"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [alert show];
            }
        }];

        
        
    }
    
}




-(void)showDropDownForButton:(UITextField* )sender adContents:(NSArray *)contents multipleSelection:(BOOL)multipleSelection
{
    [vdropDown setDrodownAnimation:rand()%2];
    
    [vdropDown setAllowMultipleSelection:multipleSelection];
    
    [vdropDown setupDropdownForView:sender];
    
    [vdropDown setSeparatorColor:[UIColor lightGrayColor]];
    
    if (vdropDown.allowMultipleSelection)
    {
        [vdropDown reloadDropdownWithContents:contents andSelectedItems:[sender.text componentsSeparatedByString:@";"]];
        
    }
    else
    {
        [vdropDown reloadDropdownWithContents:contents andSelectedItems:@[sender.text]];
        
    }
    
    
    
}


- (void)dropdown:(VSDropdown *)dropDown didSelectValue:(NSString *)str atIndex:(NSUInteger)index
{
//    if ([dropDown.dropDownView isKindOfClass:[UITextField class]])
//    {
//        UIButton *btn = (UIButton *)dropDown.dropDownView;
//        [btn setTitle:str forState:UIControlStateNormal];
//        if (btn.tag==1) {
//            monthField.text=[pickerOneData objectAtIndex:index];
//        }else if(btn.tag==2){
//            yearField.text=[pickerTwoData objectAtIndex:index];
//        }
//        
//        
//        
//    }
    
}

- (void)dropdown:(VSDropdown *)dropDown didChangeSelectionForValue:(NSString *)str atIndex:(NSUInteger)index selected:(BOOL)selected
{
    UITextField *textField = (UITextField *)dropDown.dropDownView;
    if (textField.tag==1) {
        _topicTextfield.text=[pickerOneData objectAtIndex:index];
    }else if(textField.tag==2){
        _timeTextField.text=[pickerTwoData objectAtIndex:index];
    }
    
}

- (UIColor *)outlineColorForDropdown:(VSDropdown *)dropdown
{
    return [UIColor lightGrayColor];
}

- (CGFloat)outlineWidthForDropdown:(VSDropdown *)dropdown
{
    return 1.0;
}

- (CGFloat)cornerRadiusForDropdown:(VSDropdown *)dropdown
{
    return 5.0;
}

- (CGFloat)offsetForDropdown:(VSDropdown *)dropdown
{
    return 2.0;
}


#pragma mark BookingDate Delegate 
-(void)setDate:(NSDate *)selectedDate availableId:(NSString*)availableId{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    _bookingTextField.text=[formatter stringFromDate:selectedDate];
    availId=availableId;
}


#pragma mark Alertview
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
