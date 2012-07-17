//
//  ZHUAppDelegate.m
//  oauthshare
//
//  Created by zhukuanxi@gmail.com on 7/9/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//

#import "ZHUAppDelegate.h"
#import "ZHUTimeLineViewController.h"
#import "ZHUOauthWebViewController.h"

@interface ZHUAppDelegate ()

@end

@implementation ZHUAppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;
- (ZHUTabBarViewController *)tabBarController
{
    if (!_tabBarController) {
        ZHUTimeLineViewController *viewController1 = [[ZHUTimeLineViewController alloc] init];
        ZHUOauthWebViewController *viewController2 = [[ZHUOauthWebViewController alloc] init];
        ZHUTableViewController *viewController3 = [[ZHUTableViewController alloc] init];
        ZHUTableViewController *viewController4 = [[ZHUTableViewController alloc] init];
        
        UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:viewController1];
        UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:viewController2];
        UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:viewController3];
        UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:viewController4];
        
        nav1.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Home", @"Home") 
                                                        image:[UIImage imageNamed:@"tabbar_home"]
                                                          tag:0];
        [nav1.tabBarItem setSelectedImg:[UIImage imageNamed:@"tabbar_home_highlighted"]];
        
        
        nav2.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Discover", @"Discover") 
                                                        image:[UIImage imageNamed:@"tabbar_discover"]
                                                          tag:0];
        [nav2.tabBarItem setSelectedImg:[UIImage imageNamed:@"tabbar_discover_highlighted"]];
        
        
        nav3.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Favorites", @"Favorites") 
                                                        image:[UIImage imageNamed:@"tabbar_favorites"]
                                                          tag:0];
        [nav3.tabBarItem setSelectedImg:[UIImage imageNamed:@"tabbar_favorites_highlighted"]];
        
        nav4.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Message", @"Message") 
                                                        image:[UIImage imageNamed:@"tabbar_message"]
                                                          tag:0];
        [nav4.tabBarItem setSelectedImg:[UIImage imageNamed:@"tabbar_message_highlighted"]];
        
        _tabBarController = [[ZHUTabBarViewController alloc] init];
        _tabBarController.delegate = self;
        _tabBarController.viewControllers = [NSArray arrayWithObjects:nav1, nav2, nav3, nav4, nil];
    }
    return _tabBarController;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.

    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if ([viewController.tabBarItem.title isEqualToString:NSLocalizedString(@"Discover", @"Discover")]) {
//        ZHUOauthWebViewController *webCtl = [[(UINavigationController *)viewController viewControllers] objectAtIndex:0];
//        [webCtl setUrl:@"https://api.weibo.com/oauth2/authorize?display=mobile&response_type=token&redirect_uri=http%3A%2F%2Fweibo.com%2Fu%2F1800785501%2Fcallback.php&client_id=190838811"];
    }
}


/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
