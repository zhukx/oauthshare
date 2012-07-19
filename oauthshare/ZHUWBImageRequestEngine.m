//
//  ZHUWBImageRequestEngine.m
//  oauthshare
//
//  Created by zhukuanxi@gmail.com on 7/18/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//

#define kImageDefautMemoryCache             (20)
#define kImageDefautCacheDir                (@"wbimage")
#import "ZHUWBImageRequestEngine.h"

@implementation ZHUWBImageRequestEngine
- (int)cacheMemoryCost
{
    return kImageDefautMemoryCache;
}

- (NSString*)cacheDirectoryName
{   
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *cacheDirectoryName = [documentsDirectory stringByAppendingPathComponent:kImageDefautCacheDir];
    return cacheDirectoryName;
}
@end
