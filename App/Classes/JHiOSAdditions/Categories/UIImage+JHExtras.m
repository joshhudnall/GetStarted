//
//  UIImage+JHExtras.m
//
//  Created by Josh Hudnall on 9/1/12.
//  Copyright (c) 2012 Josh Hudnall. All rights reserved.
//

#import "UIImage+JHExtras.h"
#import <CoreGraphics/CoreGraphics.h>

@implementation UIImage (JHExtras)

+ (UIImage *)imageWithColor:(UIColor *)color {
    return [UIImage imageWithColor:color ofSize:CGSizeMake(1.f, 1.f)];
}

+ (UIImage *)imageWithColor:(UIColor *)color ofSize:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)spriteInRect:(CGRect)rect {
    CGImageRef imageToSplit = self.CGImage;
    
    CGImageRef partOfImageAsCG = CGImageCreateWithImageInRect(imageToSplit, rect);
    UIImage *partOfImage = [UIImage imageWithCGImage:partOfImageAsCG];

    CGImageRelease(imageToSplit);
    CGImageRelease(partOfImageAsCG);
    
    return partOfImage;
}

@end
