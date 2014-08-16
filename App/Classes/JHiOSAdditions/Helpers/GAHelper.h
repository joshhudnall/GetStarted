//
//  GAHelper.h
//
//  Created by Josh Hudnall on 5/12/14.
//  Copyright (c) 2014 Josh Hudnall. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GAITracker;

@interface GAHelper : NSObject

/**
 *  Get the primary tracker for this app if available
 *
 *  @return GAITracker object
 */
+ (id <GAITracker>)primaryTracker;

/**
 *  Get the secondary tracker for this app if available
 *
 *  @return GAITracker object
 */
+ (id <GAITracker>)secondaryTracker;

/**
 *  Tracks a screen view on the primary and secondary trackers as available
 *
 *  @param screenName The name of the screen to track
 */
+ (void)trackScreen:(NSString *)screenName;

/**
 *  Tracks a screen view on the primary and/or secondary trackers as available
 *
 *  @param screenName          The name of the screen to track
 *  @param usePrimaryTracker   YES to try and use the primary tracker
 *  @param useSecondaryTracker YES to try and use the secondary tracker
 */
+ (void)trackScreen:(NSString *)screenName
 withPrimaryTracker:(BOOL)usePrimaryTracker andSecondaryTracker:(BOOL)useSecondaryTracker;

/**
 *  Tracks an event on the primary and secondary trackers as available
 *
 *  @param category Event category
 *  @param action   Event action
 *  @param label    Event label
 *  @param value    Event value
 */
+ (void)trackEventWithCategory:(NSString *)category action:(NSString *)action label:(NSString *)label andValue:(NSNumber *)value;

/**
 *  Tracks an event on the primary and secondary trackers as available
 *
 *  @param category            Event category
 *  @param action              Event action
 *  @param label               Event label
 *  @param value               Event value
 *  @param usePrimaryTracker   YES to try and use the primary tracker
 *  @param useSecondaryTracker YES to try and use the secondary tracker
 */
+ (void)trackEventWithCategory:(NSString *)category action:(NSString *)action label:(NSString *)label andValue:(NSNumber *)value
            withPrimaryTracker:(BOOL)usePrimaryTracker andSecondaryTracker:(BOOL)useSecondaryTracker;

@end
