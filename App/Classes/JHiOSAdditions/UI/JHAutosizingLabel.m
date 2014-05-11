//
//  JHAutosizingLabel.m
//
//  Created by Josh Hudnall on 1/7/11.
//  Copyright 2011 Josh Hudnall. All rights reserved.
//

#define kJHAutosizingLabelMinHeight 10.0f
#define kJHAutosizingLabelMaxHeight CGFLOAT_MAX

#import "JHAutosizingLabel.h"

@implementation JHAutosizingLabel

// Public
@synthesize minHeight;
@synthesize maxHeight;
@synthesize adjustsParent;

- (id)initWithFrame:(CGRect)frame {
	if ([super initWithFrame:frame]) {
        [self setup];
	}
	
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if ([super initWithCoder:aDecoder]) {
        [self setup];
	}
	
	return self;
}

- (void)setup {
    self.minHeight = kJHAutosizingLabelMinHeight;
    self.maxHeight = kJHAutosizingLabelMaxHeight;
}

- (void)calculateSize {
	CGSize constraint = CGSizeMake(self.frame.size.width, 20000.0f);
    
    NSAttributedString *attString = self.attributedText;
	CGSize size = [attString boundingRectWithSize:constraint
                                          options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin
                                          context:nil].size;
	
	[self setLineBreakMode:NSLineBreakByWordWrapping];
	[self setAdjustsFontSizeToFitWidth:NO];
	[self setNumberOfLines:0];
	
	float height = fmaxf(size.height, minHeight);
	if (maxHeight) {
		height = fminf(height, maxHeight);
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
    
    [self setNeedsLayout];
}

- (void)setText:(NSString *)text {	
	[super setText:text];
	
	[self setNeedsLayout];
}

- (void)setFont:(UIFont *)font {
	[super setFont:font];
    
    self.minHeight = font.pointSize;
	
	[self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
	
	[self calculateSize];
}

@end
