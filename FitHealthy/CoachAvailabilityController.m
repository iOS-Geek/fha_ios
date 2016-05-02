//
//  CoachAvailabilityController.m
//  FitHealthy
//
//  Created by MacBook on 14/08/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import "CoachAvailabilityController.h"

@interface CoachAvailabilityController ()<VSDropdownDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIGestureRecognizerDelegate>{
    
    NSDateFormatter *dateFormatter;
    NSMutableArray *topicArray;
    NSMutableArray *filteredTopicArray;
}

@property (weak, nonatomic) IBOutlet UITableView *autocompleteTableView;

@property (nonatomic,retain)NSDate *startDate,*endDate;
@end



@implementation CoachAvailabilityController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"Availability";
    pickerOneData =[NSMutableArray arrayWithObjects:@"1-2-1 Video Coaching",@"Group Video Coaching", nil];
    pickerTwoData =[NSMutableArray arrayWithObjects:@"20 Minutes",@"30 Minutes",@"40 Minutes",@"50 Minutes",@"60 Minutes", nil];
    vsDropDown = [[VSDropdown alloc]initWithDelegate:self];
    [vsDropDown setAdoptParentTheme:YES];
    [vsDropDown setShouldSortItems:YES];
    vsDropDown.shouldSortItems=false;
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    dateFormatter = [[NSDateFormatter alloc] init];
    
    
    
    
    
    
    dateFormatter.dateStyle=NSDateFormatterMediumStyle;
    dateFormatter.timeStyle=kCFDateFormatterShortStyle;
    
    _startTextfield.text=[dateFormatter stringFromDate:_startDate];
    _endTextfield.text=[dateFormatter stringFromDate:_endDate];
    
    UITapGestureRecognizer *gesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeKeyBoard)];
    
    
    [self.view addGestureRecognizer:gesture];
    gesture.delegate=self;
    FHDelegate.startDate=nil;
    FHDelegate.endDate=nil;
    
    topicArray=[NSMutableArray array];
    [RequestManager getFromServer:@"topics" parameters:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"now",@"current_timestamp", nil] completionHandler:^(NSMutableDictionary *responseDict) {
        if ([[responseDict valueForKey:@"code"] isEqualToString:@"1"]) {
            NSArray *array=[responseDict valueForKey:@"data"];
            if (array.count) {
                for(NSDictionary *dict in array){
                    [topicArray addObject:[dict valueForKey:@"topic_name"]];
                }
                filteredTopicArray = [NSMutableArray arrayWithCapacity:[topicArray count]];
            }
            
        }
    }];
    
    _autocompleteTableView.hidden=true;
    _autocompleteTableView.layer.borderColor=[UIColor FHThemeColor].CGColor;
    _autocompleteTableView.layer.borderWidth=1.0;
    
    _gmtMessage.text=[[FHDelegate.userInfo.info valueForKey:@"configurations"]valueForKey:@"gmt_message"];
    // Do any additional setup after loading the view.
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    _startTextfield.text=[dateFormatter stringFromDate:FHDelegate.startDate];
    self.startDate=FHDelegate.startDate;
    
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

-(void)removeKeyBoard{
    [_topictextfield resignFirstResponder];
    _autocompleteTableView.hidden=true;
}

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return NO;
}



- (IBAction)typeButtonPressed:(id)sender {
    [_topictextfield resignFirstResponder];
    [self showDropDownForButton:_typeTextfield adContents:pickerOneData multipleSelection:false];
}
- (IBAction)updateButtonPressed:(id)sender {
     [_topictextfield resignFirstResponder];
    if (!_startDate || _endTextfield.text.length==0 || _typeTextfield.text.length==0 || _topictextfield.text==0 ) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Warning !!!" message:@"Please fill all the fields" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    else{
        
        NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
       
        NSString *startDate=[formatter stringFromDate:_startDate];
         NSLog(@"converted %@",[formatter stringFromDate:_startDate]);
        
        NSString *endDate=[formatter stringFromDate:_endDate];
        NSLog(@"converted %@",[formatter stringFromDate:_endDate]);
        
         NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithObjectsAndKeys:[FHDelegate.userInfo.info valueForKey:@"user_security_hash"],@"user_security_hash",[FHDelegate.userInfo.info valueForKey:@"user_id"],@"user_id",nil];
        
        NSString *availablityType=@"";
        
        if ([_typeTextfield.text isEqualToString:@"1-2-1 Video Coaching"]) {
            availablityType=@"2";
        }
        else{
            availablityType=@"3";
        }
        
        
        [dict setValue:availablityType forKey:@"availability_for"];
        [dict setValue:_topictextfield.text forKey:@"topic_name"];
        [dict setValue:startDate forKey:@"availability_from"];
        [dict setValue:[_endTextfield.text stringByReplacingOccurrencesOfString:@" Minutes" withString:@""] forKey:@"availability_length"];
        
        
        [RequestManager getFromServer:@"add_coach_availability" parameters:dict completionHandler:^(NSMutableDictionary *responseDict) {
            if ([[responseDict valueForKey:@"code"] isEqualToString:@"1"]) {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Success !!!" message:[responseDict valueForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [alert show];
                
                _typeTextfield.text=@"";
                _topictextfield.text=@"";
                _startTextfield.text=@"";
                _endTextfield.text=@"";
            }
            else{
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error !!!" message:[responseDict valueForKey:@"message"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [alert show];
            }
        }];
        
        
    }
}

