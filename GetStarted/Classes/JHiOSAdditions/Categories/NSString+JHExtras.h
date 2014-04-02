//
//  NSString+JHExtras.h
//
//  Created by Josh Hudnall on 6/6/12.
//  Copyright (c) 2012 Method Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JHExtras)

- (NSString *) stripWhitespace;

- (NSString *)truncateToLength:(NSUInteger)length;
- (NSString *)truncateToLength:(NSUInteger)length inMiddle:(BOOL)inMiddle;
- (NSString *)truncateToLength:(NSUInteger)length inMiddle:(BOOL)inMiddle withChar:(NSString *)withChar;

+ (NSString *)singular:(NSString *)singular orPlural:(NSString *)plural forCount:(NSInteger)count;
+ (NSString *)zero:(NSString *)zero singular:(NSString *)singular orPlural:(NSString *)plural forCount:(NSInteger)count;

- (NSString *)stringByStrippingHTML;

- (NSString *)slug;

- (BOOL)isEmpty;

@end
