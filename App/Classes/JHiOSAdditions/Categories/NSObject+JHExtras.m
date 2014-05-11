//
//  NSObject+JHExtras.m
//  Connoshoer
//
//  Created by Josh Hudnall on 1/3/13.
//  Copyright (c) 2013 Connoshoer. All rights reserved.
//

#import "NSObject+JHExtras.h"

@implementation NSObject (JHExtras)

- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay
{
    block = [block copy];
    [self performSelector:@selector(fireBlockAfterDelay:)
               withObject:block
               afterDelay:delay];
}

- (void)fireBlockAfterDelay:(void (^)(void))block {
    block();
}

@end
