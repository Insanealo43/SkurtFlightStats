//
//  ALVTitledTextFieldView.h
//  SkurtFlightStats
//
//  Created by Andrew Lopez-Vass on 2/28/16.
//  Copyright © 2016 Andrew Lopez-Vass. All rights reserved.
//

#import "ALVView.h"

IB_DESIGNABLE
@class ALVTextField;
@interface ALVTitledTextFieldView : ALVView

@property (readonly, weak) UILabel *titleLabel;
@property (readonly, weak) ALVTextField *textField;

@property (nonatomic, strong) IBInspectable UIColor *highlightColor;
@property (nonatomic, strong) IBInspectable NSString *titleText;
@property (nonatomic, strong) IBInspectable UIColor *titleColor;
@property (nonatomic, strong) IBInspectable UIColor *textFieldTextColor;
@property (nonatomic, strong) IBInspectable NSString *placeholderText;

// Defaults to 'YES'; When enabled, tapping anywhere inside the view will set the textField as first responder
@property (nonatomic, assign) IBInspectable BOOL enableViewTap;

- (void)textFieldShouldBecomeFirstResponder;

@end
