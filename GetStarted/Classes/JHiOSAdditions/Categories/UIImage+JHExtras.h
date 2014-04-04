//
//  UIImage+JHExtras.h
//
//  Created by Josh Hudnall on 9/1/12.
//  Copyright (c) 2012 Josh Hudnall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JHExtras)

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color ofSize:(CGSize)size;

- (UIImage *)spriteInRect:(CGRect)rect;

@end
