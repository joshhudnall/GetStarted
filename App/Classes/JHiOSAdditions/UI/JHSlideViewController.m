//
//  JHSlideViewController.m
//
//  Created by Josh Hudnall on 3/21/14.
//  Copyright (c) 2014 Josh Hudnall. All rights reserved.
//

#ifndef IS_IPAD
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPhone)
#endif
#ifndef IS_IOS_7
#define IS_IOS_7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#endif

#import <objc/runtime.h>

#import "JHSlideViewController.h"

@interface JHSlideViewController ()

@property (nonatomic, strong) NSArray *_navConstraints;
@property (nonatomic, strong) NSArray *_menuConstraints;
@property (nonatomic, strong) UITapGestureRecognizer *_tapRecognizer;
@property (nonatomic, strong) UIPanGestureRecognizer *_panRecognizer;
@property (nonatomic, assign) CGPoint _draggingPoint;
@property (nonatomic, assign) CGFloat _slideOffset;
@property (nonatomic, assign) CGFloat _openWidth;
@property (nonatomic, strong) UIButton *_menuButton;

@end

@implementation JHSlideViewController
@synthesize menuViewController = _menuViewController;
@synthesize navController = _navController;
@synthesize _openWidth;

- (id)init {
	if (self = [super init]) {
		[self setup];
	}
    
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super initWithCoder:aDecoder]) {
		[self setup];
	}
    
	return self;
}

- (id)initWithRootViewController:(UIViewController *)rootViewController {
	if (self = [super init]) {
		[self setup];
        
		[self switchToViewController:rootViewController withCompletion:nil];
	}
    
	return self;
}

