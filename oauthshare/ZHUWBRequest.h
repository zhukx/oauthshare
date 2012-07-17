//
//  ZHUWBRequest.h
//  oauthshare
//
//  Created by kuanxi zhu on 7/12/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//
typedef void (^zhuRequestFinishBlock)(id returnInfo);
typedef void (^zhuRequestErrorBlock)(NSError *error);

typedef enum {
    WBREQUEST_TYPE_JSON,
    WBREQUEST_TYPE_XML,
    WBREQUEST_TYPE_STRING,
    WBREQUEST_TYPE_BINARY,
    WBREQUEST_TYPE_IMAGE
}ZHUWBRequestType;

#import "MKNetworkOperation.h"

@interface ZHUWBRequest : MKNetworkOperation

@property (copy, nonatomic) zhuRequestFinishBlock finishBlock;
@property (copy, nonatomic) zhuRequestErrorBlock errorBlock;
@property (assign, nonatomic) ZHUWBRequestType requestType;

- (id)initWithURLString:(NSString *)aURLString
                 params:(NSDictionary *)params
             httpMethod:(NSString *)method 
            finishBlock:(zhuRequestFinishBlock)finishBlock
             errorBlock:(zhuRequestErrorBlock)errorBlock;

- (id)initWithURLString:(NSString *)aURLString
                 params:(NSDictionary *)params
             httpMethod:(NSString *)method
            requestType:(ZHUWBRequestType)requestType
            finishBlock:(zhuRequestFinishBlock)finishBlock
             errorBlock:(zhuRequestErrorBlock)errorBlock;
@end
