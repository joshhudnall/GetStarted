//
//  UIColor+JHExtras.h
//  Connoshoer
//
//  Created by Josh Hudnall on 12/13/12.
//  Copyright (c) 2012 Connoshoer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (JHExtras)

+ (BOOL)stringIsHexColor:(NSString *)string;
+ (UIColor *)colorWithHexString:(NSString *)string;

- (BOOL)isEqualToColor:(UIColor *)otherColor;

@end
