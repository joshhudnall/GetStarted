//
//  GAHelper.h
//  Women of Faith
//
//  Created by Josh Hudnall on 5/12/14.
//  Copyright (c) 2014 Josh Hudnall. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GAITracker;

@interface GAHelper : NSObject

+ (id <GAITracker>)primaryTracker;
+ (id <GAITracker>)secondaryTracker;

+ (void)trackScreen:(NSString *)screenName;
+ (void)trackScreen:(NSString *)screenName
 withPrimaryTracker:(BOOL)usePrimaryTracker andSecondaryTracker:(BOOL)useSecondaryTracker;

+ (void)trackEventWithCategory:(NSString *)category action:(NSString *)action label:(NSString *)label andValue:(NSNumber *)value;
+ (void)trackEventWithCategory:(NSString *)category action:(NSString *)action label:(NSString *)label andValue:(NSNumber *)value
            withPrimaryTracker:(BOOL)usePrimaryTracker andSecondaryTracker:(BOOL)useSecondaryTracker;

@end
