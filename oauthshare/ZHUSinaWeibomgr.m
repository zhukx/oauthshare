//
//  ZHUSinaWeibomgr.m
//  oauthshare
//
//  Created by zhukuanxi@gmail.com on 7/11/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//
#define kAuthKeyUserId                          (@"uid")
#define kAuthKeyExpireTime                      (@"expires_in")
#define kAuthKeyAccessToken                     (@"access_token")

#import "ZHUSinaWeibomgr.h"

@implementation ZHUSinaWeibomgr
- (id)init {
    if (self = [super init]) {
        _appKey = @"190838811";
        _appSecret = @"084afcb6a8ea04827617b35f0b1423c2";
        _redirectURI = @"http://weibo.com/u/1800785501/callback.php";
        _authorizeUrl = @"https://api.weibo.com/oauth2/authorize";
    }
    return self;
}

#pragma - ZHUOauthWebViewControllerDelegate
- (void)oauthWeb:(ZHUOauthWebViewController *)webCtl didGetAuthorizeInfo:(NSString *)infoStr
{
    NSDictionary *authDic = [infoStr dictionaryFromString];
    self.userId = [authDic objectForKey:kAuthKeyUserId];
    self.expireTime = [authDic objectForKey:kAuthKeyExpireTime];
    self.accessToken = [authDic objectForKey:kAuthKeyAccessToken];
    [self setAuthorizeToUserDefault];
    [super oauthWeb:webCtl didGetAuthorizeInfo:infoStr];
}
@end
