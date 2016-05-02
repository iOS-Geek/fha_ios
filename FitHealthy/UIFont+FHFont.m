//
//  UIFont+FHFont.m
//  FitHealthy  
//
//  Created by MacBook on 19/07/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import "UIFont+FHFont.h"

@implementation UIFont (FHFont)


+(UIFont*) FHFontWithSize:(CGFloat)size{
    return [UIFont fontWithName:@"HelveticaNeue" size:size];
}

+(UIFont*) FHFontBoldWithSize:(CGFloat)size{
    return [UIFont fontWithName:@"HelveticaNeue-Medium" size:size];
}
@end
