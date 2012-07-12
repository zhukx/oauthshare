//
//  ZHUOauthWebViewController.h
//  oauthshare
//
//  Created by zhukuanxi@gmail.com on 7/11/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//

#import "ZHUWebViewController.h"
@protocol ZHUOauthWebViewControllerDelegate;
@interface ZHUOauthWebViewController : ZHUWebViewController {
    __weak id<ZHUOauthWebViewControllerDelegate> _delegate;
}
@property (weak, nonatomic) id<ZHUOauthWebViewControllerDelegate> delegate;
@end

@protocol ZHUOauthWebViewControllerDelegate <NSObject>
- (void)oauthWeb:(ZHUOauthWebViewController *)webCtl didGetAuthorizeInfo:(NSString *)infoStr;
- (void)oauthWeb:(ZHUOauthWebViewController *)webCtl didFail:(NSError *)error;
@end