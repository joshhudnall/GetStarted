//
//  Constants.m
//
//  Created by Josh Hudnall.
//

#import "Constants.h"

#pragma mark - CocoaLumberjack

#ifdef DEBUG
int const ddLogLevel = LOG_FLAG_DEBUG;
#else
int const ddLogLevel = LOG_LEVEL_INFO;
#endif

// Define NSLog to use CocoaLumberjack
#define NSLog DDLogInfo


#pragma mark - General

NSString *const kAPIBaseUrl = @"";
NSString *const kTrackingID = @"";
NSString *const kSecondaryTrackingName = @"secondaryTracker"; // This likely never need change
NSString *const kSecondaryTrackingID = @"";
NSString *const kHockeyAppID = @"";


#pragma mark - Defaults Keys




