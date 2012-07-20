//
//  ZHUTimeLineViewController.m
//  oauthshare
//
//  Created by zhukuanxi@gmail.com on 7/10/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//
#ifdef LOAD_CELL_IMAGE_IN_CONTROLLER
static const char *imageDownloadQueue = "UIScrollViewPullToRefreshView";
#endif

#import "ZHUTimeLineViewController.h"
#import "ZHUSinaWeibomgr.h"
#import "ZHUSinaWBRequestEngine.h"
#import "ZHUSinaStatuses.h"
#import "ZHUTimeLineTableViewCell.h"
#import "ZHUWBImageRequestEngine.h"

@interface ZHUTimeLineViewController ()
- (void)hideTab:(id)sender;
- (void)parseReturnInfo:(id)returnInfo;
- (void)loadRequest;
#ifdef LOAD_CELL_IMAGE_IN_CONTROLLER
- (void)cancelImageLoad;
- (NSString *)generateKeyWith:(NSIndexPath *)index type:(int)type;
- (BOOL)checkImageRequest:(NSIndexPath *)indexPath type:(TLImageType)type image:(UIImage **)image;
#endif
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
#ifdef LOAD_CELL_IMAGE_IN_CONTROLLER
        _imageLoadDic = [[NSMutableDictionary alloc] init];
#endif
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
#ifdef LOAD_CELL_IMAGE_IN_CONTROLLER
    [self cancelImageLoad];
#endif
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

#ifdef LOAD_CELL_IMAGE_IN_CONTROLLER
- (void)cancelImageLoad 
{
    [[_imageLoadDic allValues] makeObjectsPerformSelector:@selector(cancel)];
    [_imageLoadDic removeAllObjects];    
}

- (void)loadImage:(NSString *)imageUrl atIndexPath:(NSIndexPath *)indexPath withType:(TLImageType)type
{
    ZHUWBRequest *operation = (ZHUWBRequest *)[[ZHUWBImageRequestEngine sharedEngine] imageAtURL:[NSURL URLWithString:imageUrl] 
                                                                          onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) { 
                                                                              NSArray *visibleIndex = [self.tableView indexPathsForVisibleRows];
                                                                              if ([visibleIndex containsObject:indexPath]) {
                                                                                  ZHUTimeLineTableViewCell *curCell = (ZHUTimeLineTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
                                                                                  [curCell refreshContentView:type withObject:fetchedImage];   
                                                                              }
                                                                          }];    

    NSString *key = [self generateKeyWith:indexPath type:type];
    NSLog(@"--%@", key);
    [_imageLoadDic setObject:operation forKey:key];
}

- (NSString *)generateKeyWith:(NSIndexPath *)indexPath type:(int)type
{
    return [NSString stringWithFormat:@"%d-%d-%d", indexPath.section, indexPath.row, type];
}

- (BOOL)checkImageRequest:(NSIndexPath *)indexPath type:(TLImageType)type image:(UIImage **)image
{
    BOOL bResult = NO;
    NSString *key = [self generateKeyWith:indexPath type:type];
    ZHUWBRequest *operation = [_imageLoadDic objectForKey:key];
    if (operation) {
        if (image) {
            *image = [operation responseImage];
            bResult = YES;
        }
    }
    return bResult;
}
#endif

- (void)parseReturnInfo:(id)returnInfo
{
    if (![returnInfo isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    NSArray *statusArr = [returnInfo objectForKey:[ZHUSinaStatuses dataKey]];

    [statusArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (![obj isKindOfClass:[NSDictionary class]]) {
            *stop = YES;
        }
        ZHUSinaStatuses *status = [[ZHUSinaStatuses alloc] initWithDic:obj];

        [self.dataArr safeAddObject:status];
#ifdef LOAD_CELL_IMAGE_IN_CONTROLLER        
        if (!_imageQueue) {
            _imageQueue = dispatch_queue_create(imageDownloadQueue, nil);
        }
        
        NSIndexPath *curIndex = [NSIndexPath indexPathForRow:self.dataArr.count - 1 inSection:0];
        dispatch_async(_imageQueue, ^{
            if (status.thumbnail_pic.length) {
                [self loadImage:status.thumbnail_pic atIndexPath:curIndex withType:IMAGE_TYPE_THUMBNAIL];
            }
            
            ZHUSinaUser *user = status.user;
            if (user.avatar_large.length) {
                [self loadImage:user.avatar_large atIndexPath:curIndex withType:IMAGE_TYPE_AVATAR];
            }
        });
#endif
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
#ifdef LOAD_CELL_IMAGE_IN_CONTROLLER        
    ZHUSinaStatuses *status = content;
    if (status.thumbnail_pic.length) {
        UIImage *image = nil;
        BOOL imageExist = [self checkImageRequest:indexPath
                                             type:IMAGE_TYPE_THUMBNAIL 
                                            image:&image];
        if (!imageExist) {
            [self loadImage:status.thumbnail_pic
                atIndexPath:indexPath 
                   withType:IMAGE_TYPE_THUMBNAIL];
        }
        if (image) {
            [(ZHUTimeLineTableViewCell *)cell refreshContentView:IMAGE_TYPE_THUMBNAIL withObject:image];
        }
    }
    
    ZHUSinaUser *user = status.user;
    if (user.avatar_large.length) {
        UIImage *image = nil;
        BOOL imageExist = [self checkImageRequest:indexPath
                                             type:IMAGE_TYPE_AVATAR 
                                            image:&image];
        if (!imageExist) {
            [self loadImage:status.user.avatar_large
                atIndexPath:indexPath 
                   withType:IMAGE_TYPE_AVATAR];
        }
        if (image) {
            [(ZHUTimeLineTableViewCell *)cell refreshContentView:IMAGE_TYPE_AVATAR withObject:image];
        }
    }
#endif
    return cell;
}
@end
