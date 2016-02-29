//
//  UIView+additions.h
//  SkurtFlightStats
//
//  Created by Andrew Lopez-Vass on 2/28/16.
//  Copyright © 2016 Andrew Lopez-Vass. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (additions)

+ (void)animateAlongsideKeyboard:(VoidBlock)animations completion:(SuccessBlock)completion;

@end
