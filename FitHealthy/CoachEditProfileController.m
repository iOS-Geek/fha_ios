//
//  CoachEditProfileController.m
//  FitHealthy
//
//  Created by MacBook on 31/07/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import "CoachEditProfileController.h"

@interface CoachEditProfileController ()<VSDropdownDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate>{
    NSMutableArray *pickerOneData;
    NSMutableArray *pickerIds;
    NSString *Gender;
    CGSize keyboardSize;
    CGFloat animatedDistance;
}

@end

@implementation CoachEditProfileController

- (void)viewDidLoad {
    [super viewDidLoad];
    pickerOneData=[NSMutableArray array];
    pickerIds=[NSMutableArray array];
    dropDownVar = [[VSDropdown alloc]initWithDelegate:self];
    [dropDownVar setAdoptParentTheme:YES];
    [dropDownVar setShouldSortItems:YES];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    dropDownVar.controlRemovalManually=true;
    _doneButton.hidden=true;
    _dropdownImage.hidden=false;
    
    UITapGestureRecognizer *gesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeKeyBoard)];
    [self.view addGestureRecognizer:gesture];
    [self updateView];
    
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

    self.title=@"Edit Profile";
   
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)removeKeyBoard{
    [_firstName resignFirstResponder];
    [_lastName resignFirstResponder];
    [_selectedTexts resignFirstResponder];
    [_firstName resignFirstResponder];
    [_lastName resignFirstResponder];
    [_userNameTextField resignFirstResponder];

    [self doneButtonPressed:[[UIButton alloc]init]];
}

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return NO;
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
    
   
    
    _firstName.text=[FHDelegate.userInfo.info valueForKey:@"user_first_name"];
    _lastName.text=[FHDelegate.userInfo.info valueForKey:@"user_last_name"];
    _selectedTexts.text=[FHDelegate.userInfo.info valueForKey:@"user_description"];
    _userNameTextField.text=[FHDelegate.userInfo.info valueForKey:@"user_login"];
    
    if (_firstName.text.length>0) {
        _firstName.userInteractionEnabled=false;
    }
    if (_lastName.text.length>0) {
        _lastName.userInteractionEnabled=false;
    }
    
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
    
    
    if ([textView.text isEqualToString:[FHDelegate.userInfo.info valueForKey:@"user_description"]])
    {
        [textView setTextColor:[UIColor darkGrayColor]];
    }
    
    
    [_firstName resignFirstResponder];
    [_lastName resignFirstResponder];
    [_userNameTextField resignFirstResponder];
    
    [self doneButtonPressed:[[UIButton alloc]init]];
    //NSLog(@"b=%@",textView.text);
    return YES;
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    if ([textView.text stringByReplacingOccurrencesOfString:@" " withString:@""].length==0) {
        textView.text=[FHDelegate.userInfo.info valueForKey:@"user_description"];
        
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
    
    
    if (![_selectedTexts isFirstResponder]) {
        return;
    }
    keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGRect viewFrame = self.view.frame;
    CGRect textFieldRect = [self.view.window convertRect:_selectedTexts.bounds fromView:_selectedTexts];
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

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self     selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self      selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}


-(void)viewWillDisappear:(BOOL)animated{
     [dropDownVar remove];
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidHideNotification
                                                  object:nil];
}


-(void)showDropDownForButton:(UILabel* )sender adContents:(NSArray *)contents multipleSelection:(BOOL)multipleSelection
{
    [dropDownVar setDrodownAnimation:rand()%2];
    
    [dropDownVar setAllowMultipleSelection:multipleSelection];
    
    [dropDownVar setupDropdownForView:sender];
    
    [dropDownVar setSeparatorColor:[UIColor lightGrayColor]];
    
    if (dropDownVar.allowMultipleSelection)
    {
        [dropDownVar reloadDropdownWithContents:contents andSelectedItems:dropDownVar.selectedItems];
        
    }
    else
    {
        [dropDownVar reloadDropdownWithContents:contents andSelectedItems:@[sender.text]];
        
    }
    
    
    
}


- (void)dropdown:(VSDropdown *)dropDown didSelectValue:(NSString *)str atIndex:(NSUInteger)index
{
    if ([dropDown.dropDownView isKindOfClass:[UIButton class]])
    {
        //UIButton *btn = (UIButton *)dropDown.dropDownView;
       // [btn setTitle:str forState:UIControlStateNormal];
        //if (btn.tag==1) {
           // monthField.text=[pickerOneData objectAtIndex:index];
        //}else if(btn.tag==2){
       //     yearField.text=[pickerTwoData objectAtIndex:index];
        //}
        
        
    }
    
}

- (void)dropdown:(VSDropdown *)dropDown didChangeSelectionForValue:(NSString *)str atIndex:(NSUInteger)index selected:(BOOL)selected
{
//    UITextField *btn = (UITextField *)dropDown.dropDownView;
//    if (btn.tag==1) {
//        monthField.text=[pickerOneData objectAtIndex:index];
//    }else if(btn.tag==2){
//        yearField.text=[pickerTwoData objectAtIndex:index];
//    }
    NSLog(@"%@",dropDownVar.selectedItems);
}

