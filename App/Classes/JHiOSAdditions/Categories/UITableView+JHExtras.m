//
//  UITableView+JHExtras.m
//
//  Created by Josh Hudnall on 9/9/10.
//  Copyright 2010 Josh Hudnall. All rights reserved.
//

#import "UITableView+JHExtras.h"

@implementation UITableView (JHExtras)

- (NSIndexPath *)jh_indexPathForRowContainingView:(UIView *)view {
    CGPoint correctedPoint = [view convertPoint:view.bounds.origin toView:self];
    return [self indexPathForRowAtPoint:correctedPoint];    
}

@end
