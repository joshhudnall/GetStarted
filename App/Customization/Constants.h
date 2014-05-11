//
//  Constants.h
//
//  Created by Josh Hudnall.
//

#import <Foundation/Foundation.h>

#define IS_IPHONE ( [ [ [ UIDevice currentDevice ] model ] rangeOfString: @"iPhone" ].location != NSNotFound )
#define IS_IPOD   ( [ [ [ UIDevice currentDevice ] model ] rangeOfString: @"iPod touch" ].location != NSNotFound ] )
#define IS_IPAD   (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPhone)

#define IS_WIDESCREEN ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IS_IPHONE_5 (IS_IPHONE && IS_WIDESCREEN)
#define IS_RETINA ([[UIScreen mainScreen] scale] == 2.0f)

#define IS_IOS_6 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define IS_IOS_7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)


#pragma mark - CocoaLumberjack

/**
 *  The CocoaLumberjack logging level
 */
extern int const ddLogLevel;


#pragma mark - General

/**
 *  A base API URL to be used with JHViewController's apiEndpoint property
 */
extern NSString *const kAPIBaseUrl;

/**
 *  A Google Analytics property ID. If set, enables automatic GA screen tracking for all JHViewControllers with a title
 */
extern NSString *const kTrackingID;

/**
 *  A secondary Google Analytics tracker name. If set, enables automatic GA screen tracking for all JHViewControllers with a title
 */
extern NSString *const kSecondaryTrackingName;

/**
 *  A secondary Google Analytics property ID. If set, enables automatic GA screen tracking for all JHViewControllers with a title
 */
extern NSString *const kSecondaryTrackingID;

/**
 *  A HockeyApp SDK App ID. If set, enables Hockey SDK tracking and crash logs
 */
extern NSString *const kHockeyAppID;


#pragma mark - Defaults Keys



