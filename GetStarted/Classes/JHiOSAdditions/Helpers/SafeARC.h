//
//  SafeARC.h
//  Connoshoer
//
//  Created by Josh Hudnall on 12/22/12.
//  Copyright (c) 2012 Connoshoer. All rights reserved.
//

#ifndef JH_SafeARC
#define JH_SafeARC
#if __has_feature(objc_arc)
#define JH_STRONG strong
#else
#define JH_STRONG retain
#endif

#if __has_feature(objc_arc_weak)
#define JH_WEAK weak
#elif __has_feature(objc_arc)
#define JH_WEAK unsafe_unretained
#else
#define JH_WEAK assign
#endif

#if __has_feature(objc_arc)
#define JH_AUTORELEASE(exp) exp
#define JH_RELEASE(exp) exp
#define JH_RETAIN(exp) exp
#else
#define JH_AUTORELEASE(exp) [exp autorelease]
#define JH_RELEASE(exp) [exp release]
#define JH_RETAIN(exp) [exp retain]
#endif
#endif