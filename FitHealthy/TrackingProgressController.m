//
//  TrackingProgressController.m
//  FitHealthy
//
//  Created by MacBook on 27/07/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import "TrackingProgressController.h"

CGSize kBoardSize;
CGFloat keyboardHeight;

@interface TrackingProgressController (){
    NSMutableArray *detailsArray;
    NSMutableArray *placeholderArray;
    NSMutableArray *topicArray;
    BOOL IskeyBoardOn;
    TrackingCell *activeCell;
    UITapGestureRecognizer *tableTap;
    
}


@property(nonatomic,retain) NSString* hieght;
@end

@implementation TrackingProgressController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"Input Weekly Results";
    IskeyBoardOn=false;
    detailsArray =[NSMutableArray array];
    
    topicArray=[NSMutableArray arrayWithObjects:@"Weight in Stones/Kg",@"BMI",@"Body Fat %",@"Total Calories Consumed This Week",@"Total Calories Burned This Week",@"Total Grams of Fat this Week",@"Total Grams of Proteins this Week",@"MeasureMent Changes",@"",@"Performance Improvements",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"Recovery Session",@"", nil];
    
    
    
    placeholderArray=[NSMutableArray arrayWithObjects:@"input weight in stones or Kg",@"input BMI",@"input body fat",@"input Calories",@"input Calories",@"input grams",@"input grams",@"Area of body",@"input measurement difference",@"sport",@"distance",@"time",@"position",@"win/lose",@"number of training sessions",@"excercise performed",@"load achieved in KG",@"average repetitions",@"average sets",@"average pace",@"average heart rate",@"average watts",@"average cadence",@"input number of recovery sessions",@"input number of flexibility sessions", nil];
    NSLog(@"%d %d",topicArray.count,placeholderArray.count);
    
    for (int i=0;i<25;i++){
        TrackingDetails *tDetails=[[TrackingDetails alloc]init];
        tDetails.trackingId=[NSString stringWithFormat:@"%d",i];
        tDetails.trackingText=@"";
        tDetails.topicText=[topicArray objectAtIndex:i];
        tDetails.placeHolderText=[placeholderArray objectAtIndex:i];
        [detailsArray addObject:tDetails];
    };
    
    
    // Do any additional setup after loading the view.
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    //
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)doTap{
    NSLog(@"Button pressed");
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return NO;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return NO;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return detailsArray.count;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     TrackingDetails *tdetails=(TrackingDetails*)[detailsArray objectAtIndex:indexPath.row];
    
    if ([tdetails.topicText isEqualToString:@""]) {
        return 44;
    }
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *celltype=@"TrackingCell";
    
    // Configure the cell...
    
    TrackingCell *cell = (TrackingCell*)[tableView dequeueReusableCellWithIdentifier:celltype];
    
    cell.position=indexPath.row;
    cell.delegate=self;
    
    
    TrackingDetails *tdetails=(TrackingDetails*)[detailsArray objectAtIndex:indexPath.row];
    
    cell.trackDetails=tdetails;
    
    cell.textField.placeholder=tdetails.placeHolderText;
    cell.topicLabel.text=tdetails.topicText;
    
    
    if (indexPath.row == detailsArray.count-1) {
        cell.IsLast=true;
    }
    else{
        cell.IsLast=false;
    }
    cell.textField.text=tdetails.trackingText;
    return cell;
    return  nil;
    
}

