//
//  ZHUOauthWebViewController.m
//  oauthshare
//
//  Created by zhukuanxi@gmail.com on 7/11/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//

#import "ZHUOauthWebViewController.h"
#import "ZHUWeiboMgr.h"
@interface ZHUOauthWebViewController ()
- (void)getAuthorizeInfo:(NSString *)infoStr;
@end

@implementation ZHUOauthWebViewController
@synthesize delegate = _delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _viewSizeType = VIEW_SIZE_FULLSIZE;
        self.title = NSLocalizedString(@"authWeb", authWeb);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)dealloc
{
    [_webView stopLoading];
    _webView.delegate = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)getAuthorizeInfo:(NSString *)infoStr 
{
    if (_delegate && [_delegate respondsToSelector:@selector(oauthWeb:didGetAuthorizeInfo:)]) {
        [_delegate oauthWeb:self didGetAuthorizeInfo:infoStr];
    }
}

#pragma - webviewDelegate methods
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlPath = request.URL.absoluteString;
    DLog(@"%@", urlPath);
    if ([[urlPath getStringWithKey:@"error_code="] isEqualToString:@"21330"]) {
        DLog(@"user cancell");
        NSError *err = [[NSError alloc] initWithDomain:kErrorDomainAuth code:1 userInfo:nil];
        if (_delegate && [_delegate respondsToSelector:@selector(oauthWeb:didGetAuthorizeInfo:)]) {
            [_delegate oauthWeb:self didFail:err];
        }
    }
    
    if (NSNotFound != [urlPath rangeOfString:@"access_token"].location) {
        NSArray *arr = [urlPath componentsSeparatedByString:@"#"];
        if (1 < arr.count) {
            [self getAuthorizeInfo:[arr lastObject]];
            return NO;
        }
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [super webViewDidStartLoad:webView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [super webViewDidFinishLoad:webView];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [super webView:webView didFailLoadWithError:error];
}
@end
