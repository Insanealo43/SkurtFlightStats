//
//  FlightStatsHTTPReqest.m
//  SkurtFlightStats
//
//  Created by Andrew Lopez-Vass on 2/27/16.
//  Copyright © 2016 Andrew Lopez-Vass. All rights reserved.
//

#import "FlightStatsHTTPReqest.h"

static NSString *const FlightStatsApiBaseURI = @"https://api.flightstats.com/flex";

static NSString *const kFlightStatsAppId = @"91b929e6";
static NSString *const kFlightStatsKey = @"is2eebba75c50ce13c31b9ef0b331fb93a";

@interface FlightStatsHTTPReqest ()

@property (nonatomic, strong) NSURL *URL;
@property (nonatomic, strong) NSMutableURLRequest *urlRequest;

@end

@implementation FlightStatsHTTPReqest

- (instancetype)init {
    self = [super init];
    if (self) {
        _version = 1;
        _protocol = RESTProtocol;
        _format = JSONFormat;
        _useHTTPErrors = _useInlineReferences = _includeNewFields = YES;
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setValue:kFlightStatsAppId forHTTPHeaderField:@"appId"];
        [request setValue:kFlightStatsKey forHTTPHeaderField:@"appKey"];
        _urlRequest = request;
    }
    return self;
}

- (void)setUseHTTPErrors:(BOOL)useHTTPErrors {
    _useHTTPErrors = useHTTPErrors;
    
}

- (void)setUseInlineReferences:(BOOL)useInlineReferences {
    _useInlineReferences = useInlineReferences;
    
}

- (void)setIncludeNewFields:(BOOL)includeNewFields {
    _includeNewFields = includeNewFields;
    
}

- (void)setVersion:(NSUInteger)version {
    _version = MAX(version, 1);
}

- (void)setRelativePath:(NSString *)relativePath {
    _relativePath = relativePath;
    [self setURL:nil];
    [_urlRequest setURL:[self URL]];
}

- (void)setOptionalParams:(NSDictionary *)optionalParams {
    _optionalParams = optionalParams;
    [self setURL:nil];
    [_urlRequest setURL:[self URL]];
}

- (NSURL *)URL {
    if (!_URL) {
        
    }
    return _URL;
}

- (NSURLRequest *)URLRequest {
    if (!_urlRequest) {
        
    }
    return _urlRequest;
}

@end
