//
//  FlightStatsHTTPReqest.m
//  SkurtFlightStats
//
//  Created by Andrew Lopez-Vass on 2/27/16.
//  Copyright © 2016 Andrew Lopez-Vass. All rights reserved.
//

#import "FlightStatsHTTPReqest.h"
#import "NSData+additions.h"

static NSString *const FlightStatsApiBaseURI = @"https://api.flightstats.com/flex";

static NSString *const kFlightStatsAppId = @"91b929e6";
static NSString *const kFlightStatsKey = @"2eebba75c50ce13c31b9ef0b331fb93a";

static NSString *const kFormatString = @"https://api.flightstats.com/flex/airlines/rest/v1/json/active";

@interface FlightStatsHTTPReqest ()

@property (nonatomic, strong) NSMutableURLRequest *URLRequest;
@property (nonatomic, strong) NSDictionary *response;

@end

@implementation FlightStatsHTTPReqest

- (instancetype)init {
    self = [super init];
    if (self) {
        _version = 1;
        _protocol = RESTProtocol;
        _format = JSONFormat;
        _useHTTPErrors = _useInlineReferences = _includeNewFields = YES;
    }
    return self;
}

- (void)setUseHTTPErrors:(BOOL)useHTTPErrors {
    _useHTTPErrors = useHTTPErrors;
    _URLRequest = nil;
}

- (void)setUseInlineReferences:(BOOL)useInlineReferences {
    _useInlineReferences = useInlineReferences;
    _URLRequest = nil;
}

- (void)setIncludeNewFields:(BOOL)includeNewFields {
    _includeNewFields = includeNewFields;
    _URLRequest = nil;
}

- (void)setVersion:(NSUInteger)version {
    _version = MAX(version, 1);
    _URLRequest = nil;
}

@synthesize apiName = _apiName;
- (NSString *)apiName {
    return _apiName ? _apiName : @"";
}

- (void)setApiName:(NSString *)apiName {
    _apiName = apiName;
    _URLRequest = nil;
}

@synthesize requiredParams = _requiredParams;
- (NSString *)requiredParams {
    return _requiredParams ? _requiredParams : @"";
}

- (void)setRequiredParams:(NSString *)requiredParams {
    _requiredParams = requiredParams;
    _URLRequest = nil;
}

- (void)setOptionalParams:(NSDictionary *)optionalParams {
    _optionalParams = optionalParams;
    _URLRequest = nil;
}

- (NSString *)protocolString {
    switch (_protocol) {
        case RESTProtocol:
            return @"rest";
            
        case SOAPProtocol:
            return @"soap";
    }
    
    return @"rest";
}

- (NSString *)formatString {
    switch (_format) {
        case JSONFormat:
            return @"json";
            
        case JSONPFormat:
            return @"jsonp";
            
        case XMLFormat:
            return @"xml";
    }
    
    return @"json";
}

- (NSString *)optionalParamsString {
    if ([_optionalParams count] > 0) {
        
        return [NSString stringWithFormat:@"?%@", @""];
    }
    
    return @"";
}

- (NSURLRequest *)URLRequest {
    if (!_URLRequest) {
        // Format: Base_URI, /API_NAME, /PROTOCOL, /VERSION, /FORMAT, /REQUIRED, /OPTIONAL
        NSString *formattedURI = [NSString stringWithFormat:@"%@/%@/%@/v%@/%@/%@/%@", FlightStatsApiBaseURI, [self apiName], [self protocolString], @(_version), [self formatString], [self requiredParams], [self optionalParamsString]];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:formattedURI]];
        [request setValue:kFlightStatsAppId forHTTPHeaderField:@"appId"];
        [request setValue:kFlightStatsKey forHTTPHeaderField:@"appKey"];
        
        _URLRequest = request;
    }
    return _URLRequest;
}

- (void)fireWithCompletion:(VoidBlock)block {
    NSURLSessionDataTask *task = [[ALVNetworker sharedSession] dataTaskWithRequest:[self URLRequest] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        _response = [data json];
        if (block) block();
    }];
    [task resume];
}

@end
