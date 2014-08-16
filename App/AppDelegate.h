//
//  AppDelegate.h
//
//  Created by Josh Hudnall on 4/1/14.
//
//

#import <UIKit/UIKit.h>
#import "CompressingLogFileManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, readonly) CompressingLogFileManager *logFileManager;

@end
