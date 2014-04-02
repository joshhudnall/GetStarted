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


// CocoaLumberjack

extern int const ddLogLevel;

// General

extern NSString *const kAPIBaseUrl;
extern NSString *const kTrackingID;
extern NSString *const kHockeyAppID;


// Defaults



// Fonts



// Colors

