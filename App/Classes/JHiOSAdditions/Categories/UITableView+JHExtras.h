//
//  UITableView+JHExtras.h
//  CellSubviewLocation
//
//  Created by Matt Drance on 9/9/10.
//  Copyright 2010 Bookhouse Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UITableView (JHExtras)

/**
 *  Returns the index path for the row containing the specified vied
 *
 *  @param view A view to test
 *
 *  @return Returns an indexPath if the origin of the view's rect is within a row of the table, nil otherwise
 */
- (NSIndexPath *)jh_indexPathForRowContainingView:(UIView *)view;

@end
