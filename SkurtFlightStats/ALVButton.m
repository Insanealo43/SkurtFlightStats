//
//  ALVButton.m
//  SkurtFlightStats
//
//  Created by Andrew Lopez-Vass on 2/28/16.
//  Copyright © 2016 Andrew Lopez-Vass. All rights reserved.
//

#import "ALVButton.h"

@interface ALVButton ()

@property (nonatomic, strong) UIColor *originalBackgroundColor;

@end

@implementation ALVButton

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    _originalBackgroundColor = backgroundColor;
}

- (void)setHighlightBackgroundColor:(UIColor *)highlightBackgroundColor {
    _highlightBackgroundColor = highlightBackgroundColor ? highlightBackgroundColor : _originalBackgroundColor;
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    [super setBackgroundColor:highlighted ? _highlightBackgroundColor : _originalBackgroundColor];
}

@end
