//
//  NSMutableArray+JHExtras.h
//  Connoshoer
//
//  Created by Josh Hudnall on 1/1/13.
//  Copyright (c) 2013 Connoshoer. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef BOOL(^JHComparator)(id array, id obj);

@interface NSMutableArray (JHExtras)

- (void)addUniqueObjectsFromArray:(NSArray *)array usingComparator:(JHComparator)comparator;

@end
