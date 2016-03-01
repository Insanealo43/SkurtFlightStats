//
//  ALVTitledTextFieldView.m
//  SkurtFlightStats
//
//  Created by Andrew Lopez-Vass on 2/28/16.
//  Copyright © 2016 Andrew Lopez-Vass. All rights reserved.
//

#import "ALVTitledTextFieldView.h"
#import "ALVButton.h"
#import "ALVTextField.h"

@interface ALVTitledTextFieldView ()

@property (weak, nonatomic) IBOutlet ALVButton *touchButton;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet ALVTextField *textField;

@property (weak, nonatomic) IBOutlet UIButton *closeButton;

@end

@implementation ALVTitledTextFieldView

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _titleLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:14];
    _textField.font = [UIFont fontWithName:@"Avenir" size:12];
    _textField.placeholderColor = [UIColor colorFromHexString:ColorTitleTextHex];
    
    _textField.enabled = NO;
    _enableViewTap = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldStartedEditing:) name:UITextFieldTextDidBeginEditingNotification object:_textField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldFinishedEditing:) name:UITextFieldTextDidEndEditingNotification object:_textField];
}

- (void)prepareForInterfaceBuilder {
    [super prepareForInterfaceBuilder];
    
    _titleLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:14];
    _textField.font = [UIFont fontWithName:@"Avenir" size:14];
    
    _titleLabel.text = _titleText;
    _titleLabel.textColor = _titleColor;
    _textField.textColor = _textFieldTextColor;
    _textField.placeholder = _placeholderText;
    _touchButton.highlightBackgroundColor = _highlightColor;
}

- (void)setTitleText:(NSString *)titleText {
    _titleText = titleText;
    _titleLabel.text = titleText;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    _titleLabel.textColor = titleColor;
}

- (void)setTextFieldTextColor:(UIColor *)textFieldTextColor {
    _textFieldTextColor = textFieldTextColor;
    _textField.textColor = textFieldTextColor;
}

- (void)setPlaceholderText:(NSString *)placeholderText {
    _placeholderText = placeholderText;
    _textField.placeholder = placeholderText;
}

- (void)setEnableViewTap:(BOOL)enableViewTap {
    _enableViewTap = enableViewTap;
    _touchButton.enabled = enableViewTap;
    _textField.enabled = !enableViewTap;
}

- (IBAction)touchButtonTapped:(UIButton *)sender {
    if (!_textField.isFirstResponder) {
        _textField.enabled = YES;
        [_textField becomeFirstResponder];
    }
}

- (void)textFieldShouldBecomeFirstResponder {
    if (_enableViewTap) {
         [_touchButton sendActionsForControlEvents:UIControlEventTouchUpInside];
        
    } else {
        [_textField becomeFirstResponder];
    }
}

- (IBAction)stopEditing:(UIButton *)sender {
    [_textField resignFirstResponder];
}

- (void)textFieldStartedEditing:(NSNotification *)notification {
    _closeButton.hidden = NO;
}

- (void)textFieldFinishedEditing:(NSNotification *)notification {
    _closeButton.hidden = YES;
    if (_enableViewTap) {
        _textField.enabled = NO;
    }
}

@end
