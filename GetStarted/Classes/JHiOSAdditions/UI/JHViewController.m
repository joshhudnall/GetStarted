//
//  JHViewController.m
//  MyDieline
//
//  Created by Josh Hudnall on 5/24/12.
//  Copyright (c) 2012 Method Apps. All rights reserved.
//

#import "JHViewController.h"
#import <AFNetworking/AFNetworking.h>


@interface JHViewController ()

@end

@implementation JHViewController

- (void)viewDidLoad {
	[super viewDidLoad];
    
    if (_apiEndpoint) {
        [self loadData];
    }
}

- (void)setTitle:(NSString *)title {
    NSString *fileName = [NSString stringWithFormat:@"header-%@", [title slug]];
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"png"];
    
    if (imagePath) {
        UIImageView *headerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:fileName]];
        headerImageView.tag = 9001;
        self.navigationItem.titleView = headerImageView;
    } else {
        [super setTitle:title];
    }
    
    self.screenName = title;
}

- (void)loadData {
    NSAssert(_apiEndpoint, @"The self.apiEndpoint parameter must be set unless you overload - (void)loadData.");
    
    [SVProgressHUD showWithStatus:@"Loading..."];
    
    NSString *urlString;
    if ([_apiEndpoint rangeOfString:@"://"].location == NSNotFound) {
        // If it's truly an endpoint, append it to the APIBaseUrl
        urlString = [NSString stringWithFormat:@"%@/%@", kAPIBaseUrl, _apiEndpoint];
    } else {
        // Fully qualified URLs don't need a base
        urlString = _apiEndpoint;
    }

    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url
                                                                cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                                            timeoutInterval:60.0];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        _apiData = responseObject;
        
        [self dataLoaded:nil];
        
        [SVProgressHUD dismiss];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error.code == NSURLErrorNotConnectedToInternet) {
            [SVProgressHUD showErrorWithStatus:@"Not Connected"];
        } else {
            [SVProgressHUD showErrorWithStatus:@"Error"];
        }
        [self dataLoaded:error];
    }];
    [[NSOperationQueue mainQueue] addOperation:op];
}

- (void)dataLoaded:(NSError *)error {
    // Override this in your subclass
    NSAssert(NO, @"Override the dataLoaded: method in your subclass. Do not call [super dataLoaded:]");
}

- (void)showMessage:(NSString *)message {
    if ( ! _messageLabel) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.font = [UIFont boldSystemFontOfSize:18];
        _messageLabel.textColor = [UIColor grayColor];
        _messageLabel.backgroundColor = [UIColor clearColor];
        
        [self.view addSubview:_messageLabel];
    }
    
    _messageLabel.text = message;
    
    [_messageLabel sizeToFit];
    [_messageLabel centerToParent];
    
    _messageLabel.hidden = NO;
}

- (void)hideMessage {
    _messageLabel.hidden = YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return (IS_IPHONE) ? UIInterfaceOrientationPortrait : UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotate {
    return YES;
}

@end


