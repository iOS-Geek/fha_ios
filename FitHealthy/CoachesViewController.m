//
//  CoachesViewController.m
//  FitHealthy
//
//  Created by MacBook on 26/07/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import "CoachesViewController.h"


@class UserInfo;
@interface CoachesViewController ()<UIScrollViewDelegate>{
    NSMutableArray *coachArray;
    int pageCount;
    UserInfo *userInfo;
    NSString *searchText;
    CoachesTableCell *coachCell;
    
}



@end

@implementation CoachesViewController
@synthesize coachesSearchBar,coachesTableView;


NSMutableDictionary *coachesImageDownloadsInProgress;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"Coaches";
    coachesTableView.contentInset = UIEdgeInsetsMake(10.0, 0.0, 0.0, 0.0);
    coachArray =[NSMutableArray array];
    
    pageCount=0;
    coachesImageDownloadsInProgress = [NSMutableDictionary dictionary];
    //dict=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"1",@"One", nil];

    // Do any additional setup after loading the view.
    
    coachesSearchBar.backgroundImage=[[UIImage alloc]init];
    coachesSearchBar.backgroundColor=[UIColor colorWithRed:206.0/255.0 green:206.0/255.0 blue:206.0/255.0 alpha:1.0];
    userInfo=[FHDelegate loadCustomObjectWithKey:@"userinfo"];
    [self callWebService];
    
    // Do any additional setup after loading the view.
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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
#pragma mark - Slider Method

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
    return  coachArray.count;
}


-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 116;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
    Coaches *coach=[coachArray objectAtIndex:indexPath.row];
    
    return coach.rowHeight;
    
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    static NSString *CoachesTableCellIdentiFier = @"CoachesTableCell";
    
    CoachesTableCell *cell = (CoachesTableCell*)[tableView dequeueReusableCellWithIdentifier:CoachesTableCellIdentiFier];
    if (cell == nil)
    {
        cell = [[CoachesTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CoachesTableCellIdentiFier];
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    Coaches *coach=[coachArray objectAtIndex:indexPath.row];
    
    cell.coachNameTitle.text=coach.coachName;
    cell.coachDescriptionText.text=coach.coachDesc;
    
    
    //cell.coachProfileImage.backgroundColor=[UIColor FHBackgroundColor];
    
    
    
    if (!coach.coachImage) {
        cell.coachProfileImage.image=nil;
        [self startIconDownload:coach forIndexPath:indexPath];
    }
    else{
        cell.coachProfileImage.image=coach.coachImage;
    }
    
    //cell.coachProfileImage.image=[UIImage imageNamed:@"user.png"];
   // cell.feedbackSlider.image=nil;
    //cell.feedbackSlider.slider.stars=5;
    //float f=[coach.user_rating_average floatValue];
    //NSLog(@"%@ %f",coach.coachName,f);
    // cell.feedbackSlider.myint=1.9;
    //}
    
    //[cell.feedbackSlider setNeedsLayout];
    //[cell setNeedsLayout];
    cell.feedbackView.rating=[coach.user_rating_average floatValue];
    cell.feedbackCountLabel.text=coach.user_rating_count;

    return cell;
    
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [coachesSearchBar resignFirstResponder];
    // SearchResults *result=[SearchResultsArray objectAtIndex:indexPath.row];
    //[self callSelectionWebService:result.post_id];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                                 bundle: nil];
        
        SingleCoachController *vc ;
        vc = (SingleCoachController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"SingleCoachController"];
        vc.coach=[coachArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    });
}


- (void)terminateAllDownloads
{
    // terminate all pending download connections
    NSArray *allDownloads = [coachesImageDownloadsInProgress allValues];
    [allDownloads makeObjectsPerformSelector:@selector(cancelDownload)];
    
    [coachesImageDownloadsInProgress removeAllObjects];
}

- (void)startIconDownload:(Coaches *)appRecord forIndexPath:(NSIndexPath *)indexPath
{
    CoachImageDownloder *iconDownloader = [coachesImageDownloadsInProgress objectForKey:indexPath];
    if (iconDownloader == nil)
    {
        iconDownloader = [[CoachImageDownloder alloc] init];
        iconDownloader.coach = appRecord;
        [iconDownloader setCompletionHandler:^{
            
            
            CoachesTableCell *cell = (CoachesTableCell*)[coachesTableView cellForRowAtIndexPath:indexPath];
            
            // Display the newly loaded image
            cell.coachProfileImage.image = appRecord.coachImage;
            [coachesImageDownloadsInProgress removeObjectForKey:indexPath];
            
        }];
        [coachesImageDownloadsInProgress setObject:iconDownloader forKey:indexPath];
        [iconDownloader startDownload];
    }
}







