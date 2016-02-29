//
//  ALVAirlineTableViewCell.m
//  SkurtFlightStats
//
//  Created by Andrew Lopez-Vass on 2/29/16.
//  Copyright © 2016 Andrew Lopez-Vass. All rights reserved.
//

#import "ALVAirlineTableViewCell.h"

@interface ALVAirlineTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *airlineLabel;

@end

@implementation ALVAirlineTableViewCell

- (void)setAirlineText:(NSString *)airlineText {
    _airlineText = airlineText;
    _airlineLabel.text = airlineText;
}

@end
