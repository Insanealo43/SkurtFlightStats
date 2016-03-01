//
//  NSObject+additions.m
//  SkurtFlightStats
//
//  Created by Andrew Lopez-Vass on 2/28/16.
//  Copyright © 2016 Andrew Lopez-Vass. All rights reserved.
//

#import "NSObject+additions.h"

@implementation NSObject (additions)

+ (NSString *)className {
    return NSStringFromClass([self class]);
}

- (NSString *)className {
    return [[self class] className];
}

- (BOOL)isSubclassOfClass:(Class)aClass {
    return [[self class] isSubclassOfClass:aClass];
}

@end
