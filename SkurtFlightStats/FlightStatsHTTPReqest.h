//
//  FlightStatsHTTPReqest.h
//  SkurtFlightStats
//
//  Created by Andrew Lopez-Vass on 2/27/16.
//  Copyright © 2016 Andrew Lopez-Vass. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSUInteger, ProtocolSelectorType) {
    RESTProtocol = 1,
    SOAPProtocol = 2
};

typedef NS_ENUM (NSUInteger, FormatSelectorType) {
    JSONFormat = 1,
    JSONPFormat = 2,
    XMLFormat = 3
};

@interface FlightStatsHTTPReqest : NSObject

@property (assign, nonatomic) NSUInteger version; // Defaults to '1'
@property (assign, nonatomic) ProtocolSelectorType protocol; // Defaults to 'RESTProtocol'
@property (assign, nonatomic) FormatSelectorType format; // Defaults to 'JSONFormat'

@property (assign, nonatomic) BOOL useInlineReferences; // Defaults to 'YES'
@property (assign, nonatomic) BOOL useHTTPErrors; // Defaults to 'YES'
@property (assign, nonatomic) BOOL includeNewFields; // Defaults to 'YES'

@property (strong, nonatomic) NSString *apiName;
@property (strong, nonatomic) NSString *requiredParams;
@property (strong, nonatomic) NSDictionary *optionalParams;

- (NSURLRequest *)URLRequest;
- (void)fireWithCompletion:(VoidBlock)block;

@property (readonly) NSDictionary *response;

@end
