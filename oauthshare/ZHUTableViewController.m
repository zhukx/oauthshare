//
//  ZHUTableViewController.m
//  oauthshare
//
//  Created by zhukuanxi@gmail.com on 7/10/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//

#import "ZHUTableViewController.h"

@interface ZHUTableViewController ()
- (void)loadMoreData;
- (void)refreshData;
@end

@implementation ZHUTableViewController
@synthesize tableView = _tableView;
@synthesize dataArr = _dataArr;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _dataArr = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // setup the pull-to-refresh view
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds 
                                              style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];

    ZHUTableViewController * __weak wself = self;
    [self.tableView addPullToRefreshWithActionHandler:^{
        [wself refreshData];
    }];
    
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [wself loadMoreData];
    }];
    
    [self.tableView.pullToRefreshView triggerRefresh];
    
    self.tableView.pullToRefreshView.lastUpdatedDate = [NSDate date];
    
     NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
     dateFormatter.dateStyle = NSDateFormatterLongStyle;
     dateFormatter.timeStyle = NSDateFormatterNoStyle;
     self.tableView.pullToRefreshView.dateFormatter = dateFormatter;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)loadMoreData 
{
    NSLog(@"load more data");
    int count = _dataArr.count;
    for (int i = count; i < 20 + count; ++i) {
        [_dataArr addObject:[NSString stringWithFormat:@"row_%d", i]];
    }
//    [self.tableView.infiniteScrollingView stopAnimating];
    [self.tableView performSelector:@selector(reloadData) withObject:nil afterDelay:2];
}

- (void)refreshData {
    NSLog(@"refresh dataSource");
    [_dataArr removeAllObjects];
    [self loadMoreData];
    [self.tableView.pullToRefreshView performSelector:@selector(stopAnimating) withObject:nil afterDelay:2];
}

#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"tableCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSString *content = [_dataArr objectAtIndex:indexPath.row];
    cell.textLabel.text = content;
    return cell;
}
@end
