//
//  NGAParallaxMotion.m
//
//  Created by Michael Bishop on 7/4/13.
//  Copyright (c) 2013 Numerical Garden. All rights reserved.
//
//  Modified by Josh Hudnall on 2/14/14 to allow different horizontal and vertical intensities
//

#import "NGAParallaxMotion.h"
#import <objc/runtime.h>

static void *const kNGAParallaxDepthKey = (void*)&kNGAParallaxDepthKey;

@implementation UIView (NGAParallaxMotion)
#if __IPHONE_OS_VERSION_MAX_ALLOWED < 70000
#warning DISABLED WITHOUT IOS7 SDK
#else
static void *const kNGAParallaxMotionEffectGroupKey = (void*)&kNGAParallaxMotionEffectGroupKey;
#endif

-(void)setParallaxIntensity:(CGVector)parallaxDepth
{
    if (self.parallaxIntensity.dx == parallaxDepth.dx && self.parallaxIntensity.dy == parallaxDepth.dy)
        return;
    
    objc_setAssociatedObject(self, kNGAParallaxDepthKey, @[@(parallaxDepth.dx), @(parallaxDepth.dy)], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    // skip this part if pre-iOS7
    
    if (![UIInterpolatingMotionEffect class])
        return;
        
    if (parallaxDepth.dx == 0.0 && parallaxDepth.dy == 0.0)
    {
        [self removeMotionEffect:[self nga_parallaxMotionEffectGroup]];
        [self nga_setParallaxMotionEffectGroup:nil];
        return;
    }

    UIMotionEffectGroup *parallaxGroup = [self nga_parallaxMotionEffectGroup];
    if (!parallaxGroup)
    {
        parallaxGroup = [[UIMotionEffectGroup alloc] init];
        [self nga_setParallaxMotionEffectGroup:parallaxGroup];
        [self addMotionEffect:parallaxGroup];
    }
    
    UIInterpolatingMotionEffect *xAxis = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    xAxis.maximumRelativeValue = @(parallaxDepth.dx);
    xAxis.minimumRelativeValue = @(-parallaxDepth.dx);

    UIInterpolatingMotionEffect *yAxis = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    yAxis.maximumRelativeValue = @(parallaxDepth.dy);
    yAxis.minimumRelativeValue = @(-parallaxDepth.dy);
    
    parallaxGroup.motionEffects = @[xAxis, yAxis];
#endif
}

-(CGVector)parallaxIntensity
{
    NSArray *val = objc_getAssociatedObject(self, kNGAParallaxDepthKey);
    if ( ! val || ! [val count])
        return CGVectorMake(0, 0);
    return CGVectorMake([[val objectAtIndex:0] doubleValue], [[val objectAtIndex:1] doubleValue]);
}

#pragma mark -

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000

-(void)nga_setParallaxMotionEffectGroup:(UIMotionEffectGroup*)group
{
    objc_setAssociatedObject(self, kNGAParallaxMotionEffectGroupKey, group, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    NSAssert( group == objc_getAssociatedObject(self, kNGAParallaxMotionEffectGroupKey), @"set didn't work" );
}

-(UIMotionEffectGroup*)nga_parallaxMotionEffectGroup
{
    return objc_getAssociatedObject(self, kNGAParallaxMotionEffectGroupKey);
}
#endif

@end


