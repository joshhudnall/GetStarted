//
//  JHModel.m
//  TheLifeYouWantTour
//
//  Created by Josh Hudnall.
//  Copyright (c) 2014 fastPXL. All rights reserved.
//

#import <objc/runtime.h>

#import "JHModel.h"

@implementation JHModel

+ (NSArray *)objectsWithJSONArray:(NSArray *)jsonArray {
    NSMutableArray *objects = [NSMutableArray arrayWithCapacity:jsonArray.count];
    for (NSDictionary *item in jsonArray) {
        [objects addObject:[[self class] objectWithJSONDictionary:item]];
    }
    
    return [objects mutableCopy];
}

+ (instancetype)objectWithJSONDictionary:(NSDictionary *)jsonDict {
    return [[[self class] alloc] initWithJSONDictionary:jsonDict];
}

- (id)initWithJSONDictionary:(NSDictionary *)jsonDict {
    if ( ( self = [super init]) ) {
        
    }
    return self;
}

+ (NSString *)jsonArrayKey {
    // You'll probably need to override this in subclasses
    return NSStringFromClass([self class]);
}

@end
