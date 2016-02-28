//
//  FlightSearchViewController.m
//  SkurtFlightStats
//
//  Created by Andrew Lopez-Vass on 2/28/16.
//  Copyright © 2016 Andrew Lopez-Vass. All rights reserved.
//

#import "FlightSearchViewController.h"
#import "ALVTitledTextFieldView.h"
#import "ALVTextField.h"
#import "ALVButton.h"

#import "UIView+additions.h"

static const CGFloat kBorderHeight = 1.5;

@interface FlightSearchViewController ()

@property (weak, nonatomic) IBOutlet ALVTitledTextFieldView *titledTextFieldView;
@property (weak, nonatomic) IBOutlet ALVButton *searchButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ConstraintButtonBottomMargin;
@property (assign, nonatomic) CGFloat constant;

@end

@implementation FlightSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_titledTextFieldView addTopBorderWithHeight:kBorderHeight andColor:[UIColor colorFromHexString:ColorBorderHex]];
    [_titledTextFieldView addBottomBorderWithHeight:kBorderHeight andColor:[UIColor colorFromHexString:ColorBorderHex]];
    [_titledTextFieldView.textField setAutocorrectionType:UITextAutocorrectionTypeNo];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:ALVKeyboardObserverWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:ALVKeyboardObserverWillHideNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _constant = _ConstraintButtonBottomMargin.constant;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    _ConstraintButtonBottomMargin.constant = [ALVKeyboardObserver singleton].keyboardRect.size.height;
    [self.view setNeedsUpdateConstraints];
    
    [UIView animateAlongsideKeyboard:^{
        [self.view layoutIfNeeded];
    } completion:nil];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    _ConstraintButtonBottomMargin.constant = _constant;
    [self.view setNeedsUpdateConstraints];
    
    [UIView animateAlongsideKeyboard:^{
        [self.view layoutIfNeeded];
    } completion:nil];
}

- (IBAction)searchTapped:(UIButton *)sender {
    if ([_titledTextFieldView.textField isFirstResponder]) {
        [_titledTextFieldView.textField resignFirstResponder];
    }
}

@end
