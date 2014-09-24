//
//  UIApplication+JHExtras.m
//  Air1
//
//  Created by Josh Hudnall on 8/27/14.
//
//

#import "UIApplication+JHExtras.h"

@implementation UIApplication (JHExtras)

- (void)askToOpenURLString:(NSString *)urlString {
    [self askToOpenURL:[NSURL URLWithString:urlString]];
}

- (void)askToOpenURL:(NSURL *)url {
    // Suprisingly common to pass in a string instead of an NSURL
    if ([url isKindOfClass:[NSString class]]) {
        url = [NSURL URLWithString:(NSString *)url];
    }
    
    [PRPAlertView showWithTitle:@""
                        message:@"This will take you out of the app. Do you want to continue?"
                    cancelTitle:@"Cancel"
                    cancelBlock:nil
                     otherTitle:@"Leave App"
                     otherBlock:^(UIAlertView *alertView) {
                         [self openURL:url];
                     }];
}

- (void)askToCall:(NSString *)phoneNumber {
    // Strips out any non-valid characters from the number
    phoneNumber = [[phoneNumber componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789-+();"] invertedSet]] componentsJoinedByString:@""];
    
    [self openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", phoneNumber]]];
}

@end
