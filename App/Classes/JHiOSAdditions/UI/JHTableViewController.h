//
//  JHTableViewController.h
//
//  Created by Josh Hudnall on 2/19/12.
//  Copyright (c) 2012 Josh Hudnall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHViewController.h"
#import "UITableView+JHExtras.h"

@interface JHTableViewController : JHViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic) BOOL clearsSelectionOnViewWillAppear;

@property (nonatomic, unsafe_unretained) BOOL paged;
@property (nonatomic, unsafe_unretained) int lastRowLoaded;
@property (nonatomic, unsafe_unretained) int lastPageLoaded;
@property (nonatomic, readonly) NSArray *objects;

- (id)initWithStyle:(UITableViewStyle)style;

@end
