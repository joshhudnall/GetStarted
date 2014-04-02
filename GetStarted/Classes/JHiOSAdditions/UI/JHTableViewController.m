//
//  JHTableViewController.m
//
//  Created by Josh Hudnall on 2/19/12.
//  Copyright (c) 2012 Josh Hudnall. All rights reserved.
//

#import "JHTableViewController.h"

@interface JHTableViewController () {
    UITableViewStyle _tableViewStyle;
}

@end


@implementation JHTableViewController
@synthesize tableView = _tableView;
@synthesize clearsSelectionOnViewWillAppear;
@synthesize paged;
@synthesize lastRowLoaded = _lastRowLoaded;
@synthesize lastPageLoaded = _lastPageLoaded;
@synthesize objects = _objects;

- (id)init {
    self = [self initWithStyle:UITableViewStylePlain];
    if (self) {
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super init];
    if (self) {
        _tableViewStyle = style;
        clearsSelectionOnViewWillAppear = YES; // Defaults to yes
    }
    return self;
}

#pragma mark - View lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];

    // Only create a new tableView if not loading from an XIB
    if ( ! self.tableView || ! self.tableView.superview) {
        self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:_tableViewStyle];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.opaque = NO;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _tableView.scrollsToTop = YES;
        [self.view addSubview:_tableView];
    }
	
	_lastRowLoaded = 0;
	_lastPageLoaded = 0;
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	if (clearsSelectionOnViewWillAppear) {
		[_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:YES];
	}
}

- (void)dataLoaded:(NSError *)error {
    [self.tableView reloadData];
}

- (void)showMessage:(NSString *)message {
    [super showMessage:message];
    
    self.tableView.hidden = YES;
}

- (void)hideMessage {
    [super hideMessage];
    
    self.tableView.hidden = NO;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Override this in your subclass
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
