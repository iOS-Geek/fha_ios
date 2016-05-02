//
//  SurveyViewController.m
//  FitHealthy
//
//  Created by MacBook on 22/08/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import "SurveyViewController.h"

@interface SurveyViewController ()<UITextViewDelegate>{
    CGSize   keyboardSize;
    CGFloat animatedDistance;
}
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end

@implementation SurveyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"Survey";
    
    
    
    _messageLabel.text=[[FHDelegate.userInfo.info valueForKey:@"configurations"]
                        valueForKey:@"survey_message"];
    
    
    
    keyboardSize=CGSizeMake(0, 253);
    CGSize maximumLabelSize = CGSizeMake(_messageLabel.frame.size.width, 9999); // this width will be as per your requirement
    
    CGSize expectedSize = [_messageLabel sizeThatFits:maximumLabelSize];
    
    
    if (expectedSize.height>100) {
        _labelHeightConstraint.constant=100;
    }
    else if (expectedSize.height<25){
        _labelHeightConstraint.constant=25;
    }
    
self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(tapScreen:)];// outside textfields
    
    [self.view addGestureRecognizer:tapGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self     selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self      selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidHideNotification
                                                  object:nil];
}


- (IBAction)tapScreen:(UITapGestureRecognizer *)sender {
    [_surveytextView resignFirstResponder];
  }
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
   
    if ([textView.text isEqualToString:@""])
    {
        [textView setTextColor:[UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1.0f]];
        textView.text=nil;
        textView.text=[textView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    //NSLog(@"b=%@",textView.text);
       return YES;
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    if ([textView.text stringByReplacingOccurrencesOfString:@" " withString:@""].length==0) {
        textView.text=@"";
        [textView setTextColor:[UIColor colorWithRed:198/255.0 green:198/255.0 blue:203/255.0 alpha:1.0f]];
        
    }
    [self restoreViewFrameOrigionYToZero];
    return YES;
}


-(void) restoreViewFrameOrigionYToZero{
    CGRect viewFrame = self.view.frame;
    if (viewFrame.origin.y != 64) {
        viewFrame.origin.y = 64;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.4];
        [self.view setFrame:viewFrame];
        [UIView commitAnimations];
    }
}

-(void)keyboardDidShow:(NSNotification*)aNotification{
    NSDictionary* info = [aNotification userInfo];
    keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGRect viewFrame = self.view.frame;
    CGRect textFieldRect = [self.view.window convertRect:_surveytextView.bounds fromView:_surveytextView];
    CGRect viewRect = [self.view.window convertRect:self.view.bounds fromView:self.view];
    CGFloat textFieldBottomLine = textFieldRect.origin.y + textFieldRect.size.height + 5;//
    
    CGFloat keyboardHeight = keyboardSize.height;
    
    BOOL isTextFieldHidden = textFieldBottomLine > (viewRect.size.height - keyboardHeight)? TRUE :FALSE;
    if (isTextFieldHidden) {
        animatedDistance = textFieldBottomLine - (viewRect.size.height - keyboardHeight) ;
        viewFrame.origin.y -= animatedDistance;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.4];
        [self.view setFrame:viewFrame];
        [UIView commitAnimations];
    }

}

-(void)keyboardDidHide:(NSNotification*)aNotification{
    [self restoreViewFrameOrigionYToZero];// keyboard is dismissed, restore frame view to its  zero origin
}

- (IBAction)submitButtonPressed:(id)sender {
    
     NSUserDefaults *defualts=[NSUserDefaults standardUserDefaults];
    [defualts setValue:@"logged" forKey:@"logged"];
    FHDelegate.logged=true;

     NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithObjectsAndKeys:[FHDelegate.userInfo.info valueForKey:@"user_security_hash"],@"user_security_hash",[FHDelegate.userInfo.info valueForKey:@"user_id"],@"user_id",nil];
    [dict setValue:_surveytextView.text forKey:@"survey_remarks"];
    [RequestManager getFromServer:@"survey" parameters:dict completionHandler:^(NSMutableDictionary *responseDict) {
        if ( [[responseDict valueForKey:@"code"] isEqualToString:@"1"]) {
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                                     bundle: nil];
            
            GoalConsultationRoomController *goalRoom = (GoalConsultationRoomController*)[mainStoryboard
                                                                                         instantiateViewControllerWithIdentifier: @"GoalConsultationRoomController"];
            
            self.navigationController.navigationBarHidden=false;
            [self.navigationController pushViewController:goalRoom animated:YES];
        }
        else{
            
        }
    }];
}


@end
