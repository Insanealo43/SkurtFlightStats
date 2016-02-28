//
//  ALVTextField.m
//  SkurtFlightStats
//
//  Created by Andrew Lopez-Vass on 2/28/16.
//  Copyright © 2016 Andrew Lopez-Vass. All rights reserved.
//

#import "ALVTextField.h"

@implementation ALVTextField

- (NSDictionary *)placeholderAttributes {
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setValue:_placeholderColor ? _placeholderColor : self.textColor forKey:NSForegroundColorAttributeName];
    [attributes setValue:self.font forKey:NSFontAttributeName];
    
    return attributes;
}

- (void)prepareForInterfaceBuilder {
    [super prepareForInterfaceBuilder];
    [self updateAttributedPlaceholder];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    [self updateAttributedPlaceholder];
}

- (void)updateAttributedPlaceholder {
    NSString *placeholder = self.placeholder ? self.placeholder : @"";
    self.attributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:placeholder attributes:[self placeholderAttributes]];
}

@end
