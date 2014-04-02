//
//  NSString+JHExtras.m
//  MyDieline
//
//  Created by Josh Hudnall on 6/6/12.
//  Copyright (c) 2012 Method Apps. All rights reserved.
//

#import "NSString+JHExtras.h"

@implementation NSString (JHExtras)

- (NSString *)stripWhitespace {
    NSString *string = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"  " withString:@""];
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    return string;
}

- (NSString *)jh_truncateToLength:(NSUInteger)length {
	return [self jh_truncateToLength:length inMiddle:NO];
}

- (NSString *)jh_truncateToLength:(NSUInteger)length inMiddle:(BOOL)inMiddle {
	NSString *withChar = (inMiddle) ? @" ... " : @" ...";
	
	return [self jh_truncateToLength:length inMiddle:inMiddle withChar:withChar];
}

- (NSString *)jh_truncateToLength:(NSUInteger)length inMiddle:(BOOL)inMiddle withChar:(NSString *)withChar {
	NSString *inStr = self;
	
	// If the string is shorter than the length desired, just return it
	if (length >= [inStr length]) return inStr;
	
	// Subtract the truncate char (...) length from the available length
	NSUInteger actualLength = length - [withChar length];
    
	// If inMiddle is NO, truncate at the end
	if ( ! inMiddle) {
		NSString *subStr = [inStr substringToIndex:actualLength];
		
		return [NSString stringWithFormat:@"%@%@", subStr, withChar];
	} else {
		NSUInteger firstHalfLength = floor(actualLength / 2);
		NSUInteger lastHalfLength = actualLength - firstHalfLength;
		NSString *firstHalf = [inStr substringToIndex:firstHalfLength];
		
		NSRange lastHalfRange = {[inStr length] - lastHalfLength, lastHalfLength};
		NSString *lastHalf = [inStr substringWithRange:lastHalfRange];
		
		return [NSString stringWithFormat:@"%@%@%@", firstHalf, withChar, lastHalf];
	}
	
	// We never reach this point, but we'll return to prevent a compiler warning
	return inStr;
}

+ (NSString *)jh_singular:(NSString *)singular orPlural:(NSString *)plural forCount:(NSInteger)count {
	return [NSString jh_zero:plural singular:singular orPlural:plural forCount:count];
}

+ (NSString *)jh_zero:(NSString *)zero singular:(NSString *)singular orPlural:(NSString *)plural forCount:(NSInteger)count {
	if (count == 0) {
		return [NSString stringWithFormat:zero, count];
	} else if (count == 1) {
		return [NSString stringWithFormat:singular, count];
	} else {
		return [NSString stringWithFormat:plural, count];
	}
}

- (NSString *)stringByStrippingHTML {
    NSRange r;
    NSString *s = [self copy];
    while ( (r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound )
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}

@end
