//
//  JHAppActions.m
//  PeopleInSpace
//
//  Created by Josh Hudnall on 3/25/14.
//
//

#import "JHBeSocial.h"
#import "PRPAlertView.h"

@implementation JHBeSocial

+ (void)openTwitterProfile:(NSString *)username {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetbot:///user_profile/peopleinspace"]]) {
        [PRPAlertView showWithTitle:@"Leave App?"
                            message:@"This will take you to Tweetbot. Do you want to continue?"
                        cancelTitle:@"Cancel"
                        cancelBlock:nil
                         otherTitle:@"Open Tweetbot"
                         otherBlock:^(UIAlertView *alertView) {
                             [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tweetbot:///user_profile/%@", username]]];
                         }];
    } else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://user?screen_name=peopleinspace"]]) {
        [PRPAlertView showWithTitle:@"Leave App?"
                            message:@"This will take you to the Twitter app. Do you want to continue?"
                        cancelTitle:@"Cancel"
                        cancelBlock:nil
                         otherTitle:@"Open Twitter"
                         otherBlock:^(UIAlertView *alertView) {
                             [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"twitter://user?screen_name=%@", username]]];
                         }];
    } else {
        [PRPAlertView showWithTitle:@"Leave App"
                            message:@"This will take you to Safari. Do you want to continue?"
                        cancelTitle:@"Cancel"
                        cancelBlock:nil
                         otherTitle:@"Open Safari"
                         otherBlock:^(UIAlertView *alertView) {
                             [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://twitter.com/%@", username]]];
                         }];
    }
}

@end
