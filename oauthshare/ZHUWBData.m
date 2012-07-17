//
//  ZHUWBData.m
//  oauthshare
//
//  Created by kuanxi zhu on 7/12/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//

#import "ZHUWBData.h"

@implementation ZHUWBData
+ (NSString *)dataKey
{
    return nil;
}

- (id)initWithDic:(NSDictionary *)dic
{
    if (0 >= dic.count) {
        return nil;
    }
    
    if (self = [super init]) {
        
    }
    return self;
}
@end
