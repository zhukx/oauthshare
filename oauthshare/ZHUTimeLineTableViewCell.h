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
    CGRect _thumbnailRect;
    CGRect _avatarRect;
    CGRect _nameRect;
    CGRect _timeRect;
    CGRect _textRect;
    UILabel *_nameLabel;
    UILabel *_timeLabel;
    UILabel *_weiboLabel;
    ZHUImageView *_avatarImageView;
    ZHUImageView *_thumbnailImageView;
}
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) UILabel *weiboLabel;
@property (strong, nonatomic) ZHUImageView *avatarImageView;
@property (strong, nonatomic) ZHUImageView *thumbnailImageView;
#ifdef LOAD_CELL_IMAGE_IN_CONTROLLER
- (void)refreshContentView:(TLImageType)type withObject:(id)object;
#endif
@end
