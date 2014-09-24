//
//  UIApplication+JHExtras.h
//  Air1
//
//  Created by Josh Hudnall on 8/27/14.
//
//

#import <UIKit/UIKit.h>

@interface UIApplication (JHExtras)

/**
 *  Asks the user if they'd like to leave the app and open the url.
 *
 *  @param url The url string to open
 */
- (void)askToOpenURLString:(NSString *)urlString;

/**
 *  Asks the user if they'd like to leave the app and open the url.
 *
 *  @param url The url to open
 */
- (void)askToOpenURL:(NSURL *)url;

/**
 *  Asks the user if they'd like to call a number
 *
 *  @param phoneNumber The phone number to call
 */
- (void)askToCall:(NSString *)phoneNumber;

@end
