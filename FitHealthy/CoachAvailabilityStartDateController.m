//
//  CoachAvailabilityStartDateController.m
//  FitHealthy
//
//  Created by MacBook on 15/08/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import "CoachAvailabilityStartDateController.h"

@interface CoachAvailabilityStartDateController ()


@property (weak, nonatomic) IBOutlet CKCalendarView *calenderView;
@property (weak, nonatomic) IBOutlet UILabel *selectedDate;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property(nonatomic, strong) NSDateFormatter *dateFormatter;
@property(nonatomic, strong) NSDate *minimumDate;
@property(nonatomic, strong) NSArray *disabledDates;


@property (weak, nonatomic) IBOutlet UIView *timeBackgroundView;

@end

@implementation CoachAvailabilityStartDateController

- (void)viewDidLoad {
    [super viewDidLoad];
    _calenderView.delegate=self;
    _calenderView.coachBooking=YES;
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"dd/MM/yyyy"];
    
    self.minimumDate = [self.dateFormatter dateFromString:@"20/09/2012"];
    
    
    self.dateFormatter.dateStyle=NSDateFormatterMediumStyle;
    
    self.dateFormatter.dateStyle=NSDateFormatterMediumStyle;
    self.dateFormatter.timeStyle=kCFDateFormatterShortStyle;
    _calenderView.onlyShowCurrentMonth = NO;
    _calenderView.adaptHeightToNumberOfWeeksInMonth = YES;
    
    NSDate *now=[NSDate date];
    
    
    //self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(localeDidChange) name:NSCurrentLocaleDidChangeNotification object:nil];
    
    
    _selectedDate.text=[self.dateFormatter stringFromDate:now];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButton)];
    
    self.datePicker.minuteInterval = 1;
    
    [self.datePicker addTarget:self action:@selector(updateDatePickerLabel) forControlEvents:UIControlEventValueChanged];
    
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
    
    
}

- (BOOL)calendar:(CKCalendarView *)calendar willSelectDate:(NSDate *)date {
    return ![self dateIsDisabled:date];
}

- (void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date {
    
    if (!date) {
        _selectedDate.text = [self.dateFormatter stringFromDate:[NSDate date]];
    }
    else{
    _selectedDate.text = [self.dateFormatter stringFromDate:date];
        
        _datePicker.date=date;
    }
    
    [self updateNavigationButtons];
    
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

-(void)updateNavigationButtons{
    self.navigationItem.rightBarButtonItem= [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButton)];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.calenderView.alpha=0.5;
    } completion:^(BOOL finished) {
        self.calenderView.hidden=true;
        self.timeBackgroundView.hidden=false;
        
    }];
    
}


-(void)doneButton{
    if (_startDate) {
        FHDelegate.startDate=_datePicker.date;
    }
    else{
        FHDelegate.endDate=_datePicker.date;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)cancelButton{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Actions

- (void)updateDatePickerLabel {
    _selectedDate.text = [self.dateFormatter stringFromDate:self.datePicker.date];
}

@end
