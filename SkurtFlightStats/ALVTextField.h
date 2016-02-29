//
//  ALVTextField.h
//  SkurtFlightStats
//
//  Created by Andrew Lopez-Vass on 2/28/16.
//  Copyright © 2016 Andrew Lopez-Vass. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALVTextField : UITextField

@property (nonatomic, strong) IBInspectable UIColor *placeholderColor;

@property (readonly) NSTimer *textChangeTimer;
@property (nonatomic, assign) NSTimeInterval textChangeDelay;
@property (nonatomic, readonly) NSString *delayedText;

@end
