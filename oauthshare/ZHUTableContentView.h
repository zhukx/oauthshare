//
//  ZHUTableContentView.h
//  oauthshare
//
//  Created by zhukuanxi@gmail.com on 7/13/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHUTableContentView : UIView {
    id _contentData;
}

@property (strong, nonatomic) id contentData;
+ (CGSize)getContentSize:(id)object;
- (void)prepareForReuse;
@end
