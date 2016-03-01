//
//  ALVView.m
//  SkurtFlightStats
//
//  Created by Andrew Lopez-Vass on 2/28/16.
//  Copyright © 2016 Andrew Lopez-Vass. All rights reserved.
//

#import "ALVView.h"

@implementation ALVView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self loadNib];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadNib];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self loadNib];
    }
    return self;
}

- (void)prepareForInterfaceBuilder {
    [self loadNib];
}

- (void)loadNib {
    _nibView = [[[NSBundle bundleForClass:[self class]] loadNibNamed:[self className] owner:self options:nil] firstObject];
    _nibView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _nibView.frame = self.bounds;
    
    [self addSubview:_nibView];
}

@end
