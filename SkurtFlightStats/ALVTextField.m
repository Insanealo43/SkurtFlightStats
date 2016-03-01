//
//  ALVTextField.m
//  SkurtFlightStats
//
//  Created by Andrew Lopez-Vass on 2/28/16.
//  Copyright © 2016 Andrew Lopez-Vass. All rights reserved.
//

#import "ALVTextField.h"

static const double kDefaultDelay = .25;

@interface ALVTextField ()

@property (nonatomic, strong) NSTimer *textChangeTimer;
@property (nonatomic, strong) NSString *delayedText;

@end

@implementation ALVTextField

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupTextField];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupTextField];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupTextField];
    }
    return self;
}

- (void)setupTextField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startedEditing:) name:UITextFieldTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editied:) name:UITextFieldTextDidChangeNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endedEditing:) name:UITextFieldTextDidEndEditingNotification object:self];
    
    _textChangeDelay = kDefaultDelay;
}

- (void)startedEditing:(NSNotification *)notification {
    
}

- (void)editied:(NSNotification *)notification {
    [_textChangeTimer invalidate];
    _textChangeTimer = [NSTimer scheduledTimerWithTimeInterval:_textChangeDelay target:self selector:@selector(timerUpdate:) userInfo:(self.text ? @{@"text" : self.text} : nil) repeats:NO];
}

- (void)endedEditing:(NSNotification *)notification {
    
}

- (void)timerUpdate:(NSTimer *)timer {
    self.delayedText = [timer.userInfo objectForKey:@"text"];
}

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
