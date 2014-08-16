//
//  NSUserDefaults+JHExtras.m
//
//  Created by Josh Hudnall on 5/18/14.
//  Copyright (c) 2014 Josh Hudnall. All rights reserved.
//

#import "NSUserDefaults+JHExtras.h"

@implementation NSUserDefaults (JHExtras)

- (BOOL)shouldPerformOnceForKey:(NSString *)defaultName {
    BOOL hasPerformed = [self boolForKey:defaultName defaultValue:NO];
    
    if ( ! hasPerformed) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:defaultName];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    return ! hasPerformed;
}

- (BOOL)boolForKey:(NSString *)defaultName defaultValue:(BOOL)defaultValue {
    if ([self objectForKey:defaultName]) {
        return [self boolForKey:defaultName];
    }
    
    return defaultValue;
}

- (NSInteger)integerForKey:(NSString *)defaultName defaultValue:(NSInteger)defaultValue {
    if ([self objectForKey:defaultName]) {
        return [self integerForKey:defaultName];
    }
    
    return defaultValue;
}

- (float)floatForKey:(NSString *)defaultName defaultValue:(float)defaultValue {
    if ([self objectForKey:defaultName]) {
        return [self floatForKey:defaultName];
    }
    
    return defaultValue;
}

- (NSString *)stringForKey:(NSString *)defaultName defaultValue:(NSString *)defaultValue {
    if ([self objectForKey:defaultName]) {
        return [self stringForKey:defaultName];
    }
    
    return [defaultValue copy];
}


- (NSArray *)arrayForKey:(NSString *)defaultName defaultValue:(NSArray *)defaultValue {
    if ([self objectForKey:defaultName]) {
        return [self arrayForKey:defaultName];
    }
    
    return [defaultValue copy];
}


- (NSDictionary *)dictionaryForKey:(NSString *)defaultName defaultValue:(NSDictionary *)defaultValue {
    if ([self objectForKey:defaultName]) {
        return [self dictionaryForKey:defaultName];
    }
    
    return [defaultValue copy];
}


- (NSData *)dataForKey:(NSString *)defaultName defaultValue:(NSData *)defaultValue {
    if ([self objectForKey:defaultName]) {
        return [self dataForKey:defaultName];
    }
    
    return [defaultValue copy];
}


- (NSArray *)stringArrayForKey:(NSString *)defaultName defaultValue:(NSArray *)defaultValue {
    if ([self objectForKey:defaultName]) {
        return [self stringArrayForKey:defaultName];
    }
    
    return [defaultValue copy];
}


- (double)doubleForKey:(NSString *)defaultName defaultValue:(double)defaultValue {
    if ([self objectForKey:defaultName]) {
        return [self doubleForKey:defaultName];
    }
    
    return defaultValue;
}


- (NSURL *)URLForKey:(NSString *)defaultName defaultValue:(NSURL *)defaultValue {
    if ([self objectForKey:defaultName]) {
        return [self URLForKey:defaultName];
    }
    
    return [defaultValue copy];
}



@end
