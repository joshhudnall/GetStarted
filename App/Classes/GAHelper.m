//
//  GAHelper.m
//  Women of Faith
//
//  Created by Josh Hudnall on 5/12/14.
//  Copyright (c) 2014 Josh Hudnall. All rights reserved.
//

#import "GAI.h"
#import "GAITracker.h"
#import "GAHelper.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"

@implementation GAHelper

+ (id <GAITracker>)primaryTracker {
    return [[GAI sharedInstance] defaultTracker];
}

+ (id <GAITracker>)secondaryTracker {
    if ([kSecondaryTrackingID jh_isFull]) {
        return [[GAI sharedInstance] trackerWithName:kSecondaryTrackingName
                                          trackingId:kSecondaryTrackingID];
    }
    
    return nil;
}

+ (void)trackScreen:(NSString *)screenName {
    [self trackScreen:screenName withPrimaryTracker:YES andSecondaryTracker:YES];
}

+ (void)trackScreen:(NSString *)screenName withPrimaryTracker:(BOOL)usePrimaryTracker andSecondaryTracker:(BOOL)useSecondaryTracker {
    if (usePrimaryTracker) {
        [[self primaryTracker] set:kGAIScreenName value:screenName];
        [[self primaryTracker] send:[[GAIDictionaryBuilder createAppView] build]];
    }

    if (useSecondaryTracker) {
        [[self secondaryTracker] set:kGAIScreenName value:screenName];
        [[self secondaryTracker] send:[[GAIDictionaryBuilder createAppView] build]];
    }
}

+ (void)trackEventWithCategory:(NSString *)category action:(NSString *)action label:(NSString *)label andValue:(NSNumber *)value {
    [self trackEventWithCategory:category action:action label:label andValue:value withPrimaryTracker:YES andSecondaryTracker:YES];
}

+ (void)trackEventWithCategory:(NSString *)category action:(NSString *)action label:(NSString *)label andValue:(NSNumber *)value
            withPrimaryTracker:(BOOL)usePrimaryTracker andSecondaryTracker:(BOOL)useSecondaryTracker {
    
    if (usePrimaryTracker) {
        [[self primaryTracker] send:[[GAIDictionaryBuilder createEventWithCategory:category
                                                                            action:action
                                                                             label:label
                                                                             value:value] build]];
    }
    
    if (useSecondaryTracker) {
        [[self secondaryTracker] send:[[GAIDictionaryBuilder createEventWithCategory:category
                                                                            action:action
                                                                             label:label
                                                                             value:value] build]];
    }
}

@end
