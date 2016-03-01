//
//  AirlinesManager.m
//  SkurtFlightStats
//
//  Created by Andrew Lopez-Vass on 2/29/16.
//  Copyright © 2016 Andrew Lopez-Vass. All rights reserved.
//

#import "AirlinesManager.h"
#import "FlightStatsHTTPReqest.h"

@interface AirlinesManager ()

@property (nonatomic, strong) NSMutableArray *airlines;
@property (nonatomic, strong) NSMutableDictionary *airlinesMapping;

@property (nonatomic, strong) NSArray *airlineCodes;
@property (nonatomic, strong) NSArray *airlineNames;

@end

@implementation AirlinesManager

+ (instancetype)manager {
    static AirlinesManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[AirlinesManager alloc] init];
        _sharedManager.airlines = [NSMutableArray array];
        _sharedManager.airlinesMapping = [NSMutableDictionary dictionary];
    });
    return _sharedManager;
}

- (void)fetchActiveAirlinesWithCompletion:(VoidBlock)block {
    [_airlines removeAllObjects];
    [_airlinesMapping removeAllObjects];
    
    FlightStatsHTTPReqest *request = [[FlightStatsHTTPReqest alloc] init];
    request.apiName = @"airlines";
    request.requiredParams = @"all";
    
    [request fireWithCompletion:^{
        _airlines = [request.response objectForKey:@"airlines"];
        _airlineCodes = [_airlines valueForKey:@"fs"];
        _airlineNames = [_airlines valueForKey:@"name"];
        
        for (NSDictionary *airlineInfo in _airlines) {
            NSString *code = [airlineInfo objectForKey:@"fs"];
            NSString *name = [airlineInfo objectForKey:@"name"];
            
            if (code && name) {
                [_airlinesMapping setObject:name forKey:code];
            }
        }
        
        if (block) block();
    }];
}

- (NSString *)airlineNameForCode:(NSString *)airlineCode {
    return [_airlinesMapping objectForKey:airlineCode];
}

- (NSString *)airlineCodeForName:(NSString *)airlineName {
    return [[_airlinesMapping allKeysForObject:airlineName] firstObject];
}

- (NSArray *)airlineNamesForSearchText:(NSString *)searchText {
    if ([searchText length] > 1) {
        NSMutableArray *matches = [NSMutableArray array];
        for (NSString *code in _airlineCodes) {
            if ([code rangeOfString:searchText].location != NSNotFound) {
                NSString *nameFromCode = [self airlineNameForCode:code];
                if (nameFromCode) {
                    [matches addObject:nameFromCode];
                }
            }
        }
        
        for (NSString *name in _airlineNames) {
            if ([name rangeOfString:searchText options:NSCaseInsensitiveSearch].location != NSNotFound) {
                if (![matches containsObject:name]) {
                    [matches addObject:name];
                }
            }
        }
        return matches;
    }
    return nil;
}

@end
