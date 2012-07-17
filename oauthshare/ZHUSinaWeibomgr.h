//
//  ZHUSinaWeibomgr.h
//  oauthshare
//
//  Created by zhukuanxi@gmail.com on 7/11/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//

#define kSinaErrorTypeExpiredToken              (@"expired_token")
#define kSinaErrorCodeExpiredToken              (21327)

#define kSinaErrorTypeInvalidToken              (@"invalid_access_token")
#define kSinaErrorCodeInvalidToken              (21332)

#import "ZHUWeiboMgr.h"

@interface ZHUSinaWeibomgr : ZHUWeiboMgr

@end
