//
//  ALVNetworker.h
//  SkurtFlightStats
//
//  Created by Andrew Lopez-Vass on 2/27/16.
//  Copyright © 2016 Andrew Lopez-Vass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALVNetworker : NSObject

+ (instancetype)manager;
+ (NSURLSession *)sharedSession;

@end
