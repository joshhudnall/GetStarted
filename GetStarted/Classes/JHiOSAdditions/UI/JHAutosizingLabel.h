//
//  JHAutosizingLabel.h
//
//  Created by Josh Hudnall on 1/7/11.
//  Copyright 2011 Josh Hudnall. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface JHAutosizingLabel : UILabel {
	double minHeight;
}

@property (nonatomic) double minHeight;
@property (nonatomic) double maxHeight;
@property (nonatomic) BOOL adjustsParent;

- (void)calculateSize;

@end
