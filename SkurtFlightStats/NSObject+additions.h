//
//  NSObject+additions.h
//  SkurtFlightStats
//
//  Created by Andrew Lopez-Vass on 2/28/16.
//  Copyright © 2016 Andrew Lopez-Vass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (additions)

+ (NSString *)className;
- (NSString *)className;

- (BOOL)isSubclassOfClass:(Class)aClass;

@end
