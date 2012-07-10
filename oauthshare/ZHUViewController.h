//
//  ZHUViewController.h
//  zhuTabbarController
//
//  Created by zhukuanxi@gmail.com on 7/10/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//

typedef enum {
    VIEW_SIZE_NORMAL,
    VIEW_SIZE_FULLSCREEN,
    VIEW_SIZE_WITH_TABBAR,
    VIEW_SIZE_WITH_NAVIGATIONBAR,
    VIEW_SIZE_WITH_TABBAR_NAVIGATIONBAR
}ZHUViewSizeType;

#import <UIKit/UIKit.h>

@interface ZHUViewController : UIViewController {
    BOOL _isTabBarSize;
    BOOL _isHideTabBar;
    ZHUViewSizeType _viewSizeType;
}

@property (assign, nonatomic) BOOL isTabBarSize;
@property (assign, nonatomic) BOOL isHideTabBar;
@property (assign, nonatomic) ZHUViewSizeType viewSizeType;
@end
