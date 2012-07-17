//
//  ZHUImageView.h
//  oauthshare
//
//  Created by zhukuanxi@gmail.com on 7/13/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHUWBRequestEngine.h"
@interface UIImageView (ZHUImageView)
@property (strong, nonatomic) NSString *imageUrl;
@end


@interface ZHUImageView : UIImageView {
    ZHUWBRequest *_request;
}

@property (assign, nonatomic) BOOL fadeImage;
@property (assign, nonatomic) BOOL fadeDuration;
@end
