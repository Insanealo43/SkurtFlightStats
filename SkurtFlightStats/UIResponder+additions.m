//
//  UIResponder+additions.m
//  SkurtFlightStats
//
//  Created by Andrew Lopez-Vass on 2/28/16.
//  Copyright © 2016 Andrew Lopez-Vass. All rights reserved.
//

#import "UIResponder+additions.h"

static __weak id currentFirstResponder;

@implementation UIResponder (additions)

+ (id)firstResponder {
    // Clear stale responder pointer
    currentFirstResponder = nil;
    
    // Sending an action to 'nil' sends it to the first responder
    [[UIApplication sharedApplication] sendAction:@selector(identifyFirstResponder:) to:nil from:nil forEvent:nil];
    
    // Return identified responder
    return currentFirstResponder;
}

- (void)identifyFirstResponder:(id)sender {
    // Only the first object in the responder chain will receive and handle the fired action to 'nil'
    currentFirstResponder = self;
}

@end
