//
//  JHAutosizingLabel.m
//
//  Created by Josh Hudnall on 1/7/11.
//  Copyright 2011 Josh Hudnall. All rights reserved.
//

#define MIN_HEIGHT 10.0f
#define MAX_HEIGHT 0.0f

#import "JHAutosizingLabel.h"

@implementation JHAutosizingLabel

// Public
@synthesize minHeight;
@synthesize maxHeight;
@synthesize adjustsParent;

- (id)init {
	if ([super init]) {
		self.minHeight = MIN_HEIGHT;
		self.maxHeight = MAX_HEIGHT;
	}
	
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if ([super initWithCoder:aDecoder]) {
		self.minHeight = MIN_HEIGHT;
		self.maxHeight = MAX_HEIGHT;
	}
	
	return self;
}

- (void)calculateSize {
	CGSize constraint = CGSizeMake(self.frame.size.width, 20000.0f);
    
    NSString *text = self.text;
	CGSize size = [text sizeWithFont:self.font constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
	
	[self setLineBreakMode:NSLineBreakByWordWrapping];
	[self setAdjustsFontSizeToFitWidth:NO];
	[self setNumberOfLines:0];
	
	float height = MAX(size.height, minHeight);
	if (maxHeight) {
		height = MIN(height, maxHeight);
	}
	[super setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height)];
	
	// If the parent is a scrollview, set it to the right size
	if (adjustsParent && [self.superview isKindOfClass:[UIScrollView class]]) {
		UIScrollView *parent = (UIScrollView *)self.superview;
		parent.contentSize = CGSizeMake(parent.frame.size.width, self.frame.origin.y + self.frame.size.height + 20);
	}
	
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    [self calculateSize];
}

- (void)setText:(NSString *)text {	
	[super setText:text];
	
	[self calculateSize];
}

- (void)setFont:(UIFont *)font {
	[super setFont:font];
	
	[self calculateSize];
}

- (void)layoutSubviews {
    [super layoutSubviews];
	
	[self calculateSize];
}

@end
