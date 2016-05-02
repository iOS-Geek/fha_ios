//
//  CoachSignUpController.m
//  FitHealthy
//
//  Created by MacBook on 22/07/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import "CoachSignUpController.h"
#import "FHAppDelegate.h"
static const CGFloat ANIMATION_DURATION = 0.4;
static const CGFloat LITTLE_SPACE = 5  ;
CGFloat animatedDistance;
 CGSize keyboardSize;


@interface CoachSignUpController ()

@end

@implementation CoachSignUpController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(tapScreen:)];// outside textfields
    
    [self.view addGestureRecognizer:tapGesture];
    // set text fields return key type to Next, last text field to Done
    [usernameTextField setReturnKeyType:UIReturnKeyNext];
    [phoneTextField setReturnKeyType:UIReturnKeyNext];
    [emailTextField setReturnKeyType:UIReturnKeyNext];
    //[descriptionTextView setReturnKeyType:UIReturnKeyDone];
    keyboardSize=CGSizeMake(0, 244);
    //self.automaticallyAdjustsScrollViewInsets = NO;
    // add keyboard notification
    maleImageView.image=[UIImage imageNamed:@"selectedButton"];
    femaleImageView.image=[UIImage imageNamed:@"unSelectedButton"];
    Gender=true;
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
    if([usernameTextField isFirstResponder])[usernameTextField resignFirstResponder];
   // ...
    if([phoneTextField isFirstResponder])[phoneTextField  resignFirstResponder];
    if([emailTextField isFirstResponder])[emailTextField  resignFirstResponder];
    if ([descriptionTextView isFirstResponder]) {
        [descriptionTextView resignFirstResponder];
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField.returnKeyType==UIReturnKeyNext) {
        
        if (textField == usernameTextField) {
            [phoneTextField becomeFirstResponder];
        }
        else if (textField==phoneTextField){
            [emailTextField becomeFirstResponder];
        }
        else{
            
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [descriptionTextView becomeFirstResponder];
            });
        }
        
        //        UIView *next = [[textField superview] viewWithTag:textField.tag+1];
       // [next becomeFirstResponder];
    } else if (textField.returnKeyType==UIReturnKeyDone || textField.returnKeyType==UIReturnKeyDefault) {
        [textField resignFirstResponder];
    }
    return YES;
}

// Moving current text field above keyboard
-(BOOL) textFieldShouldBeginEditing:(UITextField*)textField{
    CGRect viewFrame = self.view.frame;
    CGRect textFieldRect = [self.view.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect = [self.view.window convertRect:self.view.bounds fromView:self.view];
    CGFloat textFieldBottomLine = textFieldRect.origin.y + textFieldRect.size.height + LITTLE_SPACE;//
    
    CGFloat keyboardHeight = keyboardSize.height;
    
    BOOL isTextFieldHidden = textFieldBottomLine > (viewRect.size.height - keyboardHeight)? TRUE :FALSE;
    if (isTextFieldHidden) {
        animatedDistance = textFieldBottomLine - (viewRect.size.height - keyboardHeight) ;
        viewFrame.origin.y -= animatedDistance;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:ANIMATION_DURATION];
        [self.view setFrame:viewFrame];
        [UIView commitAnimations];
    }
    return YES;
}

-(void) restoreViewFrameOrigionYToZero{
    CGRect viewFrame = self.view.frame;
    if (viewFrame.origin.y != 64) {
        viewFrame.origin.y = 64;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:ANIMATION_DURATION];
        [self.view setFrame:viewFrame];
        [UIView commitAnimations];
    }
}

-(void)keyboardDidShow:(NSNotification*)aNotification{
    NSDictionary* info = [aNotification userInfo];
    keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
}

-(void)keyboardDidHide:(NSNotification*)aNotification{
    [self restoreViewFrameOrigionYToZero];// keyboard is dismissed, restore frame view to its  zero origin
}


-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@"Describe your speciality"])
    {
        [textView setTextColor:[UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1.0f]];
        textView.text=nil;
        textView.text=[textView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    //NSLog(@"b=%@",textView.text);
    CGRect viewFrame = self.view.frame;
    CGRect textFieldRect = [self.view.window convertRect:textView.bounds fromView:textView];
    CGRect viewRect = [self.view.window convertRect:self.view.bounds fromView:self.view];
    CGFloat textFieldBottomLine = textFieldRect.origin.y + textFieldRect.size.height + LITTLE_SPACE;//
    
    CGFloat keyboardHeight = keyboardSize.height;
    
    BOOL isTextFieldHidden = textFieldBottomLine > (viewRect.size.height - keyboardHeight)? TRUE :FALSE;
    if (isTextFieldHidden) {
        animatedDistance = textFieldBottomLine - (viewRect.size.height - keyboardHeight) ;
        viewFrame.origin.y -= animatedDistance;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:ANIMATION_DURATION];
        [self.view setFrame:viewFrame];
        [UIView commitAnimations];
    }
    return YES;
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    if ([textView.text stringByReplacingOccurrencesOfString:@" " withString:@""].length==0) {
        textView.text=@"Describe your speciality";
        [textView setTextColor:[UIColor colorWithRed:198/255.0 green:198/255.0 blue:203/255.0 alpha:1.0f]];
        
    }
    [self restoreViewFrameOrigionYToZero];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
//    if ([text isEqualToString:@"\n"])
//    {
//        [textView resignFirstResponder];
//    }
//    else
//    if (range.location == textView.text.length && [text isEqualToString:@" "]) {
//        // ignore replacement string and add your own
//        textView.text = [textView.text stringByAppendingString:@"\u00a0"];
//        return NO;
//    }
    // for all other cases, proceed with replacement
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Describe your speciality"])
    {
        [textView setTextColor:[UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1.0f]];
        textView.text=@"";
    }
    
    
}

- (IBAction)femaleButtonPressed:(id)sender {
    maleImageView.image=[UIImage imageNamed:@"unSelectedButton"];
    femaleImageView.image=[UIImage imageNamed:@"selectedButton"];
    Gender=false;
}

- (IBAction)maleButtonPressed:(id)sender {
    maleImageView.image=[UIImage imageNamed:@"selectedButton"];
    femaleImageView.image=[UIImage imageNamed:@"unSelectedButton"];
    Gender=true;
}

- (IBAction)registerButtonPressed:(id)sender {
    
    if (emailTextField.text.length==0 || phoneTextField.text.length==0 || usernameTextField.text.length==0 || descriptionTextView.text.length==0) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Warning!!!" message:@"Please fill all the fields" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        alert.tag=10;
    }
    else{
        [RequestManager getFromServer:@"signup" parameters:[NSMutableDictionary dictionaryWithObjectsAndKeys:usernameTextField.text,@"user_login",emailTextField.text,@"user_email",phoneTextField.text,@"user_primary_contact",descriptionTextView.text,@"user_description",Gender?@"1":@"0",@"user_gender", nil] completionHandler:^(NSMutableDictionary *responseDict) {
            if ([[responseDict valueForKey:@"code"] isEqualToString:@"1"]) {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Success !!!" message:[responseDict valueForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [alert show];
            }
            
        }];
    }
}
@end
