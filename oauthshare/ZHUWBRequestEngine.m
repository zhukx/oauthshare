//
//  ZHUWBRequestEngine.m
//  oauthshare
//
//  Created by kuanxi zhu on 7/12/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//

#import "ZHUWBRequestEngine.h"
#import "ZHUWeiboMgr.h"
@interface ZHUWBRequestEngine ()
- (void)handleError:(NSError *)error operation:(MKNetworkOperation *)operation;
@end

@implementation ZHUWBRequestEngine
+ (id)sharedEngine
{
    static id _sharedInstance = nil;
    if (!_sharedInstance) {
        _sharedInstance = [[self alloc] init];
        //[_sharedInstance useCache];
        [_sharedInstance registerOperationSubclass:[MKNetworkOperation class]];
    }
    return _sharedInstance;
}

//-(int) cacheMemoryCost {
//    return 500;
//}

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
        else {
            returnInfo = [completedOperation responseString];
        }
        
        if (returnInfo) {
            request.finishBlock(returnInfo);
        }
        else {
            NSError *error = [[NSError alloc] initWithDomain:kErrorDomainAuth code:2 userInfo:nil];
            request.errorBlock(error);
        }
    } onError:^(NSError *error) {
        [self handleError:error operation:request];
        request.errorBlock(error);
    }];
    
    [self enqueueOperation:request];
}

- (void)handleError:(NSError *)error operation:(MKNetworkOperation *)operation;
{

}
@end
