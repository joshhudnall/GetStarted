//
//  JHSlideViewController.h
//  TheLifeYouWantTour
//
//  Created by Josh Hudnall on 3/21/14.
//  Copyright (c) 2014 fastPXL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHSlideViewController : UIViewController <UINavigationControllerDelegate>

@property (nonatomic, assign, getter = isMenuOpen) BOOL menuOpen;
@property (nonatomic, readonly) UINavigationController *navController;
@property (nonatomic, strong) UIViewController *menuViewController;

- (id)initWithRootViewController:(UIViewController *)rootViewController;

- (void)switchToViewController:(UIViewController *)viewController withCompletion:(void (^)())completion;
- (void)openMenuWithCompletion:(void (^)())completion;
- (void)closeMenuWithCompletion:(void (^)())completion;
- (void)toggleMenu;

@end


#pragma mark - UIViewController (JHSlideViewController)

@interface UIViewController (JHSlideViewController)

@property (nonatomic, weak) JHSlideViewController *slideViewController;

@end