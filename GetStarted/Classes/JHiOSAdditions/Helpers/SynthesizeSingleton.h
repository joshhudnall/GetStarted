//
//  SynthesizeSingleton.h
//  CocoaWithLove
//
//  Created by Matt Gallagher on 20/10/08.
//  Copyright 2008 Matt Gallagher. All rights reserved.
//
//  Permission is given to use this source code file, free of charge, in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//

#define SYNTHESIZE_SINGLETON_FOR_CLASS(classname) \
 \
static classname *sharedInstance = nil; \
 \
+ (classname *)sharedInstance \
{ \
	@synchronized(self) \
	{ \
		if (sharedInstance == nil) \
		{ \
			sharedInstance = [[self alloc] init]; \
		} \
	} \
	 \
	return sharedInstance; \
} \
 \
+ (id)allocWithZone:(NSZone *)zone \
{ \
	@synchronized(self) \
	{ \
		if (sharedInstance == nil) \
		{ \
			sharedInstance = [super allocWithZone:zone]; \
			return sharedInstance; \
		} \
	} \
	 \
	return nil; \
} \
 \
- (id)copyWithZone:(NSZone *)zone \
{ \
	return self; \
}