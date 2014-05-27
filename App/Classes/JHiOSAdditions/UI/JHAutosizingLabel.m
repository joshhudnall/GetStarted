//
//  JHAutosizingLabel.m
//
//  Created by Josh Hudnall on 1/7/11.
//  Copyright 2011 Josh Hudnall. All rights reserved.
//

#define kJHAutosizingLabelMinHeight 10.0f
#define kJHAutosizingLabelMaxHeight CGFLOAT_MAX

#import "JHAutosizingLabel.h"

@interface JHAutosizingLabel ()

@property (nonatomic, assign) BOOL useAttributedText;

@end

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
	CGSize constraint = CGSizeMake(self.frame.size.width, maxHeight);
    
    CGSize size;
    if (_useAttributedText) {
        size = [self.attributedText boundingRectWithSize:constraint
                                                 options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin
                                                 context:nil].size;
    } else {
        size = [self.text boundingRectWithSize:constraint
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{NSFontAttributeName: self.font}
                                       context:nil].size;
    }
	
	[self setLineBreakMode:NSLineBreakByWordWrapping];
	[self setAdjustsFontSizeToFitWidth:NO];
	[self setNumberOfLines:0];
	
	float height = fmaxf(ceilf(size.height), minHeight);
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
	
    _useAttributedText = NO;
	[self calculateSize];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
	[super setAttributedText:attributedText];
	
    _useAttributedText = YES;
	[self calculateSize];
}

- (void)setFont:(UIFont *)font {
	[super setFont:font];
    
    self.minHeight = font.pointSize;
	
	[self calculateSize];
}

- (void)layoutSubviews {
    [super layoutSubviews];
	
	[self calculateSize];
}

@end
