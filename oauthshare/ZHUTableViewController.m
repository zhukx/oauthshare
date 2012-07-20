//
//  ZHUTableViewController.m
//  oauthshare
//
//  Created by zhukuanxi@gmail.com on 7/10/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//

#define kTableViewFirstPageNum                  (1)
#define kTableViewCountPerPage                  (20)
#import "ZHUTableViewController.h"
#import "ZHUTableViewCell.h"

@interface ZHUTableViewController ()

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
        _viewSizeType = VIEW_SIZE_WITH_NAVIGATIONBAR;
        _pageNum = kTableViewFirstPageNum;
        _countPerPage = kTableViewCountPerPage;
        _cellClass = [ZHUTableViewCell class];
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

}

- (void)refreshData {
    [_dataArr removeAllObjects];
    _pageNum = kTableViewFirstPageNum;
}

- (void)configViewFrame
{
    CGRect frame = [UIScreen mainScreen].bounds;
    if (VIEW_SIZE_NORMAL == _viewSizeType || VIEW_SIZE_WITH_TABBAR_NAVIGATIONBAR == _viewSizeType) {
        frame.size.height -= kDefaultNavbarHeight + kDefaultTabbarHeight + kDefaultStatusbarHeight;
    }
    else if (VIEW_SIZE_WITH_TABBAR == _viewSizeType) {
        frame.size.height -= kDefaultTabbarHeight + kDefaultStatusbarHeight;
    }
    else if (VIEW_SIZE_WITH_NAVIGATIONBAR == _viewSizeType) {
        frame.size.height -= kDefaultNavbarHeight + kDefaultStatusbarHeight;
    }
    else if (VIEW_SIZE_FULLSIZE == _viewSizeType) {
        
    }
    self.view.frame = frame;
    self.tableView.frame = self.view.bounds;
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
        cell = [[_cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    id content = [_dataArr safeObjectAtIndex:indexPath.row];
    if ([cell isKindOfClass:[ZHUTableViewCell class]]) {
        [(ZHUTableViewCell *)cell setCellData:content];
    }
    
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id content = [_dataArr safeObjectAtIndex:indexPath.row];
    return [_cellClass tableView:tableView rowHeightForContent:content];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
