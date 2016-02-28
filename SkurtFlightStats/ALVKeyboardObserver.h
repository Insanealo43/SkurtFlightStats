//
//  ALVKeyboardObserver.h
//  SkurtFlightStats
//
//  Created by Andrew Lopez-Vass on 2/28/16.
//  Copyright © 2016 Andrew Lopez-Vass. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const ALVKeyboardObserverWillShowNotification;
extern NSString *const ALVKeyboardObserverDidShowNotification;
extern NSString *const ALVKeyboardObserverWillHideNotification;
extern NSString *const ALVKeyboardObserverDidHideNotification;

@interface ALVKeyboardObserver : NSObject

@property (readonly) CGRect keyboardRect;
@property (readonly) CGSize inputAccessoryViewSize;
@property (readonly) NSTimeInterval animationDuration;
@property (readonly) NSInteger curve;
@property (readonly) CGSize totalSize;

@property (readonly) BOOL isShowing;
@property (readonly) BOOL isAppearing;
@property (readonly) BOOL isDisappearing;
@property (readonly) BOOL isAnimating;

+ (instancetype)singleton;

@end
