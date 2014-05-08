//
//  Constants.m
//
//  Created by Josh Hudnall.
//

#import "Constants.h"

// CocoaLumberjack

#ifdef DEBUG
int const ddLogLevel = LOG_FLAG_DEBUG;
#else
int const ddLogLevel = LOG_LEVEL_WARN;
#endif

// Define NSLog to use CocoaLumberjack
#define NSLog DDLogInfo


// General

NSString *const kAPIBaseUrl = @"";
NSString *const kTrackingID = @"";
NSString *const kSecondaryTrackingName = @"secondaryTracker";
NSString *const kSecondaryTrackingID = @"";
NSString *const kHockeyAppID = @"";


// Defaults




