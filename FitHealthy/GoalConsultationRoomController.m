//
//  GoalConsultationRoomController.m
//  FitHealthy
//
//  Created by MacBook on 26/07/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import "GoalConsultationRoomController.h"
static NSString *CellIdentifier = @"GoalRoomTableCell";


@interface GoalConsultationRoomController (){
    NSMutableArray *questionArray;
    int pageCount;
    NSString *searchText;
    GoalRoomTableCell *hieghtSetCell;
}

@end

@implementation GoalConsultationRoomController
@synthesize goalTable,goalSearchBar,imageDownloadsInProgress;
- (void)viewDidLoad {
    [super viewDidLoad];
    questionArray =[NSMutableArray array];
    self.title=@"Goal Consultation Room";
    pageCount=0;
    imageDownloadsInProgress = [NSMutableDictionary dictionary];
    goalTable.contentInset = UIEdgeInsetsMake(10.0, 0.0, 0.0, 0.0);
    // Do any additional setup after loading the view.
   
    goalSearchBar.backgroundImage=[[UIImage alloc]init];
    goalSearchBar.backgroundColor=[UIColor colorWithRed:206.0/255.0 green:206.0/255.0 blue:206.0/255.0 alpha:1.0];
   // NSString *str=@"This is a two lines text and what i say now";
    
   
    
   
    
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     pageCount=0;
     [self performSelector:@selector(callWebService) withObject:nil afterDelay:0.0];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self terminateAllDownloads];
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
    return  questionArray.count;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    QuestionsList *list=[questionArray objectAtIndex:indexPath.row];
    
    return list.rowHeight;
}





- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    GoalRoomTableCell *cell = (GoalRoomTableCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[GoalRoomTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    
    QuestionsList *list=[questionArray objectAtIndex:indexPath.row];
    
    cell.topic.text=list.topic;
    cell.valueText.text=list.value;
    cell.ansCount_time.text=list.answersCount_time;

    cell.userImage.backgroundColor=[UIColor FHBackgroundColor];
    
    if (!list.userImage) {
        cell.userImage.image=nil;
         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^ {
              dispatch_async(dispatch_get_main_queue(), ^ {
        [self startIconDownload:list forIndexPath:indexPath];
         });
         });
    }
    else{
        cell.userImage.image=list.userImage;
    }
    
    //cell.layer.shouldRasterize = YES;
    //cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    return cell;
    
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    QuestionsList *qlist=[questionArray objectAtIndex:indexPath.row];
    
    
    if ([qlist.answerCount intValue]==0) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error !!!" message:@"Answer not present." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        return;
    }
    [goalSearchBar resignFirstResponder];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                                 bundle: nil];
        
        QuestionAnswerController *vc ;
        vc = (QuestionAnswerController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"QuestionAnswerController"];
        vc.question=[questionArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    });
    
    
}



- (void)terminateAllDownloads
{
    // terminate all pending download connections
    NSArray *allDownloads = [imageDownloadsInProgress allValues];
    [allDownloads makeObjectsPerformSelector:@selector(cancelDownload)];
    
    [imageDownloadsInProgress removeAllObjects];
}

- (void)startIconDownload:(QuestionsList *)appRecord forIndexPath:(NSIndexPath *)indexPath
{
    IconDownloader *iconDownloader = (imageDownloadsInProgress)[indexPath];
    if (iconDownloader == nil)
    {
        iconDownloader = [[IconDownloader alloc] init];
        iconDownloader.list = appRecord;
        [iconDownloader setCompletionHandler:^{
            
            GoalRoomTableCell *cell = (GoalRoomTableCell*)[goalTable cellForRowAtIndexPath:indexPath];
            
            // Display the newly loaded image
           cell.userImage.image=appRecord.userImage;
            
            // Remove the IconDownloader from the in progress list.
            // This will result in it being deallocated.
            [self.imageDownloadsInProgress removeObjectForKey:indexPath];
            
            
            
        }];
        (self.imageDownloadsInProgress)[indexPath] = iconDownloader;
        [iconDownloader startDownload];
    }
}


- (void)loadImagesForOnscreenRows
{
    if (questionArray.count > 0)
    {
        NSArray *visiblePaths = [goalTable indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in visiblePaths)
        {
            QuestionsList *appRecord = (questionArray)[indexPath.row];
            
            if (!appRecord.userImage)
                // Avoid the app icon download if the app already has an icon
            {
                [self startIconDownload:appRecord forIndexPath:indexPath];
            }
        }
    }
}



// -------------------------------------------------------------------------------
//	scrollViewDidEndDragging:willDecelerate:
//  Load images for all onscreen rows when scrolling is finished.
// -------------------------------------------------------------------------------
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    if (!decelerate)
    {
        //[self loadImagesForOnscreenRows];
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //[self loadImagesForOnscreenRows];
}



