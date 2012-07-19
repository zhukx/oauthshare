//
//  ZHUTimeLineTableViewCell.h
//  oauthshare
//
//  Created by kuanxi zhu on 7/12/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//
typedef enum {
    IMAGE_TYPE_THUMBNAIL,
    IMAGE_TYPE_AVATAR
}TLImageType;
#import "ZHUTableViewCell.h"

@interface ZHUTimeLineTableViewCell : ZHUTableViewCell {
    MKNetworkOperation *_thumbnailOp;
    MKNetworkOperation *_avatarOp;
}

- (void)refreshContentView:(TLImageType)type withObject:(id)object;
@end