-(void)callWebService{
    
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithObjectsAndKeys:[userInfo.info valueForKey:@"user_security_hash"],@"user_security_hash",[userInfo.info valueForKey:@"user_id"],@"user_id",@"now",@"current_timestamp",[NSString stringWithFormat:@"%d",pageCount],@"page", nil];
    
    [RequestManager getFromServer:@"get_active_coaches" parameters:dict completionHandler:^(NSDictionary *responseDict) {
        
        BOOL serverError=false;
        if (pageCount==0) {
            [coachArray removeAllObjects];
        }
        
        if ([[responseDict valueForKey:@"serverError"] isEqualToString:@"0"]) {
            [coachesTableView.infiniteScrollingView stopAnimating];
            if (pageCount) {
                pageCount--;
            }
            serverError=true;
        }
        
        NSArray *dataArray=[responseDict valueForKey:@"data"];
        
        NSLog(@"prestn count =%lu",(unsigned long)dataArray.count);
        
        
        
        coachCell=(CoachesTableCell*)[coachesTableView dequeueReusableCellWithIdentifier:@"CoachesTableCell"];
        
        for (NSDictionary *dic in dataArray) {
            
            Coaches *coach=[[Coaches alloc]init];
            
            coach.coachName=[[[dic valueForKey:@"user_first_name"] stringByAppendingString:@" "]stringByAppendingString:[dic valueForKey:@"user_last_name"]];
            coach.coachDesc=[dic valueForKey:@"user_description"];
            coach.coachImageUrl=[dic valueForKey:@"user_profile_image_url"];
            coach.coachImage=nil;
            coach.user_rating_count=[NSString stringWithFormat:@"(%@)",[dic valueForKey:@"user_rating_count"]];
            coach.user_rating_average=[dic valueForKey:@"user_rating_average"];
            coach.coachId=[dic valueForKey:@"user_id"];
            
            coachCell.coachDescriptionText.text=coach.coachDesc;
            CGSize maximumLabelSize = CGSizeMake(coachCell.coachDescriptionText.frame.size.width, 9999); // this width will be as per your requirement
            
            CGSize expectedSize = [coachCell.coachDescriptionText sizeThatFits:maximumLabelSize];
            
            
            coach.rowHeight=expectedSize.height+71;
            if (coach.rowHeight<116) {
                coach.rowHeight=116;
            }

            
            [coachArray addObject:coach];
        }
        
        
        [coachesTableView reloadData];
        [coachesTableView.infiniteScrollingView stopAnimating];
        
        
        if (coachArray.count>=7) {
            [self callAgainMethod];
            [coachesTableView setShowsInfiniteScrolling:true];
        }
        
        if (dataArray.count==0 && !serverError) {
            [coachesTableView setShowsInfiniteScrolling:false];
        }
    }];
    
}


-(void)callAgainMethod{
    __weak CoachesViewController *weakSelf=self;
    [coachesTableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf addScroller];
    }];
}

-(void)addScroller{
    
    pageCount++;
    if (coachesSearchBar.text.length>0) {
        [self callSearchWebService];
    }
    else
    [self callWebService];
}


#pragma mark - Search Web Service

-(void)callSearchWebService{
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithObjectsAndKeys:[userInfo.info valueForKey:@"user_security_hash"],@"user_security_hash",[userInfo.info valueForKey:@"user_id"],@"user_id",@"now",@"current_timestamp",[NSString stringWithFormat:@"%d",pageCount],@"page",searchText,@"search", nil];
    
    
    [RequestManager getFromServer:@"search_coaches" parameters:dict completionHandler:^(NSDictionary *responseDict) {
        
        BOOL serverError=false;
        
        if (pageCount==0) {
            [coachArray removeAllObjects];
            [coachesTableView reloadData];
        }
        
        if ([[responseDict valueForKey:@"serverError"] isEqualToString:@"0"]) {
            [coachesTableView.infiniteScrollingView stopAnimating];
            if (pageCount) {
                pageCount--;
            }
            serverError=true;
        }
        
        NSArray *dataArray=[responseDict valueForKey:@"data"];
        
        
        coachCell=(CoachesTableCell*)[coachesTableView dequeueReusableCellWithIdentifier:@"CoachesTableCell"];
        
        
        
        NSLog(@"prestn count =%lu",(unsigned long)dataArray.count);
        
        
        for (NSDictionary *dic in dataArray) {
            Coaches *coach=[[Coaches alloc]init];
            
            coach.coachName=[[[dic valueForKey:@"user_first_name"] stringByAppendingString:@" "]stringByAppendingString:[dic valueForKey:@"user_last_name"]];
            coach.coachDesc=[dic valueForKey:@"user_description"];
            coach.coachImageUrl=[dic valueForKey:@"user_profile_image_url"];
            coach.coachImage=nil;
            coach.user_rating_count=[NSString stringWithFormat:@"(%@)",[dic valueForKey:@"user_rating_count"]];
            coach.user_rating_average=[dic valueForKey:@"user_rating_average"];
            coach.coachId=[dic valueForKey:@"user_id"];
            
            coachCell.coachDescriptionText.text=coach.coachDesc;
            CGSize maximumLabelSize = CGSizeMake(coachCell.coachDescriptionText.frame.size.width, 9999); // this width will be as per your requirement
            
            CGSize expectedSize = [coachCell.coachDescriptionText sizeThatFits:maximumLabelSize];
            
            
            coach.rowHeight=expectedSize.height+71;
            if (coach.rowHeight<116) {
                coach.rowHeight=116;
            }

            [coachArray addObject:coach];
        }
        
        
        [coachesTableView reloadData];
        
        [coachesTableView.infiniteScrollingView stopAnimating];
        
        if (coachArray.count>=7) {
            [self callAgainMethod];
            [coachesTableView setShowsInfiniteScrolling:true];
            
        }
        
       if (dataArray.count==0 && !serverError) {
            [coachesTableView setShowsInfiniteScrolling:false];
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
    if (coachArray.count) {
        [coachesTableView scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionTop animated:YES];

    }
    //[coachesTableView scrollsToTop];
    
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
    
    
    searchText=[[NSString alloc]initWithString:searchBar.text];
    pageCount=0;
    [coachesTableView setShowsInfiniteScrolling:false];
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

//#pragma  mark Scrollview Delegate
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    scrollView.decelerationRate=UIScrollViewDecelerationRateFast;
//}
@end
