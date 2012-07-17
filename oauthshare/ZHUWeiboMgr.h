//
//  ZHUWeiboMgr.h
//  oauthshare
//
//  Created by zhukuanxi@gmail.com on 7/11/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZHUWeiboDef.h"
#import "ZHUOauthWebViewController.h"

//@protocol ZHUWeiboMgrDelegate;
@interface ZHUWeiboMgr : NSObject <ZHUOauthWebViewControllerDelegate>{
    NSString *_appKey;
    NSString *_appSecret;
    NSString *_redirectURI;
    NSString *_accessToken;
    NSString *_userId;
    NSString *_expireTime;
    NSString *_authorizeUrl;
}

@property (strong, nonatomic) NSString *accessToken;
@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *expireTime;

+ (id)defaultWiboMgr;
- (void)logIn;
- (void)logInWithPresentController:(UIViewController *)presentController;
- (void)logOut;
- (void)reLogIn;
- (BOOL)isLoggedIn;
- (BOOL)isAuthorizeExpired;
- (void)getAuthorizeFromUserDefault;
- (void)setAuthorizeToUserDefault;
- (void)delAuthorizeInUserDefault;
@end

//@protocol ZHUWeiboMgrDelegate <NSObject>
//- (void)authorize:(ZHUWeiboMgr *)authorize didSucceedWithAccessToken:(NSString *)accessToken userID:(NSString *)userID expiresIn:(NSInteger)seconds;
//- (void)authorize:(ZHUWeiboMgr *)authorize didFailWithError:(NSError *)error;
//@end