- (void)setup {
	_navController = [[UINavigationController alloc] init];
	_navController.delegate = self;
	_navController.view.clipsToBounds = YES;
    _navController.view.backgroundColor = [UIColor whiteColor];
    _navController.navigationBar.translucent = NO;
    [_navController.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
	self._openWidth = (IS_IPAD) ? 320 : 272;
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED <= 70000
	if (IS_IOS_7) {
        
	} else {
		self.wantsFullScreenLayout = YES;
	}
#endif
    
    if ( ! IS_IPAD || ! UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
        [self.view addGestureRecognizer:self._panRecognizer];
    }
    
	[self addChildViewController:_navController];
	[self.view addSubview:_navController.view];
	[_navController didMoveToParentViewController:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self updateViewConstraints];
}

- (void)updateViewConstraints {
	[super updateViewConstraints];
    
    UIView *navView = _navController.view;
    UIView *menuView = _menuViewController.view;
	NSDictionary *viewsDict = NSDictionaryOfVariableBindings(navView, menuView);
	NSString *visualFormat;
	NSArray *constraints;
    
    // Navigation Controller
    if (self._navConstraints) {
        [self.view removeConstraints:self._navConstraints];
    }
    
    // Horizontal constraints
    if (IS_IPAD && UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
        visualFormat = [NSString stringWithFormat:@"[navView(768)]|"];
        self._navConstraints = [NSLayoutConstraint constraintsWithVisualFormat:visualFormat
                                                                       options:0
                                                                       metrics:nil
                                                                         views:viewsDict];
    } else {
        visualFormat = [NSString stringWithFormat:@"|[navView]|"];
        self._navConstraints = [NSLayoutConstraint constraintsWithVisualFormat:visualFormat
                                                                       options:0
                                                                       metrics:nil
                                                                         views:viewsDict];
    }
    [self.view addConstraints:self._navConstraints];
    
	visualFormat = [NSString stringWithFormat:@"V:|[navView]|"];
	constraints = [NSLayoutConstraint constraintsWithVisualFormat:visualFormat
                                                          options:0
                                                          metrics:nil
                                                            views:viewsDict];
	[self.view addConstraints:constraints];
    
    
    // Menu Controller
    if (self._menuConstraints) {
        [self.view removeConstraints:self._menuConstraints];
    }
    
    if (IS_IPAD && UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
        CGFloat wideSide = (self.view.frame.size.width > self.view.frame.size.height) ? self.view.frame.size.width : self.view.frame.size.height;
        visualFormat = [NSString stringWithFormat:@"|[menuView(%f)]", wideSide - 768];
        self._menuConstraints = [NSLayoutConstraint constraintsWithVisualFormat:visualFormat
                                                                        options:0
                                                                        metrics:nil
                                                                          views:viewsDict];
    } else {
        visualFormat = [NSString stringWithFormat:@"|[menuView(%f)]", _openWidth];
        self._menuConstraints = [NSLayoutConstraint constraintsWithVisualFormat:visualFormat
                                                                        options:0
                                                                        metrics:nil
                                                                          views:viewsDict];
    }
    [self.view addConstraints:self._menuConstraints];
    
    visualFormat = [NSString stringWithFormat:@"V:|[menuView]|"];
	constraints = [NSLayoutConstraint constraintsWithVisualFormat:visualFormat
                                                          options:0
                                                          metrics:nil
                                                            views:viewsDict];
	[self.view addConstraints:constraints];
    
}

- (void)set_openWidth:(CGFloat)openWidth {
    _openWidth = openWidth;
    
	self._slideOffset = self.view.frame.size.width - self._openWidth;
}

- (void)setMenuViewController:(UIViewController <JHSlideViewMenuDelegate> *)menuViewController {
	// Remove self from an outgoing _menuViewController
	if (_menuViewController) {
		[_menuViewController willMoveToParentViewController:nil];
		_menuViewController.slideViewController = nil;
		[_menuViewController.view removeFromSuperview];
		[_menuViewController removeFromParentViewController];
	}
    
	// Set the property
	_menuViewController = menuViewController;
    [_menuViewController.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
	if (menuViewController) {
		// Add self to an incoming _menuViewController
		menuViewController.slideViewController = self;
        
		[self addChildViewController:_menuViewController];
        //		CGRect frame = self.view.bounds;
        //		frame.size.width = (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) ? self.view.width - 768 : self._openWidth;
        //		_menuViewController.view.frame = frame;
		[self.view insertSubview:_menuViewController.view atIndex:0];
		[_menuViewController didMoveToParentViewController:self];
	}
}

- (void)switchToViewController:(UIViewController *)viewController withCompletion:(void (^)() )completion {
	if ( ! _navController.viewControllers.count || viewController != [_navController.viewControllers objectAtIndex:0]) {
        _navController.toolbarHidden = YES;
        _navController.navigationBarHidden = NO; // Some view controllers may override this, but if not we want to default to NO
        viewController.navigationItem.leftBarButtonItem = [self menuButton];
        viewController.slideViewController = self;
        
        [_navController setViewControllers:@[viewController]];
        
		if ([self isMenuOpen]) {
            [self closeMenuWithCompletion:completion];
		} else {
			if (completion) {
				completion();
			}
		}
	} else {
        [self closeMenuWithCompletion:completion];
    }
}

- (UIBarButtonItem *)menuButton {
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
        return nil;
    }
    
    if ( ! self._menuButton) {
        self._menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self._menuButton addTarget:self action:@selector(toggleMenu) forControlEvents:UIControlEventTouchUpInside];
    }
    [self setMenuButtonImage];
    
	return [[UIBarButtonItem alloc] initWithCustomView:self._menuButton];
}

- (void)setMenuButtonImage {
    UIImage *buttonImage;
    if (self.isMenuOpen) {
        buttonImage = [UIImage imageNamed:@"menu-button"];
    } else {
        buttonImage = [UIImage imageNamed:@"menu-button"];
    }
    
	[self._menuButton setImage:[UIImage imageNamed:@"menu-button"] forState:UIControlStateNormal];
	[self._menuButton setImage:[UIImage imageNamed:@"menu-button"] forState:UIControlStateHighlighted];
	[self._menuButton setImage:[UIImage imageNamed:@"menu-button"] forState:UIControlStateSelected];
	[self._menuButton setImage:[UIImage imageNamed:@"menu-button"] forState:UIControlStateHighlighted | UIControlStateSelected];
	
    CGRect frame = self._menuButton.frame;
	frame.size = [UIImage imageNamed:@"menu-button"].size;
	self._menuButton.frame = frame;
}

