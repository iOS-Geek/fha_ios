//
//  TestTableViewController.m
//  FitHealthy
//
//  Created by MacBook on 01/08/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import "TestTableViewController.h"
#import "TestTableViewCell.h"
#import "THChatInput.h"

@interface TestTableViewController ()<THChatInputDelegate>{
    NSMutableArray *questionArray;
    TestTableViewCell *hieghtLabel;
}



@property (weak, nonatomic) IBOutlet THChatInput *_chatInput;

@end

@implementation TestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    questionArray=[NSMutableArray array];
   // [self callWebService];
    
    
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
    return  questionArray.count;//coachArray.count;
}


-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
     QuestionsList *coach=[questionArray objectAtIndex:indexPath.row];
    /*
     
     
     
     static NSString *CellIdentifier = @"CoachesTableCell";
     CoachesTableCell *cell = (CoachesTableCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
     cell.coachDescriptionText.text=coach.coachDesc;
     CGSize maximumLabelSize = CGSizeMake(self.view.frame.size.width-100, 9999); // this width will be as per your requirement
     
     CGSize expectedSize = [cell.coachDescriptionText sizeThatFits:maximumLabelSize];
     
     if (expectedSize.height>41) {
     return 110+expectedSize.height-41;
     }
     return 110;
     */
    return coach.rowHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdn=@"TestTableViewCell";
    TestTableViewCell *cell = (TestTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdn];
    if (cell == nil)
    {
        cell = [[TestTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdn];
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    
    QuestionsList *list=(QuestionsList*)[questionArray objectAtIndex:indexPath.row];
    
    
    if (indexPath.row==0) {
        cell.values=1.0;
    }
    else if (indexPath.row==1){
        cell.values=2.0;
    }
    else if (indexPath.row==2){
        cell.values=3.0;
    }
    else if (indexPath.row==3){
        cell.values=4.0;
    }
    else if (indexPath.row==4){
        //cell.feedbackSlider.slider.value=5.0;
    }
    else if (indexPath.row==5){
        cell.values=1.0;
    }
    else if (indexPath.row==6){
        cell.values=2.0;
    }
    else if (indexPath.row==7){
        cell.values=3.0;
    }
    else if (indexPath.row==8){
        cell.values=4.0;
    }
    else if (indexPath.row==9){
        cell.values=5.0;
    }
    else{
        cell.values=0;
    }
    
    [cell setChangeValue];
    
    
    cell.tLabel.text=list.value;//
   // NSLog(@"Cell no=%d and value=%f",indexPath.row,cell.feedbackSlider.myint);
    //[cell.feedbackSlider setNeedsDisplay];
   // cell.labl.text=[NSString stringWithFormat:@"row %f",cell.feedbackSlider.myint];
    
    return cell;
    
}


-(void)callWebService{
    
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"now",@"current_timestamp",@"0",@"page", nil];
    
    [RequestManager getFromServer:@"questions_list" parameters:dict completionHandler:^(NSDictionary *responseDict) {
        
        if ([[responseDict valueForKey:@"error"] isEqualToString:@"1"]) {
           
            return ;
        }
        
        NSArray *dataArray=[responseDict valueForKey:@"data"];
        
        NSLog(@"prestn count =%lu",(unsigned long)dataArray.count);
       
        
       // hieghtLabel=(TestTableViewCell*)[self.tableV dequeueReusableCellWithIdentifier:@"TestTableViewCell"];
        
        
        for (NSDictionary *dic in dataArray) {
            QuestionsList *list=[[QuestionsList alloc]init];
            
            list.qId=[dic valueForKey:@"question_id"];
            list.topic=[dic valueForKey:@"question_topic"];
            list.value=[dic valueForKey:@"question_value"];
            list.value = [list.value stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            list.answersCount_time=[[[dic valueForKey:@"question_answer_count"] stringByAppendingString:@" Answers :-"] stringByAppendingString:[dic valueForKey:@"question_created_timestamp"]];
            list.imageUrl=[dic valueForKey:@"user_profile_image_url"];
            
            
            hieghtLabel.tLabel.text=list.value;
            CGSize maximumLabelSize = CGSizeMake(hieghtLabel.tLabel.frame.size.width, 9999); // this width will be as per your requirement
            
            CGSize expectedSize = [hieghtLabel.tLabel sizeThatFits:maximumLabelSize];
            
            
            list.rowHeight=expectedSize.height+49;
            if (list.rowHeight<120) {
                list.rowHeight=120;
            }
            [questionArray addObject:list];
            [questionArray addObject:list];
        }
        //[_tableV reloadData];
        
            }];
    
    
    
}

- (void)chat:(THChatInput*)input sendWasPressed:(NSString*)text{
    NSLog(@"text");
}
@end
