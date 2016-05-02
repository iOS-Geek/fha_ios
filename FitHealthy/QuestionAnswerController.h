//
//  QuestionAnswerController.h
//  FitHealthy
//
//  Created by MacBook on 28/07/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FHAppDelegate.h"
#import "THChatInput.h"
#import "AnswerTableCell.h"
@class THChatInput;

@interface QuestionAnswerController : UIViewController<UITableViewDataSource,UITableViewDelegate,THChatInputDelegate,AnswerCellDelegate>

@property (weak, nonatomic) IBOutlet THChatInput *inputBox;

@property (weak, nonatomic) IBOutlet UITableView *answerTable;
@property(nonatomic,retain) QuestionsList *question;
@property (nonatomic, strong) NSMutableDictionary *imageDownloadsInProgress;



@end