- (void)openMenuWithCompletion:(void (^)() )completion {
	[self openMenuWithDuration:0.2f andCompletion:completion];
}

- (void)openMenuWithDuration:(CGFloat)duration andCompletion:(void (^)() )completion {
    if (_menuViewController.view.x == 0) {
        _menuViewController.view.x = -50;
    }
	
    [UIView animateWithDuration:duration
                     animations:^{
                         CGRect frame = _navController.view.frame;
                         frame.origin.x = [self maxXForDragging];
                         _navController.view.frame = frame;
                         _menuViewController.view.x = 0;
                     } completion:^(BOOL finished) {
                         [self setMenuButtonImage];
                         _navController.visibleViewController.view.userInteractionEnabled = NO;
                         
                         if (completion) {
                             completion();
                         }
                     }];
	[_navController.view addGestureRecognizer:self._tapRecognizer];
}

- (void)closeMenuWithCompletion:(void (^)() )completion {
	[self closeMenuWithDuration:0.2f andCompletion:completion];
}

- (void)closeMenuWithDuration:(CGFloat)duration andCompletion:(void (^)() )completion {
	[UIView animateWithDuration:duration
                     animations:^{
                         CGRect frame = _navController.view.frame;
                         frame.origin.x = 0;
                         _navController.view.frame = frame;
                         _menuViewController.view.x = -50;
                     } completion:^(BOOL finished) {
                         [self setMenuButtonImage];
                         _navController.visibleViewController.view.userInteractionEnabled = YES;
                         if ([_menuViewController respondsToSelector:@selector(slideViewDidCloseMenu:)]) {
                             [_menuViewController slideViewDidCloseMenu:self];
                         }
                         
                         if (completion) {
                             completion();
                         }
                     }];
	[_navController.view removeGestureRecognizer:self._tapRecognizer];
}

- (void)toggleMenu {
	[self toggleMenuWithCompletion:nil];
}

- (void)toggleMenuWithCompletion:(void (^)() )completion {
	if (IS_IPAD && UIInterfaceOrientationIsLandscape(self.interfaceOrientation) ) {
		if (completion) {
			completion();
			return;
		}
	}
    
	if (self.isMenuOpen) {
		[self closeMenuWithCompletion:completion];
	} else {
		[self openMenuWithCompletion:completion];
	}
}

- (BOOL)isMenuOpen {
	if (IS_IPAD && UIInterfaceOrientationIsLandscape(self.interfaceOrientation) ) {
		return NO;
	}
    
	return _navController.view.frame.origin.x > 0;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	[super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
	if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation) ) {
		[self.view removeGestureRecognizer:self._panRecognizer];
	} else {
		[self.view addGestureRecognizer:self._panRecognizer];
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	[super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    
	if (IS_IPAD) {
		self._slideOffset = self.view.frame.size.width - self._openWidth;
		[self.view setNeedsLayout];
        [(UIViewController *)[_navController.viewControllers objectAtIndex:0] navigationItem].leftBarButtonItem = [self menuButton];
	}
}


#pragma mark - Gesture Recognizing -

- (UITapGestureRecognizer *)_tapRecognizer {
	if (! __tapRecognizer) {
		__tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
	}
    
	return __tapRecognizer;
}

- (UIPanGestureRecognizer *)_panRecognizer {
	if (! __panRecognizer) {
		__panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panDetected:)];
	}
    
	return __panRecognizer;
}

- (void)tapDetected:(UITapGestureRecognizer *)_tapRecognizer {
	[self closeMenuWithCompletion:nil];
}

