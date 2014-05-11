//
//  UITableView+JHExtras.h
//  CellSubviewLocation
//
//  Created by Matt Drance on 9/9/10.
//  Copyright 2010 Bookhouse Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UITableView (JHExtras)

- (NSIndexPath *)indexPathForRowContainingView:(UIView *)view;

@end
