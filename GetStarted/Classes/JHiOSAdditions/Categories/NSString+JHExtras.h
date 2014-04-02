//
//  NSString+JHExtras.h
//
//  Created by Josh Hudnall on 6/6/12.
//  Copyright (c) 2012 Method Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JHExtras)

- (NSString *) stripWhitespace;

- (NSString *)jh_truncateToLength:(NSUInteger)length;
- (NSString *)jh_truncateToLength:(NSUInteger)length inMiddle:(BOOL)inMiddle;
- (NSString *)jh_truncateToLength:(NSUInteger)length inMiddle:(BOOL)inMiddle withChar:(NSString *)withChar;

+ (NSString *)jh_singular:(NSString *)singular orPlural:(NSString *)plural forCount:(NSInteger)count;
+ (NSString *)jh_zero:(NSString *)zero singular:(NSString *)singular orPlural:(NSString *)plural forCount:(NSInteger)count;

- (NSString *)stringByStrippingHTML;

- (NSString *)slug;

- (BOOL)isEmpty;

@end
