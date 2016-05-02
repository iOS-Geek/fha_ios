//
//  UserEditProfileController.m
//  FitHealthy
//
//  Created by MacBook on 31/07/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//



#import "UserEditProfileController.h"

static const CGFloat ANIM_DURATION = 0.4;
static const CGFloat LITTL_SPACE = 5  ;
CGFloat animatedDist;
CGSize keyboardsize;


@interface UserEditProfileController ()<UITextFieldDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    NSString* Gender;
}


@property (weak, nonatomic) IBOutlet UIImageView *profileImage;

- (IBAction)imageButtonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;


@property (weak, nonatomic) IBOutlet UITextField *phoneNoTextField;

@property (weak, nonatomic) IBOutlet UIImageView *maleButtonImage;
@property (weak, nonatomic) IBOutlet UIImageView *femaleButtonImage;
- (IBAction)updateButtonPressed:(id)sender;
- (IBAction)femaleButtonPressed:(id)sender;

- (IBAction)maleButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *lastName;


@property (weak, nonatomic) IBOutlet UITextField *firstName;

@property (weak, nonatomic) IBOutlet UIButton *femaleButton;

@property (weak, nonatomic) IBOutlet UIButton *maleButton;

@end

@implementation UserEditProfileController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(tapScreen:)];// outside textfields
    
    [self.view addGestureRecognizer:tapGesture];
    
        self.title=@"Edit Profile";
    
    
    [self updateView];
    
    // Do any additional setup after loading the view.
}


-(void)updateView{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^ {
        
        
        NSString *newImageurl=[FHDelegate.userInfo.info valueForKey:@"user_profile_image_url"];
        //newImageurl=[newImageurl stringByReplacingOccurrencesOfString:@"_small" withString:@""];
        NSData* dataim = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:newImageurl]];
        UIImage* image = [UIImage imageWithData:dataim];
        
        dispatch_async(dispatch_get_main_queue(), ^ {
            _profileImage.image=image;
        });
    });
    
    if ([[FHDelegate.userInfo.info valueForKey:@"user_gender"] isEqualToString:@"0"]) {
        _maleButtonImage.image=[UIImage imageNamed:@"unSelectedButton"];
        _femaleButtonImage.image=[UIImage imageNamed:@"selectedButton"];
        Gender=@"0";
        
    }
    else if ([[FHDelegate.userInfo.info valueForKey:@"user_gender"] isEqualToString:@"1"]){
        _maleButtonImage.image=[UIImage imageNamed:@"selectedButton"];
        _femaleButtonImage.image=[UIImage imageNamed:@"unSelectedButton"];
        Gender=@"1";
    }
    else{
        _maleButtonImage.image=[UIImage imageNamed:@"unSelectedButton"];
        _femaleButtonImage.image=[UIImage imageNamed:@"unSelectedButton"];
        Gender=@"-1";
    }
    
    _userNameTextField.text=[FHDelegate.userInfo.info valueForKey:@"user_login"];
    _emailTextField.text=[FHDelegate.userInfo.info valueForKey:@"user_email"];
    _phoneNoTextField.text=[FHDelegate.userInfo.info valueForKey:@"user_primary_contact"];
    _firstName.text=[FHDelegate.userInfo.info valueForKey:@"user_first_name"];
    _lastName.text=[FHDelegate.userInfo.info valueForKey:@"user_last_name"];
    
    
    if (![Gender isEqualToString:@"-1"]) {
        _maleButton.userInteractionEnabled=false;
        _femaleButton.userInteractionEnabled=false;
    }
    
    if (_firstName.text.length>0) {
        _firstName.userInteractionEnabled=false;
    }
    if (_lastName.text.length>0) {
        _lastName.userInteractionEnabled=false;
    }

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


