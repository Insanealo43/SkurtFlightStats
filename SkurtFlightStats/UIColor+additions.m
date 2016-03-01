//
//  UIColor+additions.m
//  SkurtFlightStats
//
//  Created by Andrew Lopez-Vass on 2/28/16.
//  Copyright © 2016 Andrew Lopez-Vass. All rights reserved.
//

#import "UIColor+additions.h"

NSString *const ColorTitleTextHex = @"#393939";
NSString *const ColorActionButtonHex = @"#633F7D";
NSString *const ColorActionButtonHighlightedHex = @"#744896";
NSString *const ColorBorderHex = @"#E4E4E4";
NSString *const ColorInputHighlightHex = @"#EBEBEB";

@implementation UIColor (additions)

+ (UIColor *)colorFromHexString:(NSString *)hex {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hex];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

@end
