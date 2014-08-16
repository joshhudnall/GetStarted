//
//  JHModel.h
//
//  Created by Josh Hudnall.
//  Copyright (c) 2014 Josh Hudnall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AutoCoding.h"

@interface JHModel : NSObject

/**
 *  Returns an array of JHModel or subclass objects
 *
 *  @param jsonArray An NSArray representation of a JSON array
 *
 *  @return Array of objects
 */
+ (NSArray *)objectsWithJSONArray:(NSArray *)jsonArray;

/**
 *  Factory method to create an object from a JSON object
 *
 *  @param jsonDict An NSDictionary representation of a JSON object
 *
 *  @return Object
 */
+ (instancetype)objectWithJSONDictionary:(NSDictionary *)jsonDict;

/**
 *  Creates and returns an object from a JSON object. This is an abstract method. The base class method does nothing.
 *
 *  @param jsonDict An NSDictionary representation of a JSON object
 *
 *  @return Object
 */
- (id)initWithJSONDictionary:(NSDictionary *)jsonDict;

/**
 *  Creates an NSArray representation of these objects suitable for JSON serialization. This is an abstract method. The base class method does nothing.
 *
 *  @param objects Objects which are a subclass of JHModel
 *
 *  @return NSArray representation
 */
+ (NSArray *)jsonArrayWithObjects:(NSArray *)objects;

/**
 *  Creates an NSDictionary representation of this object suitable for JSON serialization. This is an abstract method. The base class method does nothing.
 *
 *  @return NSDictionary representation
 */
- (NSDictionary *)jsonDictionary;

@end
