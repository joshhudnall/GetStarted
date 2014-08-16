//
//  JHBeSocial.m
//
//  Created by Josh Hudnall on 3/25/14.
//
//

#import "JHBeSocial.h"
#import "PRPAlertView.h"

typedef NS_ENUM(NSUInteger, TwitterApp) {
    TwitterAppTweetbot,
    TwitterAppTwitter,
    TwitterAppSafari,
};

@implementation JHBeSocial

+ (void)openTwitterProfile:(NSString *)username {
    if ([self hasTweetbot]) {
        [self openTwitterLink:[NSURL URLWithString:[NSString stringWithFormat:@"tweetbot:///user_profile/%@", username]] inApp:TwitterAppTweetbot];
        
    } else if ([self hasTwitter]) {
        [self openTwitterLink:[NSURL URLWithString:[NSString stringWithFormat:@"twitter://user?screen_name=%@", username]] inApp:TwitterAppTwitter];
        
    } else {
        [self openTwitterLink:[NSURL URLWithString:[NSString stringWithFormat:@"http://twitter.com/%@", username]] inApp:TwitterAppSafari];
    }
}

+ (void)openTwitterStatus:(NSString *)username tweet:(unsigned long long)tweetID {
    if ([self hasTweetbot]) {
        [self openTwitterLink:[NSURL URLWithString:[NSString stringWithFormat:@"tweetbot:///status/%llu", tweetID]] inApp:TwitterAppTweetbot];
        
    } else if ([self hasTwitter]) {
        [self openTwitterLink:[NSURL URLWithString:[NSString stringWithFormat:@"twitter://status?id=%llu", tweetID]] inApp:TwitterAppTwitter];
        
    } else {
        [self openTwitterLink:[NSURL URLWithString:[NSString stringWithFormat:@"http://twitter.com/%@/status/%llu", username, tweetID]] inApp:TwitterAppSafari];
    }
}

+ (BOOL)hasTweetbot {
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetbot:///user_profile/peopleinspace"]];
}

+ (BOOL)hasTwitter {
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://user?screen_name=peopleinspace"]];
}

+ (void)openTwitterLink:(NSURL *)url inApp:(TwitterApp)app {
    NSString *alertMessage = @"";
    NSString *alertActionButton = @"";
    if (app == TwitterAppTweetbot) {
        alertMessage = @"This will take you to Tweetbot. Do you want to continue?";
        alertActionButton = @"Open Tweetbot";
    } else if (app == TwitterAppTwitter) {
        alertMessage = @"This will take you to the Twitter app. Do you want to continue?";
        alertActionButton = @"Open Twitter";
    } else {
        alertMessage = @"This will take you to Safari. Do you want to continue?";
        alertActionButton = @"Open Safari";
    }
    
    [PRPAlertView showWithTitle:@"Leave App?"
                        message:alertMessage
                    cancelTitle:@"Cancel"
                    cancelBlock:nil
                     otherTitle:alertActionButton
                     otherBlock:^(UIAlertView *alertView) {
                         [[UIApplication sharedApplication] openURL:url];
                     }];
}

@end
