//
//  ZHUWebViewController.m
//  oauthshare
//
//  Created by zhukuanxi@gmail.com on 7/11/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//

#import "ZHUWebViewController.h"
@interface ZHUWebViewController ()
- (void)goForward;
- (void)goBackward;
- (void)stopRefresh;
- (void)resetToolbarStates;
- (void)startLoadWeb;
@end

@implementation ZHUWebViewController
@synthesize webView = _webView;
@synthesize toolBar = _toolBar;
@synthesize url = _url;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Web", @"Web");
        self.viewSizeType = VIEW_SIZE_WITH_NAVIGATIONBAR;
        _isHideTabBar = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.delegate = self;
    
    [self.view addSubview:self.webView];
    
    CGRect frame = self.view.bounds;
    _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, frame.size.height - kDefaultToolbarHeight, frame.size.width, kDefaultToolbarHeight)];
    _toolBar.barStyle = UIBarStyleBlackTranslucent;
    
    _forward = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(goForward)];
    _backward = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(goBackward)];
    _stopRefresh = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(stopRefresh)];
    UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    NSArray *btnArr = [NSArray arrayWithObjects:flexItem, _backward, flexItem, _forward, flexItem, _stopRefresh, flexItem, nil];
    
    _stopRefresh.enabled = NO;
    _forward.enabled = NO;
    _backward.enabled = NO;
    _toolBar.items = btnArr;
    [self.view addSubview:_toolBar];
    [self startLoadWeb];
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

- (void)setUrl:(NSString *)url {
    if (url && ![url isEqualToString:_url]) {
        _url = url;
        [self startLoadWeb];
    }
}

- (void)startLoadWeb 
{
    if (self.webView.isLoading) {
        [self.webView stopLoading];
    }
    
    if (_url.length) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    }
}

- (void)goForward 
{
    if ([self.webView canGoForward]) {
        [self.webView goForward];
    }
}

- (void)goBackward
{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }
}

- (void)stopRefresh
{
    if ([self.webView isLoading]) {
        [self.webView stopLoading];
    }
    else {
        [self.webView reload];
    }
}

- (void)resetToolbarStates
{
    if ([self.webView canGoForward]) {
        _forward.enabled = YES;
    }
    else {
        _forward.enabled = NO;
    }
    
    if ([self.webView canGoBack]) {
        _backward.enabled = YES;
    }
    else {
        _backward.enabled = NO;
    }
    
    if ([self.webView isLoading]) {
        _stopRefresh = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(stopRefresh)];
    }
    else {
        _stopRefresh = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(stopRefresh)];
    }
    NSMutableArray *barArr = [self.toolBar.items mutableCopy];
    [barArr replaceObjectAtIndex:barArr.count - 2 withObject:_stopRefresh];
    self.toolBar.items = barArr;
}

#pragma - webviewDelegate methods
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self resetToolbarStates];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self resetToolbarStates];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self resetToolbarStates];
}
@end
