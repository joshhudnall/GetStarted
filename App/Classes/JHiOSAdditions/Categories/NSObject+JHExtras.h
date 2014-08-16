//
//  NSObject+JHExtras.h
//
//  Created by Josh Hudnall on 1/3/13.
//  Copyright (c) 2013 Josh Hudnall. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (JHExtras)

/**
 *  Performs a block after the specified delay using GCD
 *
 *  @param block The block to perform
 *  @param delay Delay in seconds
 */
- (void)jh_performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;

@end
