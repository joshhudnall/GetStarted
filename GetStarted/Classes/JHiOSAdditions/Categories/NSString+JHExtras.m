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

- (NSString *)truncateToLength:(NSUInteger)length {
	return [self truncateToLength:length inMiddle:NO];
}

- (NSString *)truncateToLength:(NSUInteger)length inMiddle:(BOOL)inMiddle {
	NSString *withChar = (inMiddle) ? @" ... " : @" ...";
	
	return [self truncateToLength:length inMiddle:inMiddle withChar:withChar];
}

- (NSString *)truncateToLength:(NSUInteger)length inMiddle:(BOOL)inMiddle withChar:(NSString *)withChar {
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

+ (NSString *)singular:(NSString *)singular orPlural:(NSString *)plural forCount:(NSInteger)count {
	return [NSString zero:plural singular:singular orPlural:plural forCount:count];
}

+ (NSString *)zero:(NSString *)zero singular:(NSString *)singular orPlural:(NSString *)plural forCount:(NSInteger)count {
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

- (NSString *)slug {
    NSMutableString *newStr = [[self lowercaseString] mutableCopy];
    NSString *separator = @"-";
    
    // Strip accents and diacritics
    CFStringTransform((__bridge CFMutableStringRef)(newStr), NULL, kCFStringTransformStripCombiningMarks, NO);
    
    // Convert nonvalid characters to `separator`s
    NSString *validCharacters = @"abcdefghijklmnopqrstuvwxyz1234567890-_";
    NSCharacterSet *invalidCharacters = [[NSCharacterSet characterSetWithCharactersInString:validCharacters] invertedSet];
    newStr = [NSMutableString stringWithString:[[newStr componentsSeparatedByCharactersInSet:invalidCharacters] componentsJoinedByString:separator]];
    
    return [newStr mutableCopy];
}

- (BOOL)isEmpty {
    return ! (self && self.length);
}

@end




