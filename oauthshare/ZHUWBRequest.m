//
//  ZHUWBRequest.m
//  oauthshare
//
//  Created by kuanxi zhu on 7/12/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//

#import "ZHUWBRequest.h"

@implementation ZHUWBRequest
@synthesize finishBlock = _finishBlock;
@synthesize errorBlock = _errorBlock;
@synthesize requestType = _requestType;

- (id)initWithURLString:(NSString *)aURLString
                 params:(NSDictionary *)params
             httpMethod:(NSString *)method 
            finishBlock:(zhuRequestFinishBlock)finishBlock
             errorBlock:(zhuRequestErrorBlock)errorBlock
{
    self = [super initWithURLString:aURLString
                             params:[params mutableCopy]
                         httpMethod:method];
    if (self) {
        self.finishBlock = finishBlock;
        self.errorBlock = errorBlock;
        if (NSNotFound != [aURLString rangeOfString:@"json"].location) {
            _requestType = WBREQUEST_TYPE_JSON;
        }
    }
    return self;
}
@end