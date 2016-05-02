//
//  UIColor+FHColor.m
//  FitHealthy
//
//  Created by MacBook on 19/07/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import "UIColor+FHColor.h"

@implementation UIColor (FHColor)


+(UIColor*) FHThemeColor{
    return [UIColor colorWithRed:152.0/255.0 green:195.0/255.0 blue:71.0/255.0 alpha:1.0];
}

+(UIColor*) FHBackgroundColor{
    return [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0];
}

+(UIColor*) FHBackgroundFieldColor{
    return [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1.0];
}
@end
