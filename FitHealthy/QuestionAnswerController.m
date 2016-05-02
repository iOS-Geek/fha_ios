//
//  QuestionAnswerController.m
//  FitHealthy
//
//  Created by MacBook on 28/07/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import "QuestionAnswerController.h"




@interface QuestionAnswerController ()<UIAlertViewDelegate>{
    NSMutableArray *questionAnswersArray;
    int pageCount;
    UILabel *scrollingLabel;
    CGFloat viewHieght;
    UserInfo *userInfo;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inputBoxHeight;

@end

@implementation QuestionAnswerController
@synthesize imageDownloadsInProgress,answerTable,question,inputBox;

- (void)viewDidLoad {
    [super viewDidLoad];
    questionAnswersArray =[NSMutableArray array];
    [questionAnswersArray addObject:question];
    self.title=@"Answers";
    pageCount=0;
    viewHieght=self.view.frame.size.height;
    userInfo=[FHDelegate loadCustomObjectWithKey:@"userinfo"];
    imageDownloadsInProgress = [NSMutableDictionary dictionary];
    //answerTable.contentInset = UIEdgeInsetsMake(10.0, 0.0, 0.0, 0.0);
    // Do any additional setup after loading the view.
    //[answerTable reloadData];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, answerTable.frame.size.width, 20)];
    UILabel *label=[[UILabel alloc]initWithFrame:view.frame];
    label.text=@"Questions";
    label.font=[UIFont FHFontWithSize:15.0];
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=[UIColor darkGrayColor];
    [view addSubview:label];
    view.backgroundColor = [UIColor FHBackgroundFieldColor];
    answerTable.tableHeaderView=view;
    [self performSelector:@selector(callWebService) withObject:nil afterDelay:1.0];
    
    
    if ([[userInfo.info valueForKey:@"group_slug"] isEqualToString:@"coach"]) {
        inputBox.sendButton.hidden=false;
        inputBox.textView.returnKeyType=UIReturnKeyDefault;
    }
    else{
        _inputBoxHeight.constant=0;
        [inputBox setNeedsUpdateConstraints];
    }
    
 UIView *viewFooter = [[UIView alloc] initWithFrame:CGRectMake(0, 0, answerTable.frame.size.width, 10)];
    viewFooter.backgroundColor=[UIColor FHBackgroundColor];
    answerTable.tableFooterView=viewFooter;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - Table view data source


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0;
    }
    return 20;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 20)];
    UILabel *label=[[UILabel alloc]initWithFrame:view.frame];
    label.text=@"Answers";
    label.font=[UIFont FHFontWithSize:15.0];
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=[UIColor darkGrayColor];
    [view addSubview:label];
    view.backgroundColor = [UIColor FHBackgroundFieldColor];
    
    return view;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    return  questionAnswersArray.count-1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        QuestionsList *list=[questionAnswersArray objectAtIndex:indexPath.row];
        static NSString *CellIdentifier = @"QuestionCell";
        GoalRoomTableCell *cell = (GoalRoomTableCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.valueText.text=list.value;
        
        CGSize maximumLabelSize = CGSizeMake(self.view.frame.size.width-100, 9999); // this width will be as per your requirement
        
        CGSize expectedSize = [cell.valueText sizeThatFits:maximumLabelSize];
        
        if (expectedSize.height>39) {
            return 120+expectedSize.height-39;
        }
        return 120;
    }
    else{
        QuestionsList *list=[questionAnswersArray objectAtIndex:indexPath.row+1];
        static NSString *CellIdentifier = @"AnswerTableCell";
        AnswerTableCell *cell = (AnswerTableCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.valueText.text=list.value;
        
        CGSize maximumLabelSize = CGSizeMake(self.view.frame.size.width-100, 9999); // this width will be as per your requirement
        
        CGSize expectedSize = [cell.valueText sizeThatFits:maximumLabelSize];
        
        if (expectedSize.height>39) {
            return 112+expectedSize.height-39;
        }
        return 112;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier1 = @"QuestionCell";
    static NSString *CellIdentifier2 = @"AnswerTableCell";
    
    QuestionsList *list;
    
    if (indexPath.section==0) {
        list=[questionAnswersArray objectAtIndex:indexPath.row];
        GoalRoomTableCell *cell = (GoalRoomTableCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (cell == nil)
        {
            cell = [[GoalRoomTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
            //cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        cell.topic.text=list.topic;
        cell.valueText.text=list.value;
        cell.ansCount_time.text=list.answersCount_time;
        
        cell.userImage.backgroundColor=[UIColor FHBackgroundColor];
        
        if (!list.userImage) {
            cell.userImage.image=nil;
            [self startIconDownload:list forIndexPath:indexPath];
        }
        else{
            cell.userImage.image=list.userImage;
        }
        
        
        
        
        return cell;
        
    }
    else{
    AnswerTableCell *cell = (AnswerTableCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
         list=[questionAnswersArray objectAtIndex:indexPath.row+1];
    if (cell == nil)
    {
        cell = [[AnswerTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier2];
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
       
    }
        cell.topic.text=list.topic;
        cell.valueText.text=list.value;
        cell.ansCount_time.text=list.answersCount_time;
        
        cell.userImage.backgroundColor=[UIColor FHBackgroundColor];
        
        if (!list.userImage) {
            cell.userImage.image=nil;
            [self startIconDownload:list forIndexPath:indexPath];
        }
        else{
            cell.userImage.image=list.userImage;
        }
        [cell.talkToButton setTitle:[@"Talk to " stringByAppendingString:list.topic] forState:UIControlStateNormal];
        
        
        if ([[userInfo.info valueForKey:@"group_slug"] isEqualToString:@"coach"]){
            cell.talkToButton.hidden=true;
        }
        else{
            cell.talkToButton.hidden=false;
        }
        
        cell.feedbackCount.text=list.feedbackCount;
        cell.question=list;
        cell.delegate=self;
        return cell;
    }
    
    
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [inputBox resignFirstResponder];
    answerTable.scrollEnabled=true;
    
    // SearchResults *result=[SearchResultsArray objectAtIndex:indexPath.row];
    //[self callSelectionWebService:result.post_id];
    
}

#pragma  mark Talk to Button pressed
- (void)ButtonPressed:(QuestionsList*)answer{
    NSLog(@"quesiton%@  %@  %@",answer.qId,answer.topic,answer.value);
    

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                                     bundle: nil];
            
            SingleCoachController *vc ;
            vc = (SingleCoachController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"SingleCoachController"];
            vc.coach=answer.coach;
            //answer.coach.coachImage=answer.userImage;
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
            
            GoalRoomTableCell *cell = (GoalRoomTableCell*)[answerTable cellForRowAtIndexPath:indexPath];
            
            // Display the newly loaded image
            cell.userImage.image = appRecord.userImage;
            
            // Remove the IconDownloader from the in progress list.
            // This will result in it being deallocated.
            [self.imageDownloadsInProgress removeObjectForKey:indexPath];
            
        }];
        (self.imageDownloadsInProgress)[indexPath] = iconDownloader;
        [iconDownloader startDownload];
    }
}



-(void)callWebService{
    
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithObjectsAndKeys:question.qId,@"questions_id",[NSString stringWithFormat:@"%d",pageCount],@"page", nil];
    
    [RequestManager getFromServer:@"answers_list" parameters:dict completionHandler:^(NSDictionary *responseDict) {
        
        BOOL serverError=false;
        
        
        if (pageCount==0) {
            [questionAnswersArray removeAllObjects];
            [questionAnswersArray addObject:question];
        }
        
        if ([[responseDict valueForKey:@"serverError"] isEqualToString:@"0"]) {
            [answerTable.infiniteScrollingView stopAnimating];
            if (pageCount) {
                pageCount--;
            }
            serverError=true;
        }
        
        
        
        NSArray *dataArray=[responseDict valueForKey:@"data"];
        NSMutableArray *array = [NSMutableArray arrayWithArray:[question.answersCount_time componentsSeparatedByString:@" "]];
        
        
        
        
        NSLog(@"prestn count =%lu",(unsigned long)dataArray.count);
        
        
        for (NSDictionary *dic in dataArray) {
            QuestionsList *list=[[QuestionsList alloc]init];
            
            list.qId=[dic valueForKey:@"question_id"];
            list.topic=[[[dic valueForKey:@"user_first_name"] stringByAppendingString:@" "] stringByAppendingString:[dic valueForKey:@"user_last_name"]];
            list.value=[dic valueForKey:@"answer_value"];
            list.value = [list.value stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            list.answersCount_time=[dic valueForKey:@"answer_created_timestamp"];
            list.imageUrl=[dic valueForKey:@"user_profile_image_url"];
            list.feedbackCount=[NSString stringWithFormat:@"(%@)",[dic valueForKey:@"user_rating_count"]];
            list.feedbackAverage=[dic valueForKey:@"user_rating_average"];
            [array replaceObjectAtIndex:0 withObject:[dic valueForKey:@"question_answer_count"]];
            question.answersCount_time=[array componentsJoinedByString:@" "];
            
            list.coach= [[Coaches alloc]init];
            list.coach.coachName=[list.topic copy];
            list.coach.coachDesc= [dic valueForKey:@"user_description"];
            list.coach.coachImageUrl=[list.imageUrl copy];
            list.coach.user_rating_average=[list.feedbackAverage copy];
            list.coach.user_rating_count=[list.feedbackCount copy];
            list.coach.coachId=[dic valueForKey:@"user_id"];
            [questionAnswersArray addObject:list];
        }
        [answerTable reloadData];
       
        [answerTable.infiniteScrollingView stopAnimating];
        
        if (questionAnswersArray.count>=7) {
            [self callAgainMethod];
            [answerTable setShowsInfiniteScrolling:true];
            
        }
        
        if (dataArray.count==0 && !serverError) {
            [answerTable setShowsInfiniteScrolling:false];
        }

    }];
    
}


-(void)callAgainMethod{
    __weak QuestionAnswerController *weakSelf=self;
    [answerTable addInfiniteScrollingWithActionHandler:^{
        [weakSelf addScroller];
    }];
}

-(void)addScroller{
    
    pageCount++;
    [self callWebService];
}


#pragma mark - Result selection

-(void)callSelectionWebService:(NSString*)post_id {
    
    //dispatch_async(dispatch_get_main_queue(), ^{
    /*
     UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
     bundle: nil];
     CategoryDetailViewController *catDetail = (CategoryDetailViewController*)[mainStoryboard
     instantiateViewControllerWithIdentifier: @"categoryDetail"];
     
     
     catDetail.hidesBottomBarWhenPushed=true;
     
     NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithObjectsAndKeys:post_id,@"post_id", nil];
     
     [RequestManager getFromServer:@"view" parameters:dict completionHandler:^(NSDictionary *responseDict) {
     
     if ([[responseDict valueForKey:@"error"] isEqualToString:@"1"]) {
     
     return ;
     }
     NSLog(@"Got response in block %@",responseDict);
     NSDictionary *dic=[responseDict valueForKey:@"data"];
     
     SinglePostInfo *post=[[SinglePostInfo alloc]init];
     
     
     post.post_id=[dic valueForKey:@"post_id"];
     post.post_title=[dic valueForKey:@"post_title"];
     post.post_description=[dic valueForKey:@"post_description"];
     
     NSArray *buttonArray=[dic valueForKey:@"pricing_buttons"];
     
     post.buttonArray=[NSMutableArray array];
     for (NSDictionary *val in buttonArray) {
     [post.buttonArray addObject:val];
     }
     
     NSArray *imageArray=[dic valueForKey:@"post_images_array"];
     
     post.imageArray=[NSMutableArray array];
     
     for (NSDictionary *val in imageArray) {
     [post.imageArray addObject:[val valueForKey:@"post_image_url"]];
     }
     
     
     NSArray *postAvailArray=[dic valueForKey:@"post_time_availability_array"];
     
     post.postAvailabilityArray=[NSMutableArray array];
     for (NSDictionary *val in postAvailArray) {
     [post.postAvailabilityArray addObject:val];
     }
     
     post.country_name=[dic valueForKey:@"country_name"];
     post.post_street=[dic valueForKey:@"post_street"];
     post.post_cross_street=[dic valueForKey:@"post_cross_street"];
     
     post.city_name=[dic valueForKey:@"city_name"];
     post.state_code=[dic valueForKey:@"state_code"];
     post.post_zipcode=[dic valueForKey:@"post_zipcode"];
     post.category_name=[dic valueForKey:@"category_name"];
     post.time_zone_slug=[dic valueForKey:@"time_zone_slug"];
     NSLog(@"Got response in block 3");
     catDetail.post=post;
     [self.navigationController pushViewController:catDetail animated:YES];
     
     }];
     
     //    });
     */
}


#pragma mark - THChatInputDelegate

- (void)chat:(THChatInput*)input sendWasPressed:(NSString*)text
{
    
    if ([text stringByTrimmingCharactersInSet:
         [NSCharacterSet whitespaceCharacterSet]].length>0) {
        
        [inputBox resignFirstResponder];
            NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithObjectsAndKeys:[userInfo.info valueForKey:@"user_security_hash"],@"user_security_hash",[userInfo.info valueForKey:@"user_id"],@"user_id",question.qId,@"questions_id",text,@"answer_value", nil];
            
            [RequestManager getFromServer:@"answer" parameters:dict completionHandler:^(NSDictionary *responseDict) {
                
                if ([[responseDict valueForKey:@"code"] isEqualToString:@"1"]) {
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Success !!!" message:[responseDict valueForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                    [inputBox setText:@""];
                    
                    alert.tag=1;
                    [alert show];
                }
                
            }];
            
            
        }
    
}


- (void)chatShowAttachInput:(THChatInput*)input
{
    
}

- (void)chatKeyboardWillShow:(THChatInput*)cinput{
//    CGRect tableFrame=answerTable.frame;
//    tableFrame.size.height=cinput.frame.origin.y;
//    answerTable.frame=tableFrame;
    //answerTable.scrollEnabled=false;
    //CGRect ff=cinput.frame;
   // [cinput setNeedsDisplay];
   // inputBoxBottom.constant=inputBox.frame.origin.y+inputBox.frame.size.height;
    //[inputBox setNeedsUpdateConstraints];
    //[answerTable setNeedsUpdateConstraints];
    //[self.view setNeedsUpdateConstraints];
    //[inputBox setNeedsUpdateConstraints];
}

- (void)chatKeyboardDidShow:(THChatInput*)cinput{
//    //inputBoxBottom.constant=inputBox.frame.origin.y;//+inputBox.frame.size.height;
//    [cinput setNeedsUpdateConstraints];
//    [answerTable setNeedsUpdateConstraints];
//    [inputBox updateConstraints];
//    [self.view setNeedsUpdateConstraints];
}

# pragma mark Alertview delegate methods
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==1) {
        pageCount=0;
        [self callWebService];
    }
}

- (void)inputBoxHieght:(float)height{
    NSLog(@"%f",height);
//    CGRect tableRect=answerTable.frame;
//    tableRect.size.height=tableRect.origin.y+self.view.frame.size.height-height-inputBox.frame.origin.y;
//    answerTable.frame=tableRect;
}

@end
