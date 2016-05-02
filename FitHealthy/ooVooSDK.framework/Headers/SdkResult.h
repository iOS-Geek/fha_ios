//
//  ooVooSdkResult.h
//  ooVooSdk
//
//  Created by Alexander Balasanov on 10/30/14.
//  Copyright (c) 2014 ooVoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "errors_objc.h"
#define kRequestResult "kRequestResult"

@class OutgoingMessage;
@class ChatGroupMessage;
@protocol ChatGroup;

@interface SdkResult : NSObject

@property (atomic, readonly, getter=Result) sdk_error Result;
@property (atomic, readonly) NSDictionary *userInfo;

@end

@interface ooVooSdkApiNotInited : SdkResult
@end

@interface ooVooSdkNotLoggedIn : SdkResult
@end

//@interface ChatGroupMessageSendResult : SdkResult
//@property (atomic,getter=isSent)     BOOL isSent;
//@property (atomic,getter=message)    ChatGroupMessage* message;
//@end
//
//
//@interface ChatGroupCreateResult : SdkResult
//@property (atomic,getter=group)    id<ChatGroup> group;
//@end
