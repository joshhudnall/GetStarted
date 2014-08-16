//
//  UIFont+Customizatoin.m
//
//  Created by Josh Hudnall on 4/23/14.
//
//

#import "UIFont+App.h"

@implementation UIFont (App)

+ (void)listFonts {
	NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
	NSArray *fontNames;
	NSInteger indFamily, indFont;
	for (indFamily = 0; indFamily < [familyNames count]; ++indFamily) {
		NSLog(@"Family name: %@", [familyNames objectAtIndex:indFamily]);
		fontNames = [[NSArray alloc] initWithArray:
		             [UIFont fontNamesForFamilyName:
		              [familyNames objectAtIndex:indFamily]]];
		for (indFont = 0; indFont < [fontNames count]; ++indFont) {
			NSLog(@"    Font name: %@", [fontNames objectAtIndex:indFont]);
		}
	}
}

+ (UIFont *)helveticaAtSize:(CGFloat)size {
	return [UIFont fontWithName:@"Helvetica" size:size];
}

@end
