//
//  JHMath.h
//  GetStarted
//
//  Created by Josh Hudnall on 4/4/14.
//
//

#import <Foundation/Foundation.h>

/* Value Range */
struct JHValueRange {
    CGFloat first;
    CGFloat last;
};
typedef struct JHValueRange JHValueRange;

/* Make a ValueRange */
extern JHValueRange JHValueRangeMake(CGFloat first, CGFloat last);

@interface JHMath : NSObject

/*
 * Takes a value within the range fromRange and converts it to a corresponding value within toRange
 */
+ (CGFloat)convertValue:(CGFloat)value fromRange:(JHValueRange)fromRange toRange:(JHValueRange)toRange;

@end