- (void)panDetected:(UIPanGestureRecognizer *)a_panRecognizer {
	CGPoint translation = [a_panRecognizer translationInView:a_panRecognizer.view];
	CGPoint velocity = [a_panRecognizer velocityInView:a_panRecognizer.view];
	NSInteger movement = translation.x - self._draggingPoint.x;
    
	if (a_panRecognizer.state == UIGestureRecognizerStateBegan) {
		self._draggingPoint = translation;
	} else if (a_panRecognizer.state == UIGestureRecognizerStateChanged) {
		static CGFloat lastHorizontalLocation = 0;
		CGFloat newHorizontalLocation = [self horizontalLocation];
        
		lastHorizontalLocation = newHorizontalLocation;
        
		newHorizontalLocation += movement;
        
		if (newHorizontalLocation >= self.minXForDragging && newHorizontalLocation <= self.maxXForDragging) {
			[self moveHorizontallyToLocation:newHorizontalLocation];
		}
        
		self._draggingPoint = translation;
	} else if (a_panRecognizer.state == UIGestureRecognizerStateEnded) {
		NSInteger currentX = [self horizontalLocation];
		NSInteger currentXOffset = (currentX > 0) ? currentX : currentX * -1;
		NSInteger positiveVelocity = (velocity.x > 0) ? velocity.x : velocity.x * -1;
        
		// If the speed is high enough follow direction
		if (velocity.x > 0 && positiveVelocity >= 800) {
			[self openMenuWithDuration:0.2 andCompletion:nil];
		} else if (velocity.x <= 0 && positiveVelocity >= 300) {
			[self closeMenuWithDuration:0.13 andCompletion:nil];
		} else {
			if (currentXOffset < (self.horizontalSize - self._slideOffset) / 2) {
				[self closeMenuWithCompletion:nil];
			} else if (currentXOffset < self._openWidth) {
				[self openMenuWithCompletion:nil];
			}
		}
	}
}

- (void)moveHorizontallyToLocation:(CGFloat)location {
	CGRect rect = _navController.view.frame;
	rect.origin.x = location;
	_navController.view.frame = rect;
    
    // x = C + (y - A) * (D - C) / (B - A)  ::  A - B (range 1) normalized to C - D (range 2)
    CGFloat a = 0; CGFloat b = self._openWidth;
    CGFloat c = -50; CGFloat d = 0;
    CGFloat newX = c + (location - a) * (d - c) / (b - a);
	
    rect = _menuViewController.view.frame;
	rect.origin.x = fminf(0, newX);
	_menuViewController.view.frame = rect;
}

- (CGFloat)horizontalLocation {
	return _navController.view.frame.origin.x;
}

- (CGFloat)horizontalSize {
	CGRect rect = _navController.view.frame;
	UIInterfaceOrientation orientation = self.interfaceOrientation;
    
	if (UIInterfaceOrientationIsLandscape(orientation) ) {
		return rect.size.height;
	} else {
		return rect.size.width;
	}
}

- (NSInteger)minXForDragging {
	return 0;
}

- (NSInteger)maxXForDragging {
	return self.horizontalSize - self._slideOffset;
}


#pragma mark - Helpers

- (NSString *)nameOfInterfaceOrientation:(UIInterfaceOrientation)theOrientation {
	NSString *orientationName = nil;
	switch (theOrientation) {
        case UIInterfaceOrientationPortrait:
            orientationName = @"Portrait";     // Home button at bottom
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            orientationName = @"Portrait (Upside Down)";     // Home button at top
            break;
        case UIInterfaceOrientationLandscapeLeft:
            orientationName = @"Landscape (Left)";     // Home button on left
            break;
        case UIInterfaceOrientationLandscapeRight:
            orientationName = @"Landscape (Right)";     // Home button on right
            break;
        default:
            break;
	}
    
	return orientationName;
}

@end


#pragma mark - UIViewController (JHSlideViewController)

@implementation UIViewController (JHSlideViewController)

static void *const kJHSlideViewControllerKey = (void *)&kJHSlideViewControllerKey;

- (void)setSlideViewController:(JHSlideViewController *)slideViewController {
	objc_setAssociatedObject(self, kJHSlideViewControllerKey, slideViewController, OBJC_ASSOCIATION_ASSIGN);
}

- (JHSlideViewController *)slideViewController {
	return objc_getAssociatedObject(self, kJHSlideViewControllerKey);
}

@end