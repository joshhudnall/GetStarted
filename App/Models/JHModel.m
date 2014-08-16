//
//  JHModel.m
//  TheLifeYouWantTour
//
//  Created by Josh Hudnall.
//  Copyright (c) 2014 Josh Hudnall. All rights reserved.
//

#import "JHModel.h"

@implementation JHModel

#pragma mark - JSON to Object

+ (NSArray *)objectsWithJSONArray:(NSArray *)jsonArray {
    NSMutableArray *objects = [NSMutableArray arrayWithCapacity:jsonArray.count];
    for (NSDictionary *item in jsonArray) {
        [objects addObject:[[self class] objectWithJSONDictionary:item]];
    }
    
    return [objects copy];
}

+ (instancetype)objectWithJSONDictionary:(NSDictionary *)jsonDict {
    return [[[self class] alloc] initWithJSONDictionary:jsonDict];
}

- (id)initWithJSONDictionary:(NSDictionary *)jsonDict {
    return nil;
}


#pragma mark - Object to JSON

+ (NSArray *)jsonArrayWithObjects:(NSArray *)objects {
    return @[];
}

- (NSDictionary *)jsonDictionary {
    return @{};
}

#pragma mark - Utility

+ (NSString *)jsonArrayKey {
    // You'll probably need to override this in subclasses
    return NSStringFromClass([self class]);
}

@end
