//
//  UIBarButtonItem+JHExtras.h
//  WAY-FMMobile
//
//  Created by Josh Hudnall on 9/4/12.
//  Copyright (c) 2012 Josh Hudnall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (JHExtras)

+ (UIBarButtonItem *)barButtonItemForTitle:(NSString *)title target:(id)target andSelector:(SEL)selector;
+ (UIBarButtonItem *)barButtonItemForImage:(UIImage *)image target:(id)target andSelector:(SEL)selector;

@end
