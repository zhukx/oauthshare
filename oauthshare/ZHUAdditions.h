//
//  ZHUAdditions.h
//  zhuTabbarController
//
//  Created by zhukuanxi@gmail.com on 7/9/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface UITabBarItem (additionalImage)
- (UIImage *)selectedImg;
- (void)setSelectedImg:(UIImage *)img;
@end
