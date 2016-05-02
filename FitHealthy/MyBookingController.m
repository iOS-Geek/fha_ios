//
//  MyBookingController.m
//  FitHealthy
//
//  Created by MacBook on 27/07/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import "MyBookingController.h"

@interface MyBookingController (){
    NSMutableArray *bookingArray;
    int pageCount;
    BOOL hideFeedBackView;
}

@end


NSMutableDictionary *myBookingImageDownloadsInProgress;

@implementation MyBookingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"My Bookings";
    bookingArray =[NSMutableArray array];
    myBookingImageDownloadsInProgress = [NSMutableDictionary dictionary];
    _bookingTableView.contentInset = UIEdgeInsetsMake(10.0, 0.0, 0.0, 0.0);

   
    if ([[FHDelegate.userInfo.info valueForKey:@"group_slug"] isEqualToString:@"coach"]){
        hideFeedBackView=true;
    }
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)reloadsMyBookings{
    [_bookingTableView reloadData];
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [bookingArray removeAllObjects];
    _bookingBackImage.hidden=true;
    [self reloadsMyBookings];
    [self callWebService];
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
    return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return NO;
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  bookingArray.count;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CoachesTableCellIdentiFier = @"MyBookingCell";
    
    MyBookingCell *cell = (MyBookingCell*)[tableView dequeueReusableCellWithIdentifier:CoachesTableCellIdentiFier];
    if (cell == nil)
    {
        cell = [[MyBookingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CoachesTableCellIdentiFier];
        
    }
    
    NSMutableDictionary *dict=[bookingArray objectAtIndex:indexPath.row];
    
    cell.userName.text=[NSString stringWithFormat:@"%@ %@",[dict valueForKey:@"user_first_name"],[dict valueForKey:@"user_last_name"]];
    cell.callStartLabel.text=[NSString stringWithFormat:@"Call Start:- %@",[dict valueForKey:@"booking_start_time"]];
    
    cell.callEndLabel.text=[NSString stringWithFormat:@"Call End:- %@",[dict valueForKey:@"booking_end_time"]];
    cell.durationLabel.text=[NSString stringWithFormat:@"Duration %@ Minutes",[dict valueForKey:@"booking_length"]];
    NSString *typeString=@"";
    
    if ([[dict valueForKey:@"availability_for"] isEqualToString:@"2"]) {
        typeString=@"1-2-1 Video Coaching";
    }
    else if ([[dict valueForKey:@"availability_for"] isEqualToString:@"3"]) {
        typeString=@"Group Video Coaching";
    }
    cell.typeLabel.text=typeString;
    
    cell.feedbackCountLabel.text=[NSString stringWithFormat:@"(%@)",[dict valueForKey:@"user_rating_count"]];
    cell.feedbackView.canEdit=false;
    cell.feedbackView.rating=[[dict valueForKey:@"user_rating_average"]floatValue];
    
    
  
    if (![dict valueForKey:@"downloaded_image"]) {
        cell.userImage.image=nil;
        [self startIconDownload:dict forIndexPath:indexPath];
    }
    else{
        cell.userImage.image=[dict valueForKey:@"downloaded_image"];
    }
    
    
    if (hideFeedBackView) {
        cell.feedbackCountLabel.hidden=true;
        cell.feedbackView.hidden=true;
    }
    else{
        cell.feedbackCountLabel.hidden=false;
        cell.feedbackView.hidden=false;
    }
    return cell;
    
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *dict=[bookingArray objectAtIndex:indexPath.row];
   // [coachesSearchBar resignFirstResponder];
    // SearchResults *result=[SearchResultsArray objectAtIndex:indexPath.row];
    //[self callSelectionWebService:result.post_id];

    
    
     NSMutableDictionary *sendingDict=[NSMutableDictionary dictionaryWithObjectsAndKeys:[FHDelegate.userInfo.info valueForKey:@"user_security_hash"],@"user_security_hash",[FHDelegate.userInfo.info valueForKey:@"user_id"],@"user_id",nil];
    [sendingDict setValue:[dict valueForKey:@"booking_id"] forKey:@"booking_id"];
    [RequestManager getFromServer:@"start" parameters:sendingDict completionHandler:^(NSMutableDictionary *responseDict) {
       
        
        if ([[responseDict valueForKey:@"code"] isEqualToString:@"1"]) {
            
            int duration= [[[responseDict valueForKey:@"data"] valueForKey:@"seconds_remaining"] integerValue];
            NSLog(@"server Seconds=%d",duration);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                                         bundle: nil];
                
                LogInVC *vc ;
                vc = (LogInVC*)[mainStoryboard instantiateViewControllerWithIdentifier: @"LogInVC"];
                //vc.coach=[coachArray objectAtIndex:indexPath.row];
                vc.conferenceId=[dict valueForKey:@"conference_id"];
                vc.userName=[NSString stringWithFormat:@"%@ %@ (%@)",[FHDelegate.userInfo.info valueForKey:@"user_first_name"],[FHDelegate.userInfo.info valueForKey:@"user_last_name"],[FHDelegate.userInfo.info valueForKey:@"user_id"]];
                
                long long uId=[[FHDelegate.userInfo.info valueForKey:@"user_id"] longLongValue];
                uId+=999999;
                vc.duration=duration;
                if ([[[responseDict valueForKey:@"data"] valueForKey:@"show_rating_dialog"] integerValue]) {
                    vc.feedback=true;
                }
                else{
                    vc.feedback=false;
                }
                vc.bookingId=[dict valueForKey:@"booking_id"];
                //        vc.userId=[NSString stringWithFormat:@"%lld",uId];
                NSString *sentStringid=[NSString stringWithFormat:@"%lld",uId];
                vc.userId=sentStringid;
                
                [self.navigationController pushViewController:vc animated:YES];
            });

            
        }else if ([[responseDict valueForKey:@"code"] isEqualToString:@"0"]) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error !!!" message:[responseDict valueForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
        }
    }];
    
    }


