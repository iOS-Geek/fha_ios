//
//  EditProfileController.m
//  FitHealthy
//
//  Created by MacBook on 27/07/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import "EditProfileController.h"

@interface EditProfileController ()

@end

@implementation EditProfileController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"Edit Profile";
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


#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return NO;
}
@end
