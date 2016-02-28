//
//  ALVNetworker.m
//  SkurtFlightStats
//
//  Created by Andrew Lopez-Vass on 2/27/16.
//  Copyright © 2016 Andrew Lopez-Vass. All rights reserved.
//

#import "ALVNetworker.h"

NSString *const FlightStatsApiBaseURI = @"https://api.flightstats.com/flex";

static NSString *const kFlightStatsAppId = @"91b929e6";
static NSString *const kFlightStatsKey = @"is2eebba75c50ce13c31b9ef0b331fb93a";

@interface ALVNetworker () <NSURLSessionDelegate>

@end

@implementation ALVNetworker

+ (instancetype)manager {
    static ALVNetworker *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[ALVNetworker alloc] init];
    });
    return _manager;
}

+ (NSURLSession *)sharedSession {
    static NSURLSession *_session = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSMutableDictionary *additionalHTTPHeader = [NSMutableDictionary dictionary];
        [additionalHTTPHeader setObject:@"application/json" forKey:@"Content-Type"];
        [additionalHTTPHeader setObject:@"application/json" forKey:@"Accept"];
        [additionalHTTPHeader setObject:kFlightStatsAppId forKey:@"appId"];
        [additionalHTTPHeader setObject:kFlightStatsKey forKey:@"appKey"];
        
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        [sessionConfig setHTTPAdditionalHeaders:additionalHTTPHeader];
        
        _session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:[self manager] delegateQueue:nil];
        
    });
    
    return _session;
}

@end
