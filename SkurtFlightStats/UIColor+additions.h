//
//  UIColor+additions.h
//  SkurtFlightStats
//
//  Created by Andrew Lopez-Vass on 2/28/16.
//  Copyright © 2016 Andrew Lopez-Vass. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const ColorTitleTextHex;
extern NSString *const ColorActionButtonHex;
extern NSString *const ColorActionButtonHighlightedHex;
extern NSString *const ColorBorderHex;
extern NSString *const ColorInputHighlightHex;

@interface UIColor (additions)

+ (UIColor *)colorFromHexString:(NSString *)hex;

@end
