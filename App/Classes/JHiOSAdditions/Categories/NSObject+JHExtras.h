//
//  NSObject+JHExtras.h
//  Connoshoer
//
//  Created by Josh Hudnall on 1/3/13.
//  Copyright (c) 2013 Connoshoer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (JHExtras)

- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;

@end
