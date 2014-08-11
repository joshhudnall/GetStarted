//
//  NSUserDefaults+JHExtras.h
//  Air1 Photo Booth
//
//  Created by Josh Hudnall on 5/18/14.
//  Copyright (c) 2014 Josh Hudnall. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (JHExtras)

/**
 *  This method will return YES exactly one time and then return NO on every subsequent call. Use for actions you only want to perform one time such as displaying app instructions to a user.
 *
 *  @param defaultName The key to check for
 *
 *  @return A BOOL indicating whether action should be performed
 */
- (BOOL)shouldPerformOnceForKey:(NSString *)defaultName;

/**
 *  Returns the Boolean value associated with the specified key. If the key does not exist returns defaultValue.
 *
 *  @param defaultName  A key in the current user's defaults dictionary
 *  @param defaultValue The value to return if defaultName does not exist
 *
 *  @return If a boolean value is associated with defaultName in the user defaults, that value is returned. Otherwise, defaultValue is returned.
 */
- (BOOL)boolForKey:(NSString *)defaultName defaultValue:(BOOL)defaultValue;

/**
 *  Returns the integer value associated with the specified key. If the key does not exist returns defaultValue.
 *
 *  @param defaultName  A key in the current user's defaults dictionary
 *  @param defaultValue The value to return if defaultName does not exist
 *
 *  @return If a integer value is associated with defaultName in the user defaults, that value is returned. Otherwise, defaultValue is returned.
 */
- (NSInteger)integerForKey:(NSString *)defaultName defaultValue:(NSInteger)defaultValue;

/**
 *  Returns the float value associated with the specified key. If the key does not exist returns defaultValue.
 *
 *  @param defaultName  A key in the current user's defaults dictionary
 *  @param defaultValue The value to return if defaultName does not exist
 *
 *  @return If a float value is associated with defaultName in the user defaults, that value is returned. Otherwise, defaultValue is returned.
 */
- (float)floatForKey:(NSString *)defaultName defaultValue:(float)defaultValue;

/**
 *  Returns the string value associated with the specified key. If the key does not exist returns defaultValue.
 *
 *  @param defaultName  A key in the current user's defaults dictionary
 *  @param defaultValue The value to return if defaultName does not exist
 *
 *  @return If a string value is associated with defaultName in the user defaults, that value is returned. Otherwise, defaultValue is returned.
 */
- (NSString *)stringForKey:(NSString *)defaultName defaultValue:(NSString *)defaultValue;

/**
 *  Returns the array value associated with the specified key. If the key does not exist returns defaultValue.
 *
 *  @param defaultName  A key in the current user's defaults dictionary
 *  @param defaultValue The value to return if defaultName does not exist
 *
 *  @return If a array value is associated with defaultName in the user defaults, that value is returned. Otherwise, defaultValue is returned.
 */
- (NSArray *)arrayForKey:(NSString *)defaultName defaultValue:(NSArray *)defaultValue;

/**
 *  Returns the dictionary value associated with the specified key. If the key does not exist returns defaultValue.
 *
 *  @param defaultName  A key in the current user's defaults dictionary
 *  @param defaultValue The value to return if defaultName does not exist
 *
 *  @return If a dictionary value is associated with defaultName in the user defaults, that value is returned. Otherwise, defaultValue is returned.
 */
- (NSDictionary *)dictionaryForKey:(NSString *)defaultName defaultValue:(NSDictionary *)defaultValue;

/**
 *  Returns the data value associated with the specified key. If the key does not exist returns defaultValue.
 *
 *  @param defaultName  A key in the current user's defaults dictionary
 *  @param defaultValue The value to return if defaultName does not exist
 *
 *  @return If a data value is associated with defaultName in the user defaults, that value is returned. Otherwise, defaultValue is returned.
 */
- (NSData *)dataForKey:(NSString *)defaultName defaultValue:(NSData *)defaultValue;

/**
 *  Returns the stringArray value associated with the specified key. If the key does not exist returns defaultValue.
 *
 *  @param defaultName  A key in the current user's defaults dictionary
 *  @param defaultValue The value to return if defaultName does not exist
 *
 *  @return If a stringArray value is associated with defaultName in the user defaults, that value is returned. Otherwise, defaultValue is returned.
 */
- (NSArray *)stringArrayForKey:(NSString *)defaultName defaultValue:(NSArray *)defaultValue;

/**
 *  Returns the double value associated with the specified key. If the key does not exist returns defaultValue.
 *
 *  @param defaultName  A key in the current user's defaults dictionary
 *  @param defaultValue The value to return if defaultName does not exist
 *
 *  @return If a double value is associated with defaultName in the user defaults, that value is returned. Otherwise, defaultValue is returned.
 */
- (double)doubleForKey:(NSString *)defaultName defaultValue:(double)defaultValue;

/**
 *  Returns the URL value associated with the specified key. If the key does not exist returns defaultValue.
 *
 *  @param defaultName  A key in the current user's defaults dictionary
 *  @param defaultValue The value to return if defaultName does not exist
 *
 *  @return If a URL value is associated with defaultName in the user defaults, that value is returned. Otherwise, defaultValue is returned.
 */
- (NSURL *)URLForKey:(NSString *)defaultName defaultValue:(NSURL *)defaultValue;

@end
