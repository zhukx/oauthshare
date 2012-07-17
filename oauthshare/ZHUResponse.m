//
//  ZHUResponse.m
//  oauthshare
//
//  Created by zhukuanxi@gmail.com on 7/17/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//
#define RES_ERROR                           (@"error")
#define RES_ERRORCODE                       (@"error_code")
#define RES_REQUEST                         (@"request")

#import "ZHUResponse.h"

@implementation ZHUResponse
@synthesize error;
@synthesize error_code;
@synthesize request;

- (id)initWithDic:(NSDictionary *)dic
{
    if (self = [super initWithDic:dic]) {
        self.error = [dic objectForKey:RES_ERROR];
        self.error_code = [dic objectForKey:RES_ERRORCODE];
        self.request = [dic objectForKey:RES_REQUEST];
    }
    return self;    
}
@end
