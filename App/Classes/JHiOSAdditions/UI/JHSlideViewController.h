//
//  JHSlideViewController.h
//  TheLifeYouWantTour
//
//  Created by Josh Hudnall on 3/21/14.
//  Copyright (c) 2014 fastPXL. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JHSlideViewMenuDelegate;

@interface JHSlideViewController : UIViewController <UINavigationControllerDelegate>

@property (nonatomic, assign, getter = isMenuOpen) BOOL menuOpen;
@property (nonatomic, readonly) UINavigationController *navController;
@property (nonatomic, strong) UIViewController <JHSlideViewMenuDelegate> *menuViewController;

- (id)initWithRootViewController:(UIViewController *)rootViewController;

- (void)switchToViewController:(UIViewController *)viewController withCompletion:(void (^)())completion;
- (void)openMenuWithCompletion:(void (^)())completion;
- (void)closeMenuWithCompletion:(void (^)())completion;
- (void)toggleMenu;

@end


#pragma mark - JHSlideViewMenuDelegate

@protocol JHSlideViewMenuDelegate <NSObject>

- (void)slideViewDidCloseMenu:(JHSlideViewController *)slideView;

@end



#pragma mark - UIViewController (JHSlideViewController)

@interface UIViewController (JHSlideViewController)

@property (nonatomic, weak) JHSlideViewController *slideViewController;

@end