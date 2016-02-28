//
//  ALVViewController.m
//  SkurtFlightStats
//
//  Created by Andrew Lopez-Vass on 2/27/16.
//  Copyright © 2016 Andrew Lopez-Vass. All rights reserved.
//

#import "ALVViewController.h"

@interface ALVViewController ()

@end

@implementation ALVViewController

- (BOOL)prefersStatusBarHidden{
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.navigationItem.title) {
        // Need to set the 'titleView' for the controller's 'navigationItem' in order for the 'kern' attribute to be applied
        UILabel *titleLabel = [UILabel new];
        titleLabel.attributedText = [[NSAttributedString alloc] initWithString:self.navigationItem.title attributes:self.navigationController.navigationBar.titleTextAttributes];
        [titleLabel sizeToFit];
        [self.navigationItem setTitleView:titleLabel];
    }
}

- (void)keyboardWillShow:(NSNotification *)notification {
    
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
}

@end
