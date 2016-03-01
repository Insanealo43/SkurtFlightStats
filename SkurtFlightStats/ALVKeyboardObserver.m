//
//  ALVKeyboardObserver.m
//  SkurtFlightStats
//
//  Created by Andrew Lopez-Vass on 2/28/16.
//  Copyright © 2016 Andrew Lopez-Vass. All rights reserved.
//

#import "ALVKeyboardObserver.h"
#import "UIResponder+additions.h"

NSString *const ALVKeyboardObserverWillShowNotification = @"ALVKeyboardObserverWillShowNotification";
NSString *const ALVKeyboardObserverDidShowNotification = @"ALVKeyboardObserverDidShowNotification";
NSString *const ALVKeyboardObserverWillHideNotification = @"ALVKeyboardObserverWillHideNotification";
NSString *const ALVKeyboardObserverDidHideNotification = @"ALVKeyboardObserverDidHideNotification";

@interface ALVKeyboardObserver ()

@property (nonatomic, assign) BOOL isShowing;
@property (nonatomic, assign) BOOL isAppearing;
@property (nonatomic, assign) BOOL isDisappearing;
@property (nonatomic, assign) BOOL isAnimating;

@property (nonatomic, assign) CGRect keyboardRect;
@property (nonatomic, assign) CGSize inputAccessoryViewSize;
@property (nonatomic, assign) NSTimeInterval animationDuration;
@property (nonatomic, assign) NSInteger curve;

@end

@implementation ALVKeyboardObserver

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (instancetype)singleton {
    static ALVKeyboardObserver *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[ALVKeyboardObserver alloc] init];
    });
    return _sharedManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidDisappear:) name:UIKeyboardDidHideNotification object:nil];
    }
    return self;
}

- (CGSize)totalSize {
    return CGSizeMake(_keyboardRect.size.width, _keyboardRect.size.height + _inputAccessoryViewSize.height);
}

- (void)keyboardWillShow:(NSNotification *)notification {
    self.keyboardRect = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    id firstResponder = [UIResponder firstResponder];
    if ([firstResponder isSubclassOfClass:[UIView class]]) {
        self.inputAccessoryViewSize = [(UIView *)firstResponder frame].size;
    }
    
    self.isAppearing = YES;
    self.isAnimating = YES;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ALVKeyboardObserverWillShowNotification object:self];
}

- (void)keyboardDidShow:(NSNotification *)notification {
    self.isAppearing = NO;
    self.isShowing = YES;
    self.isAnimating = NO;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ALVKeyboardObserverDidShowNotification object:self];
}

- (void)keyboardWillDisappear:(NSNotification *)notification {
    self.isDisappearing = YES;
    self.isAnimating = YES;
    
    self.animationDuration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    self.curve = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue] << 16;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ALVKeyboardObserverWillHideNotification object:self];
}

- (void)keyboardDidDisappear:(NSNotification *)notification {
    self.keyboardRect = CGRectZero;
    self.inputAccessoryViewSize = CGSizeZero;
    
    self.animationDuration = 0;
    self.curve = 0;
    
    self.isDisappearing = NO;
    self.isShowing = NO;
    self.isAnimating = NO;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ALVKeyboardObserverDidHideNotification object:self];
}

@end
