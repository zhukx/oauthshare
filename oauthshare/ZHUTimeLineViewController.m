//
//  ZHUTimeLineViewController.m
//  oauthshare
//
//  Created by zhukuanxi@gmail.com on 7/10/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//

#import "ZHUTimeLineViewController.h"
#import "ZHUSinaWeibomgr.h"
#import "ZHUSinaWBRequestEngine.h"
#import "ZHUSinaStatuses.h"
#import "ZHUTimeLineTableViewCell.h"

@interface ZHUTimeLineViewController ()
- (void)hideTab:(id)sender;
- (void)parseReturnInfo:(id)returnInfo;
- (void)loadRequest;
@end

@implementation ZHUTimeLineViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Home", @"Home");
        _viewSizeType = VIEW_SIZE_WITH_TABBAR_NAVIGATIONBAR;
        _cellClass = [ZHUTimeLineTableViewCell class];
        [[NSNotificationCenter defaultCenter] addObserverForName:kNofityLoginSucess 
                                                          object:nil
                                                           queue:[NSOperationQueue mainQueue]
                                                      usingBlock:^(NSNotification *note) {
                                                          [self.tableView.pullToRefreshView triggerRefresh];
                                                      }];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.tableView.backgroundColor = [UIColor clearColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"HideTab", @"HideTab") 
                                                                             style:UIBarButtonItemStylePlain 
                                                                            target:self
                                                                            action:@selector(hideTab:)];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewDidAppear:(BOOL)animated 
{
    static BOOL bFirst = YES;
    [super viewDidAppear:animated];
    if (bFirst) {
        if ([[ZHUSinaWeibomgr defaultWiboMgr] isLoggedIn]) {
            [self.tableView.pullToRefreshView triggerRefresh];
        }
        else {
            [[ZHUSinaWeibomgr defaultWiboMgr] logIn];
        }
    }
    bFirst = NO;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)hideTab:(id)sender {
    ZHUAppDelegate *appDel = (ZHUAppDelegate *)[[UIApplication sharedApplication] delegate];
    ZHUTabBarViewController *tabCtl = (ZHUTabBarViewController *)[appDel tabBarController];
    if (tabCtl.isHide) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNofityShowTabBar object:self];
    }
    else {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNofityHideTabBar object:self];
    }

    
}

- (void)loadMoreData 
{
    DLog(@"load more data");
    [super loadMoreData];
    [self loadRequest];
}

- (void)refreshData {
    DLog(@"refresh data");
    [super refreshData];
    [self loadRequest];
}

- (void)loadRequest
{
    if (_timeLineOp.isExecuting) {
        return;
    }
    _timeLineOp = [[ZHUSinaWBRequestEngine sharedEngine] getFriendTimeLine:_countPerPage
                                                        page:_pageNum
                                                 finishBlock:^(id returnInfo) {
                                                     //DLog(@"return info \n%@", returnInfo);
                                                     [self parseReturnInfo:returnInfo];
                                                     [self.tableView.pullToRefreshView stopAnimating];
                                                     [self.tableView.infiniteScrollingView stopAnimating];
                                                     self.tableView.pullToRefreshView.lastUpdatedDate = [NSDate date];
                                                     ++_pageNum;
                                                 }
                                                 errorBlock:^(NSError *error) {
                                                    DLog(@"return error \n%@", [error localizedDescription]);
                                                    [self.tableView.pullToRefreshView stopAnimating];
                                                    [self.tableView.infiniteScrollingView stopAnimating];
                                                }];
}

- (void)parseReturnInfo:(id)returnInfo
{
    if (![returnInfo isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    NSArray *statusArr = [returnInfo objectForKey:[ZHUSinaStatuses dataKey]];
    __block ZHUSinaStatuses *status = nil;
    [statusArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (![obj isKindOfClass:[NSDictionary class]]) {
            *stop = YES;
        }
        status = [[ZHUSinaStatuses alloc] initWithDic:obj];

        [self.dataArr safeAddObject:status];
    }];
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"timelineTableCell";
    ZHUTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[ZHUTimeLineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    id content = [_dataArr safeObjectAtIndex:indexPath.row];
    [cell setCellData:content];
    return cell;
}
@end
