//
//  ZHUDef.h
//  zhukxContact
//
//  Created by zhukuanxi@gmail.com on 6/24/12.
//  Copyright (c) 2012 Tencent. All rights reserved.
//

#ifndef zhukxContact_ZHUDef_h
#define zhukxContact_ZHUDef_h

#import <QuartzCore/QuartzCore.h>
#import "ZHUAdditions.h"
#import "ZHUUtil.h"
#import "ZHUImageView.h"
#import "MKNetworkKit.h"



#define kNofityChangeBadge          (@"changeBadgeString")
#define kNofityKeyBadgeContrller    (@"badgeController")
#define kNofityHideTabBar           (@"hideTabBar")
#define kNofityShowTabBar           (@"showTabBar")
#define kNofityDidHideTabBar        (@"didHideTabBar")
#define kNofityDidShowTabBar        (@"didShowTabBar")

#define kNofityLoginSucess          (@"loginSucess")

#define kTableViewCellRowHeight     (44.0)
#define kDefaultToolbarHeight       (44.0)
#define kDefaultTabbarHeight        (49.0)    
#define kDefaultNavbarHeight        (44.0)
#define kDefaultSearchbarHeight     (44.0)
#define kDefaultStatusbarHeight     (20.0)
#define kDefaultTableCellHeight     (44.0)

#define wwRgbColor(__RED, __GREEN, __BLUE)       [UIColor colorWithRed:(__RED) / 255 green:(__GREEN) /255 blue:(__BLUE) / 255 alpha:1.0]



// Time
#define kMINUTE                     (60)
#define kHOUR                       (60 * kMINUTE)
#define kDAY                        (24 * kHOUR)
#define kWEEK                       (7 * kDAY)
#define kMONTH                      (30 * kDAY)

#endif