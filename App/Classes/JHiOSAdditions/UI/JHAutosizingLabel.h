//
//  JHAutosizingLabel.h
//
//  Created by Josh Hudnall on 1/7/11.
//  Copyright 2011 Josh Hudnall. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface JHAutosizingLabel : UILabel

/**
 *  The minimum height the label should be.
 */
@property (nonatomic) double minHeight;

/**
 *  The maximum height the label should grow to
 */
@property (nonatomic) double maxHeight;

/**
 *  If true and the label's superview is a UIScrollView, will automatically adjust the scrollView's contentSize to fit
 */
@property (nonatomic) BOOL adjustsParent;

@end
