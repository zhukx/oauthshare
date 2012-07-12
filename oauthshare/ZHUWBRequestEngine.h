//
//  ZHUWBRequestEngine.h
//  oauthshare
//
//  Created by kuanxi zhu on 7/12/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//

#import "MKNetworkEngine.h"
#import "ZHUWBRequest.h"

@interface ZHUWBRequestEngine : MKNetworkEngine

+ (id)sharedEngine;
- (void)loadWBRequest:(ZHUWBRequest *)request;
@end
