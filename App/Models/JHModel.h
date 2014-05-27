//
//  JHModel.h
//  TheLifeYouWantTour
//
//  Created by Josh Hudnall.
//  Copyright (c) 2014 fastPXL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHModel : NSObject <NSSecureCoding>

+ (NSArray *)objectsWithJSONArray:(NSArray *)jsonArray;
+ (instancetype)objectWithJSONDictionary:(NSDictionary *)jsonDict;

- (id)initWithJSONDictionary:(NSDictionary *)jsonDict;

@end
