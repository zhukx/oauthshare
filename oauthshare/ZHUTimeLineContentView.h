//
//  ZHUTimeLineContentView.h
//  oauthshare
//
//  Created by zhukuanxi@gmail.com on 7/13/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//

#define kTLAvatarWidth                        (40.0)
#define kTLAvatarHeight                       (40.0)
#define kTLThumbnailWidth                     (80.0)
#define kTLThumbnailHeight                    (80.0)
#define kTLOffsetBetweenItemH                 (10.0)
#define kTLOffsetBetweenItemV                 (10.0)
#define kTLOffsetFromFrame                    (4.0)
#define kTLFontName                           (12.0)
#define kTLFontTime                           (12.0)
#define kTLFontText                           (14.0)

#import "ZHUTableContentView.h"
//#define USE_ADDSUBVIEW
@interface ZHUTimeLineContentView : ZHUTableContentView {
#ifdef USE_ADDSUBVIEW 
    ZHUImageView *_imgView;
#endif
    UIImage *_thumbnailImg;
    UIImage *_avatarImg;
    CALayer *_thumbnailLayer;
    CALayer *_avatarLayer;
    CGRect _thumbnailRect;
    CGRect _avatarRect;
    CGRect _nameRect;
    CGRect _timeRect;
    CGRect _textRect;
    MKNetworkOperation *_thumbnailOp;
    MKNetworkOperation *_avatarOp;
}

@property (assign, nonatomic) BOOL fadeImage;
@property (assign, nonatomic) BOOL fadeDuration;
@end
