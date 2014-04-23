//
//  Singleton.m
//  GetStarted
//
//  Created by Josh Hudnall on 4/23/14.
//
//

#import "JHSingleton.h"

@implementation JHSingleton

+ (instancetype)sharedInstance {
    __strong static id _sharedObject = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

#ifdef kForceSingleton
- (id)allocWithZone:(NSZone *)zone {
    return [[self class] sharedInstance];
}

- (id)init {
    return [[self class] sharedInstance];
}
#endif

@end
