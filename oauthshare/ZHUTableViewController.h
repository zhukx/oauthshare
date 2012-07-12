//
//  ZHUTableViewController.h
//  oauthshare
//
//  Created by zhukuanxi@gmail.com on 7/10/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHUViewController.h"
#import "SVPullToRefresh.h"
#import "ZHUAppDelegate.h"
#import "ZHUTabBarViewController.h"

@interface ZHUTableViewController : ZHUViewController <UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray *_dataArr;
    NSInteger _pageNum;
    NSInteger _countPerPage;
    Class   _cellClass;
}

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArr;
- (void)loadMoreData;
- (void)refreshData;
@end