- (IBAction)startButtonPressed:(id)sender {
    
    
    [_topictextfield resignFirstResponder];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    
    CoachAvailabilityStartDateController *vc ;
    vc = (CoachAvailabilityStartDateController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"CoachAvailabilityStartDateController"];
    vc.startDate=YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)endButtonPressed:(id)sender {
    [_topictextfield resignFirstResponder];
   [self showDropDownForButton:_endTextfield adContents:pickerTwoData multipleSelection:false];
}


#pragma  mark DropDown methods
-(void)showDropDownForButton:(UITextField* )sender adContents:(NSArray *)contents multipleSelection:(BOOL)multipleSelection
{
    [vsDropDown setDrodownAnimation:rand()%2];
    
    [vsDropDown setAllowMultipleSelection:multipleSelection];
    
    [vsDropDown setupDropdownForView:sender];
    
    [vsDropDown setSeparatorColor:[UIColor lightGrayColor]];
    
    if (vsDropDown.allowMultipleSelection)
    {
        [vsDropDown reloadDropdownWithContents:contents andSelectedItems:@[sender.text]];
        
    }
    else
    {
        [vsDropDown reloadDropdownWithContents:contents andSelectedItems:@[sender.text]];
        
    }
    
    
    
}


- (void)dropdown:(VSDropdown *)dropDown didSelectValue:(NSString *)str atIndex:(NSUInteger)index
{
    if ([dropDown.dropDownView isKindOfClass:[UITextField class]])
    {
        //UIButton *btn = (UIButton *)dropDown.dropDownView;
        // [btn setTitle:str forState:UIControlStateNormal];
        //if (btn.tag==1) {
        // monthField.text=[pickerOneData objectAtIndex:index];
        //}else if(btn.tag==2){
        //     yearField.text=[pickerTwoData objectAtIndex:index];
        //}
        
        
    }
    
}

- (void)dropdown:(VSDropdown *)dropDown didChangeSelectionForValue:(NSString *)str atIndex:(NSUInteger)index selected:(BOOL)selected
{
    
    
    UITextField *textField = (UITextField *)dropDown.dropDownView;
    if (textField.tag==0) {
        _typeTextfield.text=[pickerOneData objectAtIndex:index];
    }else if(textField.tag==1){
        _endTextfield.text=[pickerTwoData objectAtIndex:index];
    }
    
    NSLog(@"%@",vsDropDown.selectedItems);
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
    return 0.0;
}



#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return filteredTopicArray.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 33;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CoachAvailabilityTopicCell";
    
        NSString *text=[filteredTopicArray objectAtIndex:indexPath.row];
        CoachAvailabilityTopicCell *cell = (CoachAvailabilityTopicCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[CoachAvailabilityTopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        cell.textValue.text=text;
               return cell;
    
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
     NSString *text=[filteredTopicArray objectAtIndex:indexPath.row];
    _topictextfield.text=text;
    [_topictextfield resignFirstResponder];
    tableView.hidden=true;
    // SearchResults *result=[SearchResultsArray objectAtIndex:indexPath.row];
    //[self callSelectionWebService:result.post_id];
    
}


- (void)filterContentForSearchText:(NSString*)typedText
{
    [filteredTopicArray removeAllObjects];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self CONTAINS [cd] %@",typedText];
    NSArray *tempArray = [topicArray filteredArrayUsingPredicate:predicate];
    filteredTopicArray = [NSMutableArray arrayWithArray:tempArray];
    NSLog(@"filetest=%@",filteredTopicArray);
    if (filteredTopicArray.count) {
        _autocompleteTableView.hidden=false;
        if (filteredTopicArray.count==1) {
            _tableHieghtConstraint.constant=33;
        }
        else if (filteredTopicArray.count==2){
            _tableHieghtConstraint.constant=66;
        }
        else{
            _tableHieghtConstraint.constant=99;
        }
        [_autocompleteTableView setNeedsUpdateConstraints];
        [_autocompleteTableView reloadData];
    }
    else{
         _autocompleteTableView.hidden=true;
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
    _autocompleteTableView.hidden=true;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [vsDropDown remove];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    _autocompleteTableView.hidden=true;
    return YES;
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == _topictextfield) {
        
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        NSLog(@"search=%@",newString);
        if (newString.length>0) {
            [self filterContentForSearchText:newString];
        }
        else{
            _autocompleteTableView.hidden=true;
        }
        
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
 
    return  !(touch.view.superview.superview.superview == _autocompleteTableView);
}

@end
