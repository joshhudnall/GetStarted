//
//  UITableView+JHExtras.h
//
//  Created by Josh Hudnall on 9/9/10.
//

#import <Foundation/Foundation.h>


@interface UITableView (JHExtras)

/**
 *  Returns the index path for the row containing the specified view. Taken from "iOS Recipes" by Matt Drance
 *
 *  @param view A view to test
 *
 *  @return Returns an indexPath if the origin of the view's rect is within a row of the table, nil otherwise
 */
- (NSIndexPath *)jh_indexPathForRowContainingView:(UIView *)view;

@end
