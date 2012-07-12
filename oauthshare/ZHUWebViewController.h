//
//  ZHUWebViewController.h
//  oauthshare
//
//  Created by zhukuanxi@gmail.com on 7/11/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//

#import "ZHUViewController.h"

@interface ZHUWebViewController : ZHUViewController <UIWebViewDelegate> {
    UIWebView *_webView;
    NSString *_url;
    UIBarButtonItem *_forward;
    UIBarButtonItem *_backward;
    UIBarButtonItem *_stopRefresh;
}

@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) UIToolbar *toolBar;
@property (strong, nonatomic) NSString *url;
@end
