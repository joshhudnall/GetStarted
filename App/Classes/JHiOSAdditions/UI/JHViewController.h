//
//  JHViewController.h
//
//  Created by Josh Hudnall on 5/24/12.
//  Copyright (c) 2012 Josh Hudnall. All rights reserved.
//
//


#import <UIKit/UIKit.h>
#import "GAI.h"

@interface JHViewController : GAITrackedViewController

@property (nonatomic, strong) NSString *apiEndpoint;
@property (nonatomic, readonly) id apiData;
@property (nonatomic, readonly) UILabel *messageLabel;

- (void)loadData;
- (void)dataLoaded:(NSError *)error;

- (void)showMessage:(NSString *)message;
- (void)hideMessage;

@end


