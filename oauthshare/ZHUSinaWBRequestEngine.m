//
//  ZHUSinaWBRequestEngine.m
//  oauthshare
//
//  Created by kuanxi zhu on 7/12/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//

#import "ZHUSinaWBRequestEngine.h"
#import "ZHUSinaWeibomgr.h"
#import "ZHUResponse.h"

@interface ZHUSinaWBRequestEngine ()
- (ZHUWBRequest *)sendRequestUrl:(NSString *)url 
                params:(NSDictionary *)params
           finishBlock:(zhuRequestFinishBlock)finishBlock
            errorBlock:(zhuRequestErrorBlock)errorBlock;
@end

@implementation ZHUSinaWBRequestEngine
- (ZHUWBRequest *)getPublicTimeLine:(NSInteger)count 
                     page:(NSInteger)page 
              finishBlock:(zhuRequestFinishBlock)finishBlock
               errorBlock:(zhuRequestErrorBlock)errorBlock
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [[ZHUSinaWeibomgr defaultWiboMgr] accessToken], @"access_token", 
                         [NSString stringWithFormat:@"%d", count], @"count",
                         [NSString stringWithFormat:@"%d", page], @"page",
                         @"0", @"feature",
                         nil];
     
    return [self sendRequestUrl:[NSString stringWithFormat:@"%@/%@", kSinaUrlDomain, kSinaUrlPublicTimeLine] 
                  params:dic
             finishBlock:(zhuRequestFinishBlock)finishBlock
              errorBlock:(zhuRequestErrorBlock)errorBlock];
                             
}

- (ZHUWBRequest *)getFriendTimeLine:(NSInteger)count 
                     page:(NSInteger)page 
              finishBlock:(zhuRequestFinishBlock)finishBlock
               errorBlock:(zhuRequestErrorBlock)errorBlock
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [[ZHUSinaWeibomgr defaultWiboMgr] accessToken], @"access_token", 
                         [NSString stringWithFormat:@"%d", count], @"count",
                         [NSString stringWithFormat:@"%d", page], @"page",
                         @"0", @"feature",
                         nil];
    
    return [self sendRequestUrl:[NSString stringWithFormat:@"%@/%@", kSinaUrlDomain, kSinaUrlFriendTimeLine] 
                  params:dic
             finishBlock:(zhuRequestFinishBlock)finishBlock
              errorBlock:(zhuRequestErrorBlock)errorBlock];
    
}

- (ZHUWBRequest *)sendRequestUrl:(NSString *)url 
                params:(NSDictionary *)params
           finishBlock:(zhuRequestFinishBlock)finishBlock
            errorBlock:(zhuRequestErrorBlock)errorBlock
{
    ZHUWBRequest *request = [[ZHUWBRequest alloc] initWithURLString:url 
                                                             params:params 
                                                         httpMethod:@"GET" 
                                                        finishBlock:finishBlock
                                                         errorBlock:errorBlock];
    DLog(@"request url \n%@", request.url);
    [[ZHUSinaWBRequestEngine sharedEngine] loadWBRequest:request]; 
    return request;
}

- (void)handleError:(NSError *)error operation:(MKNetworkOperation *)operation;
{
    ALog(@"----\nresponse\n----\n%@\n----\nerror\n----\n%@", operation.responseString, error);
    ZHUResponse *response = [[ZHUResponse alloc] initWithDic:[operation responseJSON]];
    if ([response.error isEqualToString:kSinaErrorTypeExpiredToken] ||
        kSinaErrorCodeExpiredToken == [response.error_code intValue] ||
        [response.error isEqualToString:kSinaErrorTypeInvalidToken] ||
        kSinaErrorCodeInvalidToken == [response.error_code intValue]) {
        [[ZHUSinaWeibomgr defaultWiboMgr] reLogIn];
    }
}
@end
