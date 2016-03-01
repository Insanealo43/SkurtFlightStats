//
//  AirlinesManager.h
//  SkurtFlightStats
//
//  Created by Andrew Lopez-Vass on 2/29/16.
//  Copyright © 2016 Andrew Lopez-Vass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AirlinesManager : NSObject

+ (instancetype)manager;
- (void)fetchActiveAirlinesWithCompletion:(VoidBlock)block;

@property (nonatomic, readonly) NSArray *airlineCodes;
@property (nonatomic, readonly) NSArray *airlineNames;

- (NSString *)airlineNameForCode:(NSString *)airlineCode;
- (NSString *)airlineCodeForName:(NSString *)airlineName;

- (NSArray *)airlineNamesForSearchText:(NSString *)searchText;

@end
