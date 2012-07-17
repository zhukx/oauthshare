//
//  ZHUResponse.h
//  oauthshare
//
//  Created by zhukuanxi@gmail.com on 7/17/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//

#import "ZHUWBData.h"

@interface ZHUResponse : ZHUWBData
@property (strong, nonatomic) NSString *error;
@property (strong, nonatomic) NSString *error_code;
@property (strong, nonatomic) NSString *request;
@end