-(void)keyboardDidShow:(NSNotification*)aNotification{
    _hieght=[NSString stringWithFormat:@"%f",_trackingProgressTable.frame.size.height];
    NSDictionary* info = [aNotification userInfo];
    kBoardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    NSLog(@"%@",NSStringFromCGSize(kBoardSize));
    
    
    CGRect rect = [[aNotification userInfo][UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect converted = [self.view.window convertRect:rect fromView:nil];
    kBoardSize = converted.size;
    NSLog(@"%@",NSStringFromCGSize(kBoardSize));
    
    
    
    if (!IskeyBoardOn) {
        CGRect frame= self.trackingProgressTable.frame;
        CGRect frameTable= CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
        frameTable.size.height=[_hieght integerValue];
        frameTable.size.height=[_hieght integerValue]- kBoardSize.height;
        self.trackingProgressTable.frame=frameTable;
        keyboardHeight=kBoardSize.height;
        IskeyBoardOn=true;
    }
    else{
        if (kBoardSize.height>keyboardHeight) {
            CGRect frame= self.trackingProgressTable.frame;
            CGRect frameTable= CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
            frameTable.size.height-=kBoardSize.height-keyboardHeight;
            self.trackingProgressTable.frame=frameTable;
            keyboardHeight=kBoardSize.height;
        }
        else{
            CGRect frame= self.trackingProgressTable.frame;
            CGRect frameTable= CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
            frameTable.size.height+= keyboardHeight-kBoardSize.height;
            self.trackingProgressTable.frame=frameTable;
            keyboardHeight=kBoardSize.height;
        }
        
    }
    
    
}

-(void)keyboardDidHide:(NSNotification*)aNotification{
    //  // keyboard is dismissed, restore frame view to its  zero origin
    CGRect frameTable=self.trackingProgressTable.frame;
    frameTable.size.height=self.view.frame.size.height-_trackingProgressTable.frame.origin.y;
    self.trackingProgressTable.frame=frameTable;
    IskeyBoardOn=false;
    NSLog(@"keyboard hidden");
    [self.view setNeedsDisplay];
}

-(void)returnedPosition:(int)position{
    NSLog(@"returned postion=%d",position);
    
    [self performSelector:@selector(dochange:) withObject:[NSString stringWithFormat:@"%d",position] afterDelay:0.0];
}


-(void)dochange:(NSString*)adff{
    
    if ([adff isEqualToString:@"24"]) {
        NSLog(@"descr =%@",detailsArray);
        for (TrackingDetails *testjjj in detailsArray) {
            NSLog(@"each user detaisl =%@  %@",testjjj.trackingId,testjjj.trackingText);
        }
    }
    
    // [self.testTable scrollsToTop];
    if ([adff intValue]!=24) {
        NSIndexPath *indp=[NSIndexPath indexPathForRow:[adff intValue]+1 inSection:0];
        //TestCell *cell=(TestCell*)[self tableView:self.testTable cellForRowAtIndexPath:indp];
        [_trackingProgressTable scrollToRowAtIndexPath:indp atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            TrackingCell *cell=(TrackingCell*) [self.trackingProgressTable cellForRowAtIndexPath:indp];
            
            //[self.testTable selectRowAtIndexPath:indp animated:YES scrollPosition:0];
            //[cell.textField setEnabled:YES];
            [cell.textField becomeFirstResponder];
        });
        
        //[cell cellStatues];
    }
}


-(void)returnScrollRect:(CGRect)rext post:(int)postion{
    
     NSIndexPath *indp=[NSIndexPath indexPathForRow:postion inSection:0];
    
    activeCell=(TrackingCell*) [self.trackingProgressTable cellForRowAtIndexPath:indp];
    
    tableTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tableTapped)];
    
   
    [_trackingProgressTable addGestureRecognizer:tableTap];
}


-(void)tableTapped {
    if (activeCell) {
        [activeCell.textField resignFirstResponder];
        activeCell=nil;
        [_trackingProgressTable removeGestureRecognizer:tableTap];
    }
}

- (IBAction)appLinkButtonPressed:(id)sender {
    [FHDelegate goToFitAndHealthyApp];
}

- (IBAction)uploadPicturePressed:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Choose Image For Tracking"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"Take Photo",@"Choose Existing", nil];
    sheet.tag=1;
    
    [sheet showInView:self.view];
}

