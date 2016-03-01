//
//  MainViewController.m
//  SkurtFlightStats
//
//  Created by Andrew Lopez-Vass on 2/27/16.
//  Copyright © 2016 Andrew Lopez-Vass. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation MainViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // Fetch all the active airlines before redirecting to our Flight Search Storyboard
    [[AirlinesManager manager] fetchActiveAirlinesWithCompletion:^{
        [self fadeAndRedirect];
    }];
}

- (void)fadeAndRedirect {
    // Add Fade animation
    POPBasicAnimation *fade = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    fade.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    fade.duration = .8f;
    fade.fromValue = @1;
    fade.toValue = @0;
    
    [_imageView pop_addAnimation:fade forKey:@"fade"];
    fade.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        // Change the window's root view controller
        UIViewController *flightSearch = [[UIStoryboard storyboardWithName:@"FlightSearch" bundle:nil] instantiateInitialViewController];
        [[[[UIApplication sharedApplication] delegate] window] setRootViewController:flightSearch];
    };
}

@end
