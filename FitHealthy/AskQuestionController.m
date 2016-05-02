//
//  AskQuestionController.m
//  FitHealthy
//
//  Created by MacBook on 27/07/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import "AskQuestionController.h"
@class UserInfo;


@interface AskQuestionController ()<UITextViewDelegate,UITextFieldDelegate>{
     UserInfo *userInfo;
}



@property (weak, nonatomic) IBOutlet UITextField *questionField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionView;

- (IBAction)askButtonPressed:(id)sender;


@end

@implementation AskQuestionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"Ask Question";
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(tapScreen:)];// outside textfields
    
    [self.view addGestureRecognizer:tapGesture];
    
    userInfo=[FHDelegate loadCustomObjectWithKey:@"userinfo"];
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
- (IBAction)tapScreen:(UITapGestureRecognizer *)sender {
    
    if([_questionField isFirstResponder])[_questionField resignFirstResponder];
    // ...
    if([_descriptionView isFirstResponder])[_descriptionView  resignFirstResponder];
    
}

#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return NO;
}


#pragma mark - textfield Delegate Methods -

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [_descriptionView becomeFirstResponder];
    });
        return YES;
}


#pragma mark - textview Delegate Methods -

-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    if ([textView.text stringByReplacingOccurrencesOfString:@" " withString:@""].length==0) {
        textView.text=@"Question Description";
        [textView setTextColor:[UIColor colorWithRed:198/255.0 green:198/255.0 blue:203/255.0 alpha:1.0f]];
        
    }
    return YES;
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Question Description"])
    {
        [textView setTextColor:[UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1.0f]];
        textView.text=[[NSString alloc]init];
        [textView setNeedsDisplay];
    }
    
    
}
- (IBAction)askButtonPressed:(id)sender {
    
    if (_questionField.text.length>0 && _descriptionView.text.length>0) {
        
        
        NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithObjectsAndKeys:[userInfo.info valueForKey:@"user_security_hash"],@"user_security_hash",[userInfo.info valueForKey:@"user_id"],@"user_id",_questionField.text,@"question_topic",_descriptionView.text,@"question_value", nil];
        
        [RequestManager getFromServer:@"question" parameters:dict completionHandler:^(NSDictionary *responseDict) {
        
            if ([[responseDict valueForKey:@"code"] isEqualToString:@"1"]) {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Success !!!" message:@"You have asked questions successfully." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                _questionField.text=@"";
                _descriptionView.text=@"Question Description";
                if([_questionField isFirstResponder])[_questionField resignFirstResponder];
                // ...
                if([_descriptionView isFirstResponder])[_descriptionView  resignFirstResponder];
                [alert show];
            }
        
                }];

        
    }else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error !!!" message:@"Please fill the fields ." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
    }
}
@end
