//
//  UIView+additions.m
//  SkurtFlightStats
//
//  Created by Andrew Lopez-Vass on 2/28/16.
//  Copyright © 2016 Andrew Lopez-Vass. All rights reserved.
//

#import "UIView+additions.h"

@implementation UIView (additions)

+ (void)animateAlongsideKeyboard:(VoidBlock)animations completion:(CompletionBlock)completion {
    if ([[ALVKeyboardObserver singleton] isAnimating]) {
        [UIView animateWithDuration:[ALVKeyboardObserver singleton].animationDuration animations:animations completion:completion];
    }
}

@end
