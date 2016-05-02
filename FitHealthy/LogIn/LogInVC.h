//
//  LogInVC.h
//  ooVooSdkSampleShow
//
//  Created by Udi on 3/30/15.
//  Copyright (c) 2015 ooVoo LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ooVooSDK/ooVooSDK.h>

#import "AuthorizationLoaderVc.h"


@protocol timerDelegate <NSObject>

-(void)setTimeString:(NSString*)timer;
-(void)timerStopped;

@end

@interface LogInVC : UIViewController <AuthorizationDelegate, ooVooAccount>{
    
}

@property (weak, nonatomic) IBOutlet UIView *viewAuthorization_Container;
@property(nonatomic) NSTimer *timer;
@property (nonatomic) NSString*userId;
@property(nonatomic) NSString*conferenceId;
@property(nonatomic) NSString *userName;
@property(nonatomic)NSString *bookingId;
@property(nonatomic)int duration;
@property(nonatomic)id<timerDelegate>timerDelegate;
@property(nonatomic)BOOL feedback;


@property (retain, nonatomic) ooVooClient *sdk;

@end
