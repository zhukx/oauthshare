//
//  ZHUWBRequestEngine.m
//  oauthshare
//
//  Created by kuanxi zhu on 7/12/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//

#import "ZHUWBRequestEngine.h"
#import "ZHUWeiboMgr.h"

@implementation ZHUWBRequestEngine
+ (id)sharedEngine
{
    static id _sharedInstance = nil;
    if (!_sharedInstance) {
        _sharedInstance = [[self alloc] init];
    }
    return _sharedInstance;
}

- (void)loadWBRequest:(ZHUWBRequest *)request
{
    [request onCompletion:^(MKNetworkOperation *completedOperation) {
        if([completedOperation isCachedResponse]) {
            DLog(@"Data from cache");
        }
        else {
            DLog(@"Data from server");
        }
        
        id returnInfo = nil;
        if (WBREQUEST_TYPE_JSON == request.requestType) {
            returnInfo = [completedOperation responseJSON];
        }
        else if (WBREQUEST_TYPE_XML == request.requestType) {
            returnInfo = [completedOperation responseString];
        }
        else if (WBREQUEST_TYPE_STRING == request.requestType) {
            returnInfo = [completedOperation responseString];
        }
        else if (WBREQUEST_TYPE_BINARY == request.requestType) {
            returnInfo = [completedOperation responseData];
        }
        else if (WBREQUEST_TYPE_IMAGE == request.requestType) {
            returnInfo = [completedOperation responseImage];
        }
        
        if (returnInfo) {
            request.finishBlock(returnInfo);
        }
        else {
            NSError *error = [[NSError alloc] initWithDomain:kErrorDomainAuth code:2 userInfo:nil];
            request.errorBlock(error);
        }
    } onError:^(NSError *error) {
        request.errorBlock(error);
    }];
    
    [self enqueueOperation:request];
}

@end