- (IBAction)saveButtonPressed:(id)sender {
    
    
    TrackingDetails *tdetails=[detailsArray objectAtIndex:0];
    if ([tdetails.trackingText isEqualToString:@""]) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert !!!" message:@"Please Fill your weight" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    if (!_profileImageView.image) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert !!!" message:@"Please Add your Image" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithObjectsAndKeys:[FHDelegate.userInfo.info valueForKey:@"user_security_hash"],@"user_security_hash",[FHDelegate.userInfo.info valueForKey:@"user_id"],@"user_id", nil];
    
    tdetails=(TrackingDetails*)[detailsArray objectAtIndex:0];
    
    [dict setValue:tdetails.trackingText forKey:@"weight"];
    
    
    tdetails=(TrackingDetails*)[detailsArray objectAtIndex:1];
    [dict setValue:tdetails.trackingText forKey:@"bmi"];
    
    tdetails=(TrackingDetails*)[detailsArray objectAtIndex:2];
    [dict setValue:tdetails.trackingText forKey:@"body_fat"];
    
    tdetails=(TrackingDetails*)[detailsArray objectAtIndex:3];
    [dict setValue:tdetails.trackingText forKey:@"calories_consumed"];
    
    tdetails=(TrackingDetails*)[detailsArray objectAtIndex:4];
    [dict setValue:tdetails.trackingText forKey:@"calories_burned"];
    
    tdetails=(TrackingDetails*)[detailsArray objectAtIndex:5];
    [dict setValue:tdetails.trackingText forKey:@"fat_consumed"];
    
    tdetails=(TrackingDetails*)[detailsArray objectAtIndex:6];
    [dict setValue:tdetails.trackingText forKey:@"protein_consumed"];
    
    tdetails=(TrackingDetails*)[detailsArray objectAtIndex:7];
    [dict setValue:tdetails.trackingText forKey:@"body_area"];
    
    tdetails=(TrackingDetails*)[detailsArray objectAtIndex:8];
    [dict setValue:tdetails.trackingText forKey:@"measurement_difference"];
    
    tdetails=(TrackingDetails*)[detailsArray objectAtIndex:9];
    [dict setValue:tdetails.trackingText forKey:@"sports_performance"];
    
    tdetails=(TrackingDetails*)[detailsArray objectAtIndex:10];
    [dict setValue:tdetails.trackingText forKey:@"distance_performance"];
    
    tdetails=(TrackingDetails*)[detailsArray objectAtIndex:11];
    [dict setValue:tdetails.trackingText forKey:@"time_performance"];
    
    tdetails=(TrackingDetails*)[detailsArray objectAtIndex:12];
    [dict setValue:tdetails.trackingText forKey:@"position_performance"];
    
    tdetails=(TrackingDetails*)[detailsArray objectAtIndex:13];
    [dict setValue:tdetails.trackingText forKey:@"win_lose_performance"];
    
    tdetails=(TrackingDetails*)[detailsArray objectAtIndex:14];
    [dict setValue:tdetails.trackingText forKey:@"training_sessions_performance"];
    
    tdetails=(TrackingDetails*)[detailsArray objectAtIndex:15];
    [dict setValue:tdetails.trackingText forKey:@"exercise_performance"];
    
    tdetails=(TrackingDetails*)[detailsArray objectAtIndex:16];
    [dict setValue:tdetails.trackingText forKey:@"load_performance"];
    
    tdetails=(TrackingDetails*)[detailsArray objectAtIndex:17];
    [dict setValue:tdetails.trackingText forKey:@"average_repetitions_performance"];
    
    tdetails=(TrackingDetails*)[detailsArray objectAtIndex:18];
    [dict setValue:tdetails.trackingText forKey:@"average_sets_performance"];
    
    tdetails=(TrackingDetails*)[detailsArray objectAtIndex:19];
    [dict setValue:tdetails.trackingText forKey:@"average_pace_performance"];
    
    tdetails=(TrackingDetails*)[detailsArray objectAtIndex:20];
    [dict setValue:tdetails.trackingText forKey:@"average_heart_rate_performance"];
    
    tdetails=(TrackingDetails*)[detailsArray objectAtIndex:21];
    [dict setValue:tdetails.trackingText forKey:@"average_watts_performance"];
    
    tdetails=(TrackingDetails*)[detailsArray objectAtIndex:22];
    [dict setValue:tdetails.trackingText forKey:@"average_cadence"];
    
    tdetails=(TrackingDetails*)[detailsArray objectAtIndex:23];
    [dict setValue:tdetails.trackingText forKey:@"recovery_sessions"];
    
    tdetails=(TrackingDetails*)[detailsArray objectAtIndex:24];
    [dict setValue:tdetails.trackingText forKey:@"flexibility_sessions"];
    
    
    if (_profileImageView.image) {
        [RequestManager postWithImageServer:@"tracking" parameters:dict image:_profileImageView.image imageName:@"tracking_image" completionHandler:^(NSDictionary *responseDict) {
            
            if ([[responseDict valueForKey:@"code"] isEqualToString:@"1"]) {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Success !!!" message:[responseDict valueForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                alert.tag=1;
                [alert show];
            }
            
            
        }];
    }
    
    
}

#pragma mark -
#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex

{
    BOOL cameraAvailable = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    BOOL libraryAvailable = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
    int i = buttonIndex;
    switch(i)
    {
        case 0:
        {
            UIImagePickerController * picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            if (cameraAvailable) {
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Camera"
                                                                message:@"Please check your camera setting. It's not available."
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
                break;
            }
            [self presentViewController:picker animated:YES completion:^{}];
            break;
        }
        case 1:
        {
            UIImagePickerController * picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            if (libraryAvailable) {
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Camera"
                                                                message:@"Please check your Photo library settings. Its not available."
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            }
            [self presentViewController:picker animated:YES completion:^{}];
            break;
        }
        default:
            break;
    }
    
}


#pragma - mark Selecting Image from Camera and Library
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
#pragma mark --------------------------------------
    
    //Dismiss the View Controller
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    //Persist the image
    
    NSData* selectedImage =nil;
    UIImage *image=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    selectedImage = UIImageJPEGRepresentation([image fixOrientation], 0.1);;
    
    //if not image return
    
    if (!selectedImage)
    {
        return;
    }
    _profileImageView.image=[UIImage imageWithData:selectedImage];
    
    
    
    
}

#pragma - mark Alertview

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==1) {
        [self.navigationController popViewControllerAnimated:true];
    }
}

@end
