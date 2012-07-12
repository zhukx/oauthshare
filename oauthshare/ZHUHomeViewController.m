//
//  ZHUHomeViewController.m
//  oauthshare
//
//  Created by zhukuanxi@gmail.com on 7/10/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//

#import "ZHUHomeViewController.h"
#import "ZHUSinaWeibomgr.h"
@interface ZHUHomeViewController ()
- (void)hideTab:(id)sender;
@end

@implementation ZHUHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Home", @"Home");
        self.viewSizeType = VIEW_SIZE_WITH_NAVIGATIONBAR;
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
@end
