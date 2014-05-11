//
//  NSDate+JHExtras.m
//  MyDieline
//
//  Created by Josh Hudnall on 6/3/12.
//  Copyright (c) 2012 Method Apps. All rights reserved.
//

#import "NSDate+JHExtras.h"

@implementation NSDate (JHExtras)

- (NSString *)relativeTimeFromNow {
    NSDate *origDate = self;
    NSDate *todayDate = [NSDate date];
    double ti = [origDate timeIntervalSinceDate:todayDate];
    ti = ti * -1;
    if(ti < 1) { // Use "now" if less than a second
        return @"now";
    } else if (ti < 60) { // Use "now" if less than a minute
        return @"now";
    } else if (ti < 60 * 60) { // Use minutes if under an hour
        int diff = round(ti / 60);
        return [NSString stringWithFormat:@"%dm", diff];
    } else if (ti < 60 * 60 * 24) { // Use hours if under a day
        int diff = round(ti / 60 / 60);
        return[NSString stringWithFormat:@"%dh", diff];
    } else if (ti < 60 * 60 * 24 * 7) { // Use days if under a week
        int diff = round(ti / 60 / 60 / 24);
        return[NSString stringWithFormat:@"%dd", diff];
    } else if (ti < 60 * 60 * 24 * 7 * 52 * 2) { // Use weeks if under two years
        int diff = round(ti / 60 / 60 / 24 / 7);
        return[NSString stringWithFormat:@"%dw", diff];
    } else { // Use years for everything else
        int diff = round(ti / 60 / 60 / 24 / 7);
        return[NSString stringWithFormat:@"%dy", diff];
    }
}

+ (NSDate *)dateFromMySqlString:(NSString *)dateString {
    static NSDateFormatter *mysqlDateFormatter = nil;
    if (mysqlDateFormatter == nil) {
        mysqlDateFormatter = [[NSDateFormatter alloc] init];
    }
    
    if (dateString.length == 10) {
        mysqlDateFormatter.dateFormat = @"yyyy-MM-dd";
    } else if (dateString.length == 8) {
        mysqlDateFormatter.dateFormat = @"HH:mm:ss";
    } else {
        mysqlDateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    }
    
    return [mysqlDateFormatter dateFromString:dateString];
}

+ (NSDate *)dateFromTwitter:(NSString *)dateString {
    static NSDateFormatter *twitterDateFormatter = nil;
    if (twitterDateFormatter == nil) {
        twitterDateFormatter = [[NSDateFormatter alloc] init];

        // http://stackoverflow.com/a/11603484/350467
        // here we set the DateFormat - note the quotes around +0000
        [twitterDateFormatter setDateFormat:@"EEE MMM dd HH:mm:ss '+0000' yyyy"];
        // We need to set the locale to english - since the day- and month-names are in english
        [twitterDateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en-US"]];
    }
    
    return [twitterDateFormatter dateFromString:dateString];
}

- (NSString *)dateFormatted:(NSString *)dateFormat {
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
    }
    static NSString *savedDateFormat = nil;
    if (savedDateFormat == nil || ! [savedDateFormat isEqualToString:dateFormat]) {
        dateFormatter.dateFormat = dateFormat;
        savedDateFormat = [dateFormat copy];
    }
    
    return [dateFormatter stringFromDate:self];
}

+ (NSString *)convertDateFromMySql:(NSString *)dateString toFormat:(NSString *)dateFormat {
    return [[NSDate dateFromMySqlString:dateString] dateFormatted:dateFormat];
}

@end




