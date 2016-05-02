//
//  BookCoachDateController.m
//  FitHealthy
//
//  Created by MacBook on 15/08/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import "BookCoachDateController.h"







@interface BookCoachDateController (){
    NSMutableArray *checkAvailablityArray;
}




@property (weak, nonatomic) IBOutlet UIView *calenderBackgroundView;


@property (weak, nonatomic) IBOutlet UIView *timePickerBackgroundView;
@property (weak, nonatomic) IBOutlet CKCalendarView *calenderView;
@property(nonatomic, strong) NSDateFormatter *dateFormatter;
@property(nonatomic, strong) NSDate *minimumDate;
@property(nonatomic, strong) NSArray *disabledDates;


@property (weak, nonatomic) IBOutlet UILabel *selectedDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *AvailableTimeLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *AvailableTimeHeightContraint;
@property (weak, nonatomic) IBOutlet UILabel *changedTimeLabel;


@end






@implementation BookCoachDateController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _calenderView.delegate=self;
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"dd/MM/yyyy"];
    
    
    checkAvailablityArray=[NSMutableArray array];
    self.minimumDate = [self.dateFormatter dateFromString:@"20/09/2012"];
    
    _calenderView.PreselectedArray=_PreSelectedDates;
    self.dateFormatter.dateStyle=NSDateFormatterMediumStyle;
    
    self.dateFormatter.dateStyle=NSDateFormatterMediumStyle;
    self.dateFormatter.timeStyle=kCFDateFormatterShortStyle;
    _calenderView.onlyShowCurrentMonth = NO;
    _calenderView.adaptHeightToNumberOfWeeksInMonth = YES;
    
    
    
    
    
    NSDate *now=[NSDate date];
    
    
    //self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(localeDidChange) name:NSCurrentLocaleDidChangeNotification object:nil];
    
    /*
    _selectedDate.text=[self.dateFormatter stringFromDate:now];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButton)];
    */
    self.datePicker.minuteInterval = 1;
    
    [self.datePicker addTarget:self action:@selector(updateDatePickerLabel) forControlEvents:UIControlEventValueChanged];
    // Do any additional setup after loading the view.
    _timePickerBackgroundView.hidden=true;
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

- (void)localeDidChange {
    [_calenderView setLocale:[NSLocale currentLocale]];
}

- (BOOL)dateIsDisabled:(NSDate *)date {
    for (NSDate *disabledDate in self.disabledDates) {
        if ([disabledDate isEqualToDate:date]) {
            return YES;
        }
    }
    return NO;
}

#pragma mark -
#pragma mark - CKCalendarDelegate

- (void)calendar:(CKCalendarView *)calendar configureDateItem:(CKDateItem *)dateItem forDate:(NSDate *)date {
    // TODO: play with the coloring if we want to...
    if ([self dateIsDisabled:date]) {
        dateItem.backgroundColor = [UIColor redColor];
        dateItem.textColor = [UIColor whiteColor];
    }
    
    for (NSDate *dat in _PreSelectedDates) {
        if ([_calenderView date:dat isSameDayAsDate:date]){
            dateItem.backgroundColor = [UIColor FHThemeColor];
            dateItem.textColor = [UIColor whiteColor];
        }
    }
}

- (BOOL)calendar:(CKCalendarView *)calendar willSelectDate:(NSDate *)date {
    return ![self dateIsDisabled:date];
}

