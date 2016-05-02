//
//  ViewTrackingProgressController.m
//  FitHealthy
//
//  Created by MacBook on 03/08/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import "ViewTrackingProgressController.h"
#import "ViewTrackinCell.h"

@interface ViewTrackingProgressController (){
    NSMutableArray *trackingArray;
    int pageCount;
}



@end

@implementation ViewTrackingProgressController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"Tracking Progress";
   // self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(startTracking)];
   self.navigationItem.rightBarButtonItem= [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(startTracking)];
    // Do any additional setup after loading the view.
    _viewTrackingTable.contentInset = UIEdgeInsetsMake(10.0, 0.0, 0.0, 0.0);
    trackingArray=[NSMutableArray array];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    pageCount=0;
    [self performSelector:@selector(callWebService) withObject:nil afterDelay:1.0];
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


#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return NO;
}


-(void)startTracking{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                                 bundle: nil];
        
        TrackingProgressController *vc ;
        vc = (TrackingProgressController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"TrackingProgressController"];
        [self.navigationController pushViewController:vc animated:YES];
    });
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return trackingArray.count;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //TrackingDetails *tdetails=(TrackingDetails*)[trackingArray objectAtIndex:indexPath.row];
    
    
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *celltype=@"ViewTrackinCell";
    
    // Configure the cell...
    
    ViewTrackinCell *cell = (ViewTrackinCell*)[tableView dequeueReusableCellWithIdentifier:celltype];
    
    //cell.position=indexPath.row;
    //cell.delegate=self;
    
    
    TrackingDetails *tdetails=(TrackingDetails*)[trackingArray objectAtIndex:indexPath.row];
    
    cell.trackingDate.text=tdetails.trackingDate;
    
    cell.weightText.text=tdetails.trackingWeight;
    cell.BMI.text=tdetails.BMI;
    cell.bodyFat.text=tdetails.bodyFat;
   
    if (!tdetails.profileImage) {
        cell.profileImage.image=nil;
        [self startIconDownload:tdetails forIndexPath:indexPath];
    }
    else{
        cell.profileImage.image=tdetails.profileImage;
    }
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                                 bundle: nil];
        TrackingDetails *tdetails=(TrackingDetails*)[trackingArray objectAtIndex:indexPath.row];
        TrackingProgressDetailsController *vc ;
        vc = (TrackingProgressDetailsController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"TrackingProgressDetailsController"];
        vc.tdetails=tdetails;
        [self.navigationController pushViewController:vc animated:YES];
    });
}



- (void)terminateAllDownloads
{
    // terminate all pending download connections
    NSArray *allDownloads = [_imageDownloadsInProgress allValues];
    [allDownloads makeObjectsPerformSelector:@selector(cancelDownload)];
    
    [_imageDownloadsInProgress removeAllObjects];
}

- (void)startIconDownload:(TrackingDetails *)appRecord forIndexPath:(NSIndexPath *)indexPath
{
    TrackingDownload *iconDownloader = (_imageDownloadsInProgress)[indexPath];
    if (iconDownloader == nil)
    {
        iconDownloader = [[TrackingDownload alloc] init];
        iconDownloader.details = appRecord;
        [iconDownloader setCompletionHandler:^{
            
            ViewTrackinCell *cell = (ViewTrackinCell*)[_viewTrackingTable cellForRowAtIndexPath:indexPath];
            
            // Display the newly loaded image
            cell.profileImage.image = appRecord.profileImage;
            
            // Remove the IconDownloader from the in progress list.
            // This will result in it being deallocated.
            [self.imageDownloadsInProgress removeObjectForKey:indexPath];
            
        }];
        (self.imageDownloadsInProgress)[indexPath] = iconDownloader;
        [iconDownloader startDownload];
    }
}


#pragma mark webservice

-(void)callWebService{
    
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithObjectsAndKeys:[FHDelegate.userInfo.info valueForKey:@"user_security_hash"],@"user_security_hash",[FHDelegate.userInfo.info valueForKey:@"user_id"],@"user_id",[NSString stringWithFormat:@"%d",pageCount],@"page", nil];
    
    [RequestManager getFromServer:@"tracking_progress" parameters:dict completionHandler:^(NSDictionary *responseDict) {
        
        
        if (pageCount==0) {
            [trackingArray removeAllObjects];
        }
        
        BOOL serverError=false;
        if ([[responseDict valueForKey:@"serverError"] isEqualToString:@"0"]) {
            [_viewTrackingTable.infiniteScrollingView stopAnimating];
            if (pageCount) {
                pageCount--;
            }
            serverError=true;
        }
        
        NSArray *dataArray=[responseDict valueForKey:@"data"];
        
        NSLog(@"prestn count =%lu",(unsigned long)dataArray.count);
        
        
        for (NSDictionary *dic in dataArray) {
            TrackingDetails *details=[[TrackingDetails alloc]init];
            
            details.trackingDate=[@"Tracking Date :-" stringByAppendingString:[dic valueForKey:@"tracking_created_date"]];
            details.trackingWeight=[@"Weight :-" stringByAppendingString:[dic valueForKey:@"weight"]];
            details.bodyFat=[@"Body Fat  :-" stringByAppendingString:[dic valueForKey:@"body_fat"]];
            details.BMI = [@"BMI :-" stringByAppendingString:[dic valueForKey:@"bmi"]];
            details.profileImageUrl=[dic valueForKey:@"tracking_thumb_url"];
            details.trackingDict=[NSMutableDictionary dictionaryWithDictionary:dic];
            
            [trackingArray addObject:details];
        }
        
        
        [_viewTrackingTable reloadData];
        [_viewTrackingTable.infiniteScrollingView stopAnimating];
        
        if (trackingArray.count>=7) {
            [self callAgainMethod];
            [_viewTrackingTable setShowsInfiniteScrolling:true];
            
        }
        
        if (dataArray.count==0 && !serverError) {
            [_viewTrackingTable setShowsInfiniteScrolling:false];
        }
        
    }];
    
}


-(void)callAgainMethod{
    __weak ViewTrackingProgressController *weakSelf=self;
    [_viewTrackingTable addInfiniteScrollingWithActionHandler:^{
        [weakSelf addScroller];
    }];
}

-(void)addScroller{
    
    pageCount++;
    [self callWebService];
}


@end
