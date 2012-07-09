//
//  ZHUAdditions.m
//  zhuTabbarController
//
//  Created by zhukuanxi@gmail.com on 7/9/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//

static char SELECTIMG_KEY;
#import "ZHUAdditions.h"

@implementation UITabBarItem (additionalImage)
- (void)setSelectedImg:(UIImage *)img
{
    objc_setAssociatedObject(self, &SELECTIMG_KEY, img, OBJC_ASSOCIATION_RETAIN_NONATOMIC);    
}

- (UIImage *)selectedImg
{
    UIImage *img = objc_getAssociatedObject(self, &SELECTIMG_KEY);
    return img;
}
@end