-(void)callWebService{
    
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"now",@"current_timestamp",[NSString stringWithFormat:@"%d",pageCount],@"page", nil];
    
    [RequestManager getFromServer:@"questions_list" parameters:dict completionHandler:^(NSDictionary *responseDict) {
        
        
        if (pageCount==0) {
            [questionArray removeAllObjects];
        }

        
        BOOL serverError=false;
        if ([[responseDict valueForKey:@"serverError"] isEqualToString:@"0"]) {
            [goalTable.infiniteScrollingView stopAnimating];
            if (pageCount) {
                pageCount--;
            }
            serverError=true;
        }
        
        NSArray *dataArray=[responseDict valueForKey:@"data"];
        
        NSLog(@"prestn count =%lu",(unsigned long)dataArray.count);
        
        
        
        hieghtSetCell=(GoalRoomTableCell*)[goalTable dequeueReusableCellWithIdentifier:CellIdentifier];
        
        
        for (NSDictionary *dic in dataArray) {
            QuestionsList *list=[[QuestionsList alloc]init];
            
            list.qId=[dic valueForKey:@"question_id"];
            list.topic=[dic valueForKey:@"question_topic"];
            list.value=[dic valueForKey:@"question_value"];
           list.value = [list.value stringByTrimmingCharactersInSet:
                                       [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            list.answersCount_time=[[[dic valueForKey:@"question_answer_count"] stringByAppendingString:@" Answers :-"] stringByAppendingString:[dic valueForKey:@"question_created_timestamp"]];
            list.answerCount=[dic valueForKey:@"question_answer_count"];
            list.imageUrl=[dic valueForKey:@"user_profile_image_url"];
            
            
            [questionArray addObject:list];
            
            hieghtSetCell.valueText.text=list.value;
            CGSize maximumLabelSize = CGSizeMake(hieghtSetCell.valueText.frame.size.width, 9999); // this width will be as per your requirement
            
            CGSize expectedSize = [hieghtSetCell.valueText sizeThatFits:maximumLabelSize];
            
            
            list.rowHeight=expectedSize.height;
            
            if (list.rowHeight>39) {
                list.rowHeight= 110+expectedSize.height-39;
            }
            else{
                list.rowHeight=110;
            }
            

            
        }
        
        
        [goalTable reloadData];
        [goalTable.infiniteScrollingView stopAnimating];
        
        if (questionArray.count>=7) {
            [self callAgainMethod];
            [goalTable setShowsInfiniteScrolling:true];
            
        }
        
        if (dataArray.count==0 && !serverError) {
            [goalTable setShowsInfiniteScrolling:false];
        }
        
    }];
    
}


-(void)callAgainMethod{
    __weak GoalConsultationRoomController *weakSelf=self;
    [goalTable addInfiniteScrollingWithActionHandler:^{
        [weakSelf addScroller];
    }];
}

-(void)addScroller{
    
    pageCount++;
    if (goalSearchBar.text.length>0) {
        [self callSearchWebService];
    }
    else
        [self callWebService];
}


#pragma mark - Search Web Service

-(void)callSearchWebService{
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithObjectsAndKeys:[FHDelegate. userInfo.info valueForKey:@"user_security_hash"],@"user_security_hash",[FHDelegate.userInfo.info valueForKey:@"user_id"],@"user_id",@"now",@"current_timestamp",[NSString stringWithFormat:@"%d",pageCount],@"page",searchText,@"search", nil];
    
    
    [RequestManager getFromServer:@"search_questions" parameters:dict completionHandler:^(NSDictionary *responseDict) {
        
        
        if (pageCount==0) {
            [questionArray removeAllObjects];
            [goalTable reloadData];
        }
        
        BOOL serverError=false;
        if ([[responseDict valueForKey:@"serverError"] isEqualToString:@"0"]) {
            [goalTable.infiniteScrollingView stopAnimating];
            if (pageCount) {
                pageCount--;
            }
            serverError=true;
        }
        
        NSArray *dataArray=[responseDict valueForKey:@"data"];
        
       
        NSLog(@"prestn count =%lu",(unsigned long)dataArray.count);
        
        hieghtSetCell=(GoalRoomTableCell*)[goalTable dequeueReusableCellWithIdentifier:CellIdentifier];
        
        for (NSDictionary *dic in dataArray) {
            QuestionsList *list=[[QuestionsList alloc]init];
            
            list.qId=[dic valueForKey:@"question_id"];
            list.topic=[dic valueForKey:@"question_topic"];
            list.value=[dic valueForKey:@"question_value"];
            list.value = [list.value stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            list.answersCount_time=[[[dic valueForKey:@"question_answer_count"] stringByAppendingString:@" Answers :-"] stringByAppendingString:[dic valueForKey:@"question_created_timestamp"]];
            list.answerCount=[dic valueForKey:@"question_answer_count"];
            list.imageUrl=[dic valueForKey:@"user_profile_image_url"];
            list.userImage=nil;
            
            
            
            hieghtSetCell.valueText.text=list.value;
            CGSize maximumLabelSize = CGSizeMake(hieghtSetCell.valueText.frame.size.width, 9999); // this width will be as per your requirement
            
            CGSize expectedSize = [hieghtSetCell.valueText sizeThatFits:maximumLabelSize];
            
            
            list.rowHeight=expectedSize.height;
            
            if (list.rowHeight>39) {
                list.rowHeight= 110+expectedSize.height-39;
            }
            else{
                list.rowHeight=110;
            }

            [questionArray addObject:list];

        }
        [goalTable reloadData];
        
           [goalTable.infiniteScrollingView stopAnimating];
        
        if (questionArray.count>=7) {
            [self callAgainMethod];
            [goalTable setShowsInfiniteScrolling:true];
            
        }
        
        if (dataArray.count==0 && !serverError) {
            [goalTable setShowsInfiniteScrolling:false];
        }
        
    }];
    
}

#pragma mark SearchBar methods

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:YES];
}// called when text starts editing

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    
}// called when text ends editing


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    NSIndexPath *indexpath=[NSIndexPath indexPathForRow:0 inSection:0];
    if (questionArray.count) {
        [goalTable scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionTop animated:YES];

    }
       //[coachesTableView scrollsToTop];
    
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
    
    
    searchText=[[NSString alloc]initWithString:searchBar.text];
    goalTable.infiniteScrollingView.enabled=true;
    pageCount=0;
    [self callSearchWebService];
    
}// called when keyboard search button pressed

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    searchBar.text=@"";
    searchText=@"";
    pageCount=0;
    [self callWebService];
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
    
}


@end