-(BOOL) textFieldShouldBeginEditing:(UITextField*)textField{
    CGRect viewFrame = self.view.frame;
    CGRect textFieldRect = [self.view.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect = [self.view.window convertRect:self.view.bounds fromView:self.view];
    CGFloat textFieldBottomLine = textFieldRect.origin.y + textFieldRect.size.height + LITTL_SPACE;//
    
    CGFloat keyboardHeight = keyboardsize.height;
    
    BOOL isTextFieldHidden = textFieldBottomLine > (viewRect.size.height - keyboardHeight)? TRUE :FALSE;
    if (isTextFieldHidden) {
        animatedDist = textFieldBottomLine - (viewRect.size.height - keyboardHeight) ;
        viewFrame.origin.y -= animatedDist;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:ANIM_DURATION];
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
        [UIView setAnimationDuration:ANIM_DURATION];
        [self.view setFrame:viewFrame];
        [UIView commitAnimations];
    }
}

-(void)keyboardDidShow:(NSNotification*)aNotification{
    NSDictionary* info = [aNotification userInfo];
    keyboardsize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGRect converted = [self.view.window convertRect:[[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue] fromView:nil];
    keyboardsize = converted.size;
}


-(void)keyboardDidHide:(NSNotification*)aNotification{
    [self restoreViewFrameOrigionYToZero];// keyboard is dismissed, restore frame view to its  zero origin
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

- (IBAction)tapScreen:(UITapGestureRecognizer *)sender {
    
    if([_userNameTextField isFirstResponder])[_userNameTextField resignFirstResponder];
    // ...
    if([_emailTextField isFirstResponder])[_emailTextField  resignFirstResponder];
    if([_phoneNoTextField isFirstResponder])[_phoneNoTextField  resignFirstResponder];
    
}


- (IBAction)imageButtonPressed:(id)sender {
    if([_userNameTextField isFirstResponder])[_userNameTextField resignFirstResponder];
    // ...
    if([_emailTextField isFirstResponder])[_emailTextField  resignFirstResponder];
    if([_phoneNoTextField isFirstResponder])[_phoneNoTextField  resignFirstResponder];
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Choose Profile Image"
                                        delegate:self
                               cancelButtonTitle:@"Cancel"
                          destructiveButtonTitle:nil
                               otherButtonTitles:@"Take Photo",@"Choose Existing", nil];
    sheet.tag=1;
    
    [sheet showInView:self.view];
}


- (IBAction)updateButtonPressed:(id)sender {
    if ([Gender isEqualToString:@"-1"]) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please Select a Gender" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    else{
        NSString *genderSelected=@"";
        if ([Gender isEqualToString:@"0"]) {
            genderSelected=@"female";
        }
        else{
            genderSelected=@"male";
        }
        NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithObjectsAndKeys:[FHDelegate.userInfo.info valueForKey:@"user_security_hash"],@"user_security_hash",[FHDelegate.userInfo.info valueForKey:@"user_id"],@"user_id",_userNameTextField.text,@"user_login",_emailTextField.text,@"user_email",_phoneNoTextField.text,@"user_primary_contact",genderSelected,@"user_gender", nil];
        
        [dict setValue:_firstName.text forKey:@"user_first_name"];
        [dict setValue:_lastName.text forKey:@"user_last_name"];
        
        [RequestManager getFromServer:@"edit_profile" parameters:dict completionHandler:^(NSDictionary *responseDict) {
            
            if ([[responseDict valueForKey:@"code"] isEqualToString:@"1"]) {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Success !!!" message:[responseDict valueForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                
                NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithDictionary:FHDelegate.userInfo.info];
                
                NSArray *dictKeys=[[responseDict valueForKey:@"data"] allKeys];
                
                
                for (NSString *key in dictKeys){
                    if ([dic valueForKey:key]) {
                        
                        [dic setValue:[[responseDict valueForKey:@"data"] valueForKey:key] forKey:key];
                        
                    }
                }
                
                FHDelegate.userInfo.info=dic;
                [FHDelegate saveCustomObject:FHDelegate.userInfo key:@"userinfo"];
                [self updateView];
                LeftMenuViewController*left=(LeftMenuViewController*) [SlideNavigationController sharedInstance].leftMenu;
                [left updateValues];
                alert.tag=1;
                [alert show];
            }
            
        }];
    }
    
}

- (IBAction)femaleButtonPressed:(id)sender {
    if([_userNameTextField isFirstResponder])[_userNameTextField resignFirstResponder];
    // ...
    if([_emailTextField isFirstResponder])[_emailTextField  resignFirstResponder];
    if([_phoneNoTextField isFirstResponder])[_phoneNoTextField  resignFirstResponder];
    _maleButtonImage.image=[UIImage imageNamed:@"unSelectedButton"];
    _femaleButtonImage.image=[UIImage imageNamed:@"selectedButton"];
    Gender=@"0";
    
}

