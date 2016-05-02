//
//  ooVooClientApi.h
//  ooVooSdk
//
//  Created by Alexander Balasanov on 10/30/14.
//  Copyright (c) 2014 ooVoo. All rights reserved.
//

#ifndef ooVooSdk_ooVooClientApi_h
#define ooVooSdk_ooVooClientApi_h

#import "SdkResult.h"

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
typedef UIImage Avatar;
#else
#import <AppKit/AppKit.h>
typedef NSImage Avatar;
#endif

#ifndef NS_ENUM
#import <Foundation/Foundation.h>
#endif
typedef NS_ENUM(int, GenderType) {
    Female,
    Male
};

typedef NS_ENUM(int, AccountState) {
    AccountLoggedIn,
    AccountLoggedOut
};

typedef NS_ENUM(int, LogLevel) {
    LogLevelNone = 0,
    LogLevelFatal = 1,
    LogLevelError = 2,
    LogLevelWarning = 3,
    LogLevelInfo = 4,
    LogLevelDebug = 5,
    LogLevelTrace = 6
};

typedef NS_ENUM(int, FriendPrecense) {
    FriendAvailabe = 2,
    FriendBusy = 1,
    FriendAway = 4,
    FriendInvisible,
    FriendUnavailabe
};

typedef NS_ENUM(int, FriendNegotationType) {
    NegotationUndefined,
    NegotationSubscribe,
    NegotationSubscribed,
    NegotationUnsubscribe,
    NegotationUnsubscribed
};

typedef void (^CompletionHandler)(SdkResult *result);

#endif