- (UIColor *)outlineColorForDropdown:(VSDropdown *)dropdown
{
    return [UIColor lightGrayColor];
}

- (CGFloat)outlineWidthForDropdown:(VSDropdown *)dropdown
{
    return 1.0;
}

- (CGFloat)cornerRadiusForDropdown:(VSDropdown *)dropdown
{
    return 5.0;
}

- (CGFloat)offsetForDropdown:(VSDropdown *)dropdown
{
    return 0.0;
}


- (IBAction)doneButtonPressed:(id)sender {
    _doneButton.hidden=true;
    _dropdownImage.hidden=false;
    [dropDownVar remove];
    NSLog(@"adaf%@",dropDownVar.selectedItems);
    if (!dropDownVar.selectedItems.count){
        _skillLabel.text=@"  Select Skills ";
        return;
    }
    
    for (int i=0;i< dropDownVar.selectedItems.count;i++) {
        int index= (int)[pickerOneData indexOfObject:[dropDownVar.selectedItems objectAtIndex:i]];
        NSLog(@"id value=%@",[pickerIds objectAtIndex:index]);
    }
    
    NSString *stringToShow=[dropDownVar.selectedItems componentsJoinedByString:@","];
    _skillLabel.text=stringToShow;

    
}

- (IBAction)selectSkillsButtonPressed:(UIButton *)sender{
    
    [_firstName resignFirstResponder];
    [_lastName resignFirstResponder];
    [_userNameTextField resignFirstResponder];
    [self getskills];
    
}



-(void)getskills{
    
    
    [_firstName resignFirstResponder];
    [_lastName resignFirstResponder];
    [_selectedTexts resignFirstResponder];
    [_userNameTextField resignFirstResponder];
    
    [self doneButtonPressed:[[UIButton alloc]init]];
    
    if (pickerOneData.count) {
        _doneButton.hidden=false;
        _dropdownImage.hidden=true;
        NSLog(@"%@ abc count",dropDownVar.selectedItems);
        [self showDropDownForButton:_skillLabel adContents:pickerOneData multipleSelection:YES];
        return;
    }
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"now",@"current_timestamp", nil];
    
    [RequestManager getFromServer:@"skills" parameters:dict completionHandler:^(NSDictionary *responseDict) {
        
        if ([[responseDict valueForKey:@"code"] isEqualToString:@"1"]) {
            
            NSArray *dataArray=[responseDict valueForKey:@"data"];
            for (NSDictionary *dic in dataArray) {
                
                [pickerOneData addObject:[dic valueForKey:@"skill_name"]];
                [pickerIds addObject:[dic valueForKey:@"skill_id"]];
                
            }
            _doneButton.hidden=false;
             _dropdownImage.hidden=true;
            NSLog(@"%@ abc count",dropDownVar.selectedItems);
            if (pickerOneData.count) {
                
            [self showDropDownForButton:_skillLabel adContents:pickerOneData multipleSelection:YES];
               
        }
        
        }
        else if ([[responseDict valueForKey:@"code"] isEqualToString:@"0"]) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error !!!" message:[responseDict valueForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
        }
        
    }];
}
- (IBAction)imageButtonPressed:(id)sender {
    [self removeKeyBoard];
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Choose Profile Image"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"Take Photo",@"Choose Existing", nil];
    sheet.tag=1;
    
    [sheet showInView:self.view];
}

- (IBAction)updateButtonPressed:(id)sender {
    
    if (_firstName.text.length==0 || _lastName.text.length==0 || _userNameTextField.text.length==0 || _selectedTexts.text.length==0)  {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please Fill All the Fields." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    else if (!dropDownVar.selectedItems.count){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please Select atleast one skill" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    else{
        
        NSString *skillsString=@"";
        NSMutableArray *forString=[NSMutableArray array];
        for (int i=0;i< dropDownVar.selectedItems.count;i++) {
            int index= (int)[pickerOneData indexOfObject:[dropDownVar.selectedItems objectAtIndex:i]];
            NSLog(@"id value=%@",[pickerIds objectAtIndex:index]);
            [forString addObject:[pickerIds objectAtIndex:index]];
        }
        skillsString=[forString componentsJoinedByString:@","];
        
        NSString *userGender=@"";
        
        if ([Gender isEqualToString:@"0"]) {
            userGender=@"female";
        }
        else{
             userGender=@"male";
        }
        
        NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithObjectsAndKeys:[FHDelegate.userInfo.info valueForKey:@"user_security_hash"],@"user_security_hash",[FHDelegate.userInfo.info valueForKey:@"user_id"],@"user_id",_firstName.text,@"user_first_name",_lastName.text,@"user_last_name",_selectedTexts.text,@"user_description",skillsString,@"skills_id",userGender,@"user_gender",_userNameTextField.text,@"user_login", nil];
        
        
        
        
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

#pragma mark -
#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex

{
    BOOL cameraAvailable = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    BOOL libraryAvailable = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
    int i = (int)buttonIndex;
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
            _profileImage.image=nil;
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