- (IBAction)maleButtonPressed:(id)sender {
    
   
    if([_userNameTextField isFirstResponder])[_userNameTextField resignFirstResponder];
    // ...
    if([_emailTextField isFirstResponder])[_emailTextField  resignFirstResponder];
    if([_phoneNoTextField isFirstResponder])[_phoneNoTextField  resignFirstResponder];
    _maleButtonImage.image=[UIImage imageNamed:@"selectedButton"];
    _femaleButtonImage.image=[UIImage imageNamed:@"unSelectedButton"];
    Gender=@"1";
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField.returnKeyType==UIReturnKeyNext) {
        
        if (textField == _userNameTextField) {
            [_emailTextField becomeFirstResponder];
        }
        else if (textField==_emailTextField){
            [_phoneNoTextField becomeFirstResponder];
        }
        else if (textField==_phoneNoTextField){
            [_phoneNoTextField resignFirstResponder];
        }
    } else if (textField.returnKeyType==UIReturnKeyDone || textField.returnKeyType==UIReturnKeyDefault) {
        [textField resignFirstResponder];
    }
    return YES;
}


#pragma mark -
#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex

{
    BOOL cameraAvailable = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    BOOL libraryAvailable = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
    int i = buttonIndex;
    switch(i)
    {
        case 0:
        {
            UIImagePickerController * picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            if (cameraAvailable) {
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Camera"
                                                         message:@"Please check your camera setting. It's not available."
                                                        delegate:self
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
                [alert show];
                break;
            }
            [self presentViewController:picker animated:YES completion:^{}];
            break;
        }
        case 1:
        {
            UIImagePickerController * picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            if (libraryAvailable) {
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Camera"
                                                         message:@"Please check your Photo library settings. Its not available."
                                                        delegate:self
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
                [alert show];
            }
            [self presentViewController:picker animated:YES completion:^{}];
            break;
        }
        default:
        break;
    }
    
}

#pragma - mark Selecting Image from Camera and Library
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
#pragma mark --------------------------------------
    
    //Dismiss the View Controller
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    //Persist the image
    
    NSData* selectedImage =nil;
    UIImage *image=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    selectedImage = UIImageJPEGRepresentation([image fixOrientation], 0.1);;
    
    //if not image return
    
    if (!selectedImage)
    {
        return;
    }
    
    
    
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithObjectsAndKeys:[FHDelegate.userInfo.info valueForKey:@"user_security_hash"],@"user_security_hash",[FHDelegate.userInfo.info valueForKey:@"user_id"],@"user_id", nil];
    
    [RequestManager postWithImageServer:@"profile_image" parameters:dict image:[UIImage imageWithData:selectedImage] imageName:@"user_profile_image" completionHandler:^(NSDictionary *responseDict) {
        
        if ([[responseDict valueForKey:@"code"] isEqualToString:@"1"]) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Success !!!" message:[responseDict valueForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            
           
            
            
            NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithDictionary:FHDelegate.userInfo.info];
            
            NSArray *dictKeys=[[responseDict valueForKey:@"data"] allKeys];
            
            
            for (NSString *key in dictKeys){
                if ([dic valueForKey:key]) {
                    
                    [dic setValue:[[responseDict valueForKey:@"data"] valueForKey:key] forKey:key];
                    
                }
            }
            
            FHDelegate.userInfo.info=dic;
            [FHDelegate saveCustomObject:FHDelegate.userInfo key:@"userinfo"];
            [self updateView];
            LeftMenuViewController*left=(LeftMenuViewController*) [SlideNavigationController sharedInstance].leftMenu;
            [left updateValues];
            alert.tag=1;
            [alert show];
        }
        
        
    }];
    
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==1) {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                                 bundle: nil];
        
        UIViewController *vc ;
        vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"GoalConsultationRoomController"];
        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
                                                                 withSlideOutAnimation:nil
                                                                         andCompletion:nil];
    }
}

@end
