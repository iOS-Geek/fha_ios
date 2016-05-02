//
//  TrackingCell.h
//  FitHealthy
//
//  Created by MacBook on 03/08/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TrackingDetails;


@protocol TrackingCellProtoCol <NSObject>

@optional

-(void)returnedPosition:(int)position;
-(void)returnScrollRect:(CGRect)rext post:(int)postion;

@end



@interface TrackingCell : UITableViewCell<UITextFieldDelegate>




@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic,retain)TrackingDetails *trackDetails;
@property(strong,nonatomic)id<TrackingCellProtoCol>delegate;
@property (nonatomic,assign) BOOL IsLast;
@property (nonatomic,assign) int position;
@property (weak, nonatomic) IBOutlet UILabel *topicLabel;


@end
