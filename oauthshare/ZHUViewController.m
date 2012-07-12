//
//  ZHUViewController.m
//  oauthshare
//
//  Created by zhukuanxi@gmail.com on 7/10/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//

#import "ZHUViewController.h"

@interface ZHUViewController ()

@end

@implementation ZHUViewController
@synthesize isTabBarSize = _isTabBarSize;
@synthesize isHideTabBar = _isHideTabBar;
@synthesize viewSizeType = _viewSizeType;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _isHideTabBar = NO;
        _isTabBarSize = YES;//controll the view size +- tabbar height
        _viewSizeType = VIEW_SIZE_NORMAL;
        self.hidesBottomBarWhenPushed = YES;//need this to make transparent tabbar
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    CGRect frame = self.view.frame;
    if (VIEW_SIZE_NORMAL == _viewSizeType || VIEW_SIZE_WITH_TABBAR_NAVIGATIONBAR == _viewSizeType) {
        frame.size.height -= kDefaultNavbarHeight + kDefaultTabbarHeight;
    }
    else if (VIEW_SIZE_WITH_TABBAR == _viewSizeType) {
        frame.size.height -= kDefaultTabbarHeight;
    }
    else if (VIEW_SIZE_WITH_NAVIGATIONBAR == _viewSizeType) {
        frame.size.height -= kDefaultNavbarHeight;
    }
    else if (VIEW_SIZE_FULLSIZE == _viewSizeType) {
        
    }
    self.view.frame = frame;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.isHideTabBar) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNofityHideTabBar object:self];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.isHideTabBar) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNofityShowTabBar object:self];
    }
}
@end
