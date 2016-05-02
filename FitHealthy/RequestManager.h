//
//  RequestManager.h
//  FitHealthy
//
//  Created by MacBook on 19/07/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FHAppDelegate.h"

@interface RequestManager : NSObject


typedef void (^RequestManagerHandler)(NSMutableDictionary* responseDict);

+(void)getFromServer:(NSString*)api parameters:(NSMutableDictionary*)parameters completionHandler:(RequestManagerHandler)handler;

+(void)postWithImageServer:(NSString*)api parameters:(NSMutableDictionary*)parameters  image:(UIImage*)image imageName:(NSString*)imageNamge completionHandler:(RequestManagerHandler)handler;

+(void)sessionLogin:(NSString*)api parameters:(NSMutableDictionary*)parameters completionHandler:(RequestManagerHandler)handler;
+(void)configureApp:(RequestManagerHandler)handler;
@end
