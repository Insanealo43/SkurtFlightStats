//
//  ALVViewController.h
//  SkurtFlightStats
//
//  Created by Andrew Lopez-Vass on 2/27/16.
//  Copyright © 2016 Andrew Lopez-Vass. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALVViewController : UIViewController

// Override these methods for Keyboard Observance Notifications
- (void)keyboardWillShow:(NSNotification *)notification;
- (void)keyboardWillHide:(NSNotification *)notification;

@end
