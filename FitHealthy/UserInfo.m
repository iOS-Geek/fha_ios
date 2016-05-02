//
//  UserInfo.m
//
//
//  Created by MacBook on 02/07/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

@synthesize info;

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.info forKey:@"info"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.info = [decoder decodeObjectForKey:@"info"];
    }
    return self;
}
@end
