//
//  ZHUSinaWBRequestEngine.h
//  oauthshare
//
//  Created by kuanxi zhu on 7/12/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//

#define kSinaUrlDomain                          (@"https://api.weibo.com/2")
#define kSinaUrlPublicTimeLine                  (@"statuses/public_timeline.json")
#define kSinaUrlFriendTimeLine                  (@"statuses/friends_timeline.json")



#import "ZHUWBRequestEngine.h"

@interface ZHUSinaWBRequestEngine : ZHUWBRequestEngine
- (ZHUWBRequest *)getPublicTimeLine:(NSInteger)count 
                     page:(NSInteger)page 
              finishBlock:(zhuRequestFinishBlock)finishBlock
              errorBlock:(zhuRequestErrorBlock)errorBlock;

- (ZHUWBRequest *)getFriendTimeLine:(NSInteger)count 
                     page:(NSInteger)page 
              finishBlock:(zhuRequestFinishBlock)finishBlock
               errorBlock:(zhuRequestErrorBlock)errorBlock;
@end
