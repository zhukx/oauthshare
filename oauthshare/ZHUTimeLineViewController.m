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
#import "ZHUSINAStatuses.h"
#import "ZHUTimeLineTableViewCell.h"

@interface ZHUTimeLineViewController ()
- (void)hideTab:(id)sender;
- (void)parseReturnInfo:(id)returnInfo;
@end

@implementation ZHUTimeLineViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Home", @"Home");
        self.viewSizeType = VIEW_SIZE_WITH_NAVIGATIONBAR;
        _countPerPage = 10;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
        [[ZHUSinaWeibomgr defaultWiboMgr] logIn];
    }
    bFirst = NO;
    
    if ([[ZHUSinaWeibomgr defaultWiboMgr] isLoggedIn]) {
        [self refreshData];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)hideTab:(id)sender {
    ZHUAppDelegate *appDel = (ZHUAppDelegate *)[[UIApplication sharedApplication] delegate];
    ZHUTabBarViewController *tabCtl = (ZHUTabBarViewController *)[appDel tabBarController];
    [tabCtl hideTabbar:!tabCtl.isHide animated:YES];
}

- (void)loadMoreData 
{
    NSLog(@"load more data");
    [super loadMoreData];
    int count = _dataArr.count;
    for (int i = count; i < 20 + count; ++i) {
        [_dataArr addObject:[NSString stringWithFormat:@"row_%d", i]];
    }
    [self.tableView.infiniteScrollingView stopAnimating];
}

- (void)refreshData {
    NSLog(@"refresh data");
    [super refreshData];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [[ZHUSinaWeibomgr defaultWiboMgr] accessToken], @"access_token", 
                         [NSString stringWithFormat:@"%d", _countPerPage], @"count",
                         [NSString stringWithFormat:@"%d", _pageNum], @"page",
                         @"0", @"feature",
                         nil];
    ZHUWBRequest *request = [[ZHUWBRequest alloc] initWithURLString:[NSString stringWithFormat:@"%@/%@", kSinaUrlDomain, kSinaUrlFriendTimeLine] 
                                                             params:dic 
                                                         httpMethod:@"GET" 
                                                        finishBlock:^(id returnInfo) {
                                                            NSLog(@"return info \n%@", returnInfo);
                                                            [self parseReturnInfo:returnInfo];
                                                            [self.tableView.pullToRefreshView stopAnimating];
                                                        } 
                                                         errorBlock:^(NSError *error) {
                                                             NSLog(@"return error \n%@", [error localizedDescription]);
                                                             [self.tableView.pullToRefreshView stopAnimating];
                                                         }];
    NSLog(@"request url \n%@", request.url);
    [[ZHUSinaWBRequestEngine sharedEngine] loadWBRequest:request];
}

- (void)parseReturnInfo:(id)returnInfo
{
    if (![returnInfo isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    NSArray *statusArr = [returnInfo objectForKey:FTL_STATUS];
    __block ZHUSINAStatuses *status = nil;
    [statusArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (![obj isKindOfClass:[NSDictionary class]]) {
            *stop = YES;
        }
        status = [[ZHUSINAStatuses alloc] init];
        status.idstr = [obj objectForKey:FTL_IDSTR];
        status.idstr = [obj objectForKey:FTL_CREATEAT];
        status.idstr = [obj objectForKey:FTL_ID];
        status.idstr = [obj objectForKey:FTL_TEXT];
        status.idstr = [obj objectForKey:FTL_SOURCE];
        status.idstr = [obj objectForKey:FTL_FAVORITED];
        status.idstr = [obj objectForKey:FTL_TRUNCATED];
        status.idstr = [obj objectForKey:FTL_INREPLYTOSTATUSID];
        status.idstr = [obj objectForKey:FTL_INREPLYTOUSERID];
        status.idstr = [obj objectForKey:FTL_INREPLYTOSCREENNAME];
        status.idstr = [obj objectForKey:FTL_MID];
        status.idstr = [obj objectForKey:FTL_BMIDDLEPIC];
        status.idstr = [obj objectForKey:FTL_ORIGINALPIC];
        status.idstr = [obj objectForKey:FTL_THUMBNAILPIC];
        status.idstr = [obj objectForKey:FTL_REPOSTSCOUNT];
        status.idstr = [obj objectForKey:FTL_COMMENTSCOUNT];
//        status.idstr = [obj objectForKey:FTL_ANNOTATIONS];
//        status.idstr = [obj objectForKey:FTL_GEO];
//        status.idstr = [obj objectForKey:FTL_USER];
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
    
    id content = [_dataArr objectAtIndex:indexPath.row];
    [cell setCellData:content];
    return cell;
}
@end
