//
//  UIFont+Customizatoin.h
//  GetStarted
//
//  Created by Josh Hudnall on 4/23/14.
//
//

#import <UIKit/UIKit.h>

@interface UIFont (App)

/**
 *  Lists all of the fonts available on iOS. Use to find the appropriate names of custom fonts you have installed.
 */
+ (void)listFonts;

/**
 *  Returns a UIFont at the specified size
 *
 *  @param size The desired size of the font
 *
 *  @return A UIFont at the specified size
 */
+ (UIFont *)helveticaAtSize:(CGFloat)size;

@end
