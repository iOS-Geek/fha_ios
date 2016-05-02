//
//  TrackingCell.m
//  FitHealthy
//
//  Created by MacBook on 03/08/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import "TrackingCell.h"
#import "TrackingDetails.h"

@implementation TrackingCell

- (void)awakeFromNib {
    // Initialization code
    if (_IsLast) {
        _textField.returnKeyType=UIReturnKeyDone;
    }
    else{
        _textField.returnKeyType=UIReturnKeyNext;
    }
    _textField.text=_trackDetails.trackingText;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
    _trackDetails.trackingText=textField.text;
    if (_IsLast) {
        [textField resignFirstResponder];
    }
    else{
        
        if ([_delegate respondsToSelector:@selector(returnedPosition:)]) {
            [_delegate returnedPosition:_position ];
        }
    }
    return YES;
}

// Moving current text field above keyboard
-(BOOL) textFieldShouldBeginEditing:(UITextField*)textField{
    if (_IsLast) {
        _textField.returnKeyType=UIReturnKeyDone;
    }
    else{
        _textField.returnKeyType=UIReturnKeyNext;
    }
    
     _trackDetails.trackingText=textField.text;
    CGRect rxt=textField.frame;
    rxt.origin.y+=30;
    if ([_delegate respondsToSelector:@selector(returnScrollRect:post:)]) {
        [_delegate returnScrollRect:rxt post:_position];
    }
    
    
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    _trackDetails.trackingText=[NSString stringWithFormat:@"%@%@", textField.text, string];
    
    NSLog(@"%d position text=%@",_position,_trackDetails.trackingText);
    return YES;
}


@end
