//
//  ZHUWeiboMgr.m
//  oauthshare
//
//  Created by zhukuanxi@gmail.com on 7/11/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//

#import "ZHUWeiboMgr.h"

@interface ZHUWeiboMgr ()
- (NSString *)createAuthorizeUrl;
@end

@implementation ZHUWeiboMgr
@synthesize accessToken = _accessToken;
@synthesize userId = _userId;
@synthesize expireTime = _expireTime;

+ (id)defaultWiboMgr
{
    static id _defaultMgr = nil;
    if (!_defaultMgr) {
        _defaultMgr = [[self alloc] init];
    }
    return _defaultMgr;
}

- (id)init
{
    if (self = [super init]) {
        [self getAuthorizeFromUserDefault];
    }
    return self;
}

- (void)logIn
{
    if ([self isLoggedIn]) {
        return;
    }
    NSString *authorizeUrl = [self createAuthorizeUrl];
    UIViewController *baseCtl = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    ZHUOauthWebViewController *webCtl = [[ZHUOauthWebViewController alloc] init];
    webCtl.delegate = self;
    webCtl.url = authorizeUrl;
    [baseCtl presentViewController:webCtl animated:YES completion:^{
        
    }];
}

- (void)logOut
{
    
}

- (BOOL)isLoggedIn
{  
    return [self isAuthorizeExpired] && !!_userId && !!_accessToken;    
}

- (BOOL)isAuthorizeExpired
{
    NSDate *expirationDate = [NSDate dateWithTimeIntervalSinceNow:[_expireTime doubleValue]];
    BOOL isExpire = [expirationDate compare:[NSDate date]];   
    return !!expirationDate && isExpire && !!_expireTime;
}

- (NSString *)createAuthorizeUrl
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            _appKey, @"client_id",
                            @"token", @"response_type",
                            _redirectURI, @"redirect_uri", 
                            @"mobile", @"display", nil];    

    NSURL *parsedURL = [NSURL URLWithString:_authorizeUrl];
	NSString *queryPrefix = parsedURL.query ? @"&" : @"?";
    NSString *queryStr = [params stringFromDictionary];
	
	return [NSString stringWithFormat:@"%@%@%@", _authorizeUrl, queryPrefix, queryStr];
}

- (void)getAuthorizeFromUserDefault
{
    self.userId = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultKeyUserId];
    self.accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultKeyAccessToken];
    self.expireTime = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultKeyExpireTime];
}

- (void)setAuthorizeToUserDefault
{
    if (self.userId && self.accessToken && self.expireTime) {
        [[NSUserDefaults standardUserDefaults] setObject:self.userId forKey:kUserDefaultKeyUserId];
        [[NSUserDefaults standardUserDefaults] setObject:self.accessToken forKey:kUserDefaultKeyAccessToken];
        [[NSUserDefaults standardUserDefaults] setObject:self.expireTime forKey:kUserDefaultKeyExpireTime];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)delAuthorizeInUserDefault
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserDefaultKeyUserId];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserDefaultKeyAccessToken];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserDefaultKeyExpireTime];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma - ZHUOauthWebViewControllerDelegate
- (void)oauthWeb:(ZHUOauthWebViewController *)webCtl didGetAuthorizeInfo:(NSString *)infoStr
{
    UIViewController *baseCtl = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    [baseCtl dismissViewControllerAnimated:YES completion:^{
        
    }];
    NSLog(@"Subclass should implement");
}

- (void)oauthWeb:(ZHUOauthWebViewController *)webCtl didFail:(NSError *)error
{
    UIViewController *baseCtl = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    [baseCtl dismissViewControllerAnimated:YES completion:^{
        
    }];
    NSLog(@"didFail %@", [error description]);    
}
@end
