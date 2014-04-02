//
//  NSDate+JHExtras.h
//  MyDieline
//
//  Created by Josh Hudnall on 6/3/12.
//  Copyright (c) 2012 Method Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (JHExtras)

- (NSString *)jh_relativeTimeFromNow;
+ (NSDate *)dateFromMySqlString:(NSString *)dateString;
+ (NSDate *)dateFromTwitter:(NSString *)dateString;
- (NSString *)dateFormatted:(NSString *)dateFormat;
+ (NSString *)convertDateFromMySql:(NSString *)dateString toFormat:(NSString *)dateFormat;

@end