- (void)terminateAllDownloads
{
    // terminate all pending download connections
    NSArray *allDownloads = [myBookingImageDownloadsInProgress allValues];
    [allDownloads makeObjectsPerformSelector:@selector(cancelDownload)];
    
    [myBookingImageDownloadsInProgress removeAllObjects];
}

- (void)startIconDownload:(NSMutableDictionary *)appRecord forIndexPath:(NSIndexPath *)indexPath
{
    MyBookingImageDownloader *iconDownloader = [myBookingImageDownloadsInProgress objectForKey:indexPath];
    if (iconDownloader == nil)
    {
        iconDownloader = [[MyBookingImageDownloader alloc] init];
        iconDownloader.dict = appRecord;
        [iconDownloader setCompletionHandler:^{
            
            
            MyBookingCell *cell = (MyBookingCell*)[_bookingTableView cellForRowAtIndexPath:indexPath];
            
            // Display the newly loaded image
            cell.userImage.image = [appRecord valueForKey:@"downloaded_image"];
            [myBookingImageDownloadsInProgress removeObjectForKey:indexPath];
            
        }];
        [myBookingImageDownloadsInProgress setObject:iconDownloader forKey:indexPath];
        [iconDownloader startDownload];
    }
}







-(void)callWebService{
    
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithObjectsAndKeys:[FHDelegate.userInfo.info valueForKey:@"user_security_hash"],@"user_security_hash",[FHDelegate.userInfo.info valueForKey:@"user_id"],@"user_id",[NSString stringWithFormat:@"%d",pageCount],@"page", nil];
    
    [RequestManager getFromServer:@"bookings" parameters:dict completionHandler:^(NSDictionary *responseDict) {
        
        
        NSArray *dataArray=[responseDict valueForKey:@"data"];
        
        NSLog(@"prestn count =%lu",(unsigned long)dataArray.count);
        
        if (pageCount==0) {
            [bookingArray removeAllObjects];
        }
        
        BOOL serverError=false;
        if ([[responseDict valueForKey:@"serverError"] isEqualToString:@"0"]) {
            [_bookingTableView.infiniteScrollingView stopAnimating];
            if (pageCount) {
                pageCount--;
            }
            serverError=true;
        }

        for (NSDictionary *dic in dataArray) {
            
            [bookingArray addObject:[NSMutableDictionary dictionaryWithDictionary:dic]];
        }
        
        if (bookingArray.count==0) {
            
            _bookingTableView.hidden=true;
            _bookingBackImage.hidden=false;
        }
        else{
            
            _bookingTableView.hidden=false;
            _bookingBackImage.hidden=true;
        }
        [self reloadsMyBookings];
        [_bookingTableView.infiniteScrollingView stopAnimating];
        
        
        if (bookingArray.count>=7) {
            [self callAgainMethod];
            [_bookingTableView setShowsInfiniteScrolling:true];
        }
        
        if (dataArray.count==0 && !serverError) {
            [_bookingTableView setShowsInfiniteScrolling:false];
        }
    }];
    
}


-(void)callAgainMethod{
    __weak MyBookingController *weakSelf=self;
    [_bookingTableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf addScroller];
    }];
}


-(void)addScroller{
    
    pageCount++;
    [self callWebService];
}


@end
