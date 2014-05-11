//
//  AppDelegate.m
//  GetStarted
//
//  Created by Josh Hudnall on 4/1/14.
//
//

#import "AppDelegate.h"
#import "HockeySDK.h"

@interface AppDelegate ()

@property (nonatomic, strong) id <GAITracker> tracker;
@property (nonatomic, strong) id <GAITracker> secondaryTracker;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    // Basic libraries
    [self setupCocoaLumberjack];
    [self setupHockeyApp];
    [self setupGoogleAnalytics];
    
    // Global Appearance
    [self setupAppearance];
    
    // Create and set window's rootViewController

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)setupCocoaLumberjack {
    // CocoaLumberjack
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    
    // CocoaLumberjack File Logging
    _logFileManager = [[CompressingLogFileManager alloc] init];
    DDFileLogger *fileLogger = [[DDFileLogger alloc] initWithLogFileManager:_logFileManager];
    fileLogger.maximumFileSize  = 1024 * 1024 * 2;  // 2 MB
    fileLogger.rollingFrequency =   60 * 60 * 24 * 10;  // 10 Days
    fileLogger.logFileManager.maximumNumberOfLogFiles = 10;
    [DDLog addLogger:fileLogger];
    
}

- (void)setupHockeyApp {
    if (kHockeyAppID && ! [kHockeyAppID isEmpty]) {
        [[BITHockeyManager sharedHockeyManager] configureWithIdentifier:kHockeyAppID];
        if ([[BITHockeyManager sharedHockeyManager].crashManager isDebuggerAttached]) {
            [[BITHockeyManager sharedHockeyManager] setDisableCrashManager:YES];
        }
        [[BITHockeyManager sharedHockeyManager] startManager];
        [[BITHockeyManager sharedHockeyManager].authenticator authenticateInstallation];
    }
}

- (void)setupGoogleAnalytics {
    if (kTrackingID && ! [kTrackingID isEmpty]) {
        [GAI sharedInstance].dispatchInterval = 120;
        [GAI sharedInstance].trackUncaughtExceptions = YES;
        _tracker = [[GAI sharedInstance] trackerWithTrackingId:kTrackingID];
    }
    if (kSecondaryTrackingID && ! [kSecondaryTrackingID isEmpty]) {
        _secondaryTracker = [[GAI sharedInstance] trackerWithName:kSecondaryTrackingName
                                                       trackingId:kSecondaryTrackingID];
    }
}

- (void)setupAppearance {
    // Setup any UIAppearance properties here
}

@end
