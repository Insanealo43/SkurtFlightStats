//
//  NSData+additions.m
//  SkurtFlightStats
//
//  Created by Andrew Lopez-Vass on 2/28/16.
//  Copyright © 2016 Andrew Lopez-Vass. All rights reserved.
//

#import "NSData+additions.h"

@implementation NSData (additions)

- (NSDictionary *)json {
    NSError *err;
    NSString *responseString = [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
    NSData *jsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
    
    return [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingMutableContainers error:&err];
}

@end