- (void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date {
    
    
        [self.datePicker setDate:date animated:NO];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    
    NSString *selectedDate=[formatter stringFromDate:date];
    NSLog(@"converted %@",[formatter stringFromDate:date]);
    _selectedDateLabel.text=[@"Selected Date:- " stringByAppendingString: selectedDate];
    [self updateNavigationButtons:date];
}

- (BOOL)calendar:(CKCalendarView *)calendar willChangeToMonth:(NSDate *)date {
    if ([date laterDate:self.minimumDate] == date) {
        //_calendar.backgroundColor = [UIColor blueColor];
        return YES;
    } else {
        _calenderView.backgroundColor = [UIColor redColor];
        return NO;
    }
}

- (void)calendar:(CKCalendarView *)calendar didLayoutInRect:(CGRect)frame {
    NSLog(@"calendar layout: %@", NSStringFromCGRect(frame));
}

-(void)updateNavigationButtons:(NSDate*)currentDate{
    self.navigationItem.rightBarButtonItem= [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButton)];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.calenderView.alpha=0.5;
    } completion:^(BOOL finished) {
        self.calenderBackgroundView.hidden=true;
        self.timePickerBackgroundView.hidden=false;
        
        
    }];
    
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDateFormatter *formatter2=[[NSDateFormatter alloc]init];
    [formatter2 setDateFormat:@"hh:mm a"];
    
    //NSString *selectedTime=[formatter stringFromDate:self.datePicker.date];
    NSMutableArray *availabilityStringArray =[NSMutableArray array];
    for(NSDictionary *dict in _AvailablityArray){
        
        
        NSDate *newDate=[formatter dateFromString:[dict valueForKey:@"availability_from"]];
        
        
        if ([_calenderView date:currentDate isSameDayAsDate:newDate]){
            
            NSDate *date=[formatter dateFromString:[dict valueForKey:@"availability_from"]];
            
            NSString *fromString=[formatter2 stringFromDate:date];
            NSString *toString=[formatter2 stringFromDate:[formatter dateFromString:[dict valueForKey:@"availability_to"]]];
            
            NSString *string=[NSString stringWithFormat:@"Available From:- %@ to %@",fromString,toString];
            [availabilityStringArray addObject:string];
            
            NSArray *dateArray=[NSArray arrayWithObjects:date,[formatter dateFromString:[dict valueForKey:@"availability_to"]],[dict valueForKey:@"availability_id"], nil];
            [checkAvailablityArray addObject:dateArray];
        }
        
        }
    
    
    
    NSString *finalString=[availabilityStringArray componentsJoinedByString:@"\n"];
    
     _AvailableTimeLabel.text=finalString;
    CGSize maximumLabelSize = CGSizeMake(_AvailableTimeLabel.frame.size.width, 9999); // this width will be as per your requirement
   
    CGSize expectedSize = [_AvailableTimeLabel sizeThatFits:maximumLabelSize];
    
    _AvailableTimeHeightContraint.constant=expectedSize.height;
    [_AvailableTimeLabel setNeedsUpdateConstraints];
    
}


-(void)doneButton{
    if(_changedTimeLabel.text.length<18){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Warning!!!" message:@"Please choose the time" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        return;
    }
    else{
        
        int count=0;
        
        NSString *availableId=@"";
        NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
         NSDate *pickerdate=[formatter dateFromString:[formatter stringFromDate:self.datePicker.date]];
        
        for (NSArray *firstArray in checkAvailablityArray) {
            
        
            
           
            NSDate *firstDate=[formatter dateFromString:[formatter stringFromDate:[firstArray objectAtIndex:0]]];
            
            
            NSDateComponents *dayComponent = [[NSDateComponents alloc] init] ;
            
            dayComponent.minute = -1;
            
            NSCalendar *theCalendar = [NSCalendar currentCalendar];
            NSDate* firstDateNew = [theCalendar dateByAddingComponents:dayComponent toDate:firstDate options:0];
            
            
            
            NSDate *secondDate=[formatter dateFromString:[formatter stringFromDate:[firstArray objectAtIndex:1]]];
            
            if ([self isDate:pickerdate inRangeFirstDate:firstDateNew lastDate:secondDate]) {
                
                NSLog(@"Available Id=%@",[firstArray objectAtIndex:2]);
                availableId=[firstArray objectAtIndex:2];
                count++;
                break;
            }
        }
        
        if (count==0) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Warning!!!" message:@"Please choose the time Between Available Time      " delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
            return;
        }
        
        [_dateBookingDelegate setDate:pickerdate availableId:availableId];
    [self.navigationController popViewControllerAnimated:YES];
        
    }
}

#pragma mark - Actions

- (void)updateDatePickerLabel {
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"hh:mm a"];
    
    
    NSString *selectedTime=[formatter stringFromDate:self.datePicker.date];
    NSLog(@"converted %@",[formatter stringFromDate:self.datePicker.date]);
    _changedTimeLabel.text = [@"Selected time:-  " stringByAppendingString:selectedTime];
}

- (BOOL)isDate:(NSDate *)date inRangeFirstDate:(NSDate *)firstDate lastDate:(NSDate *)lastDate {
    return [date compare:firstDate] == NSOrderedDescending &&
    [date compare:lastDate]  == NSOrderedAscending;
}


@end
