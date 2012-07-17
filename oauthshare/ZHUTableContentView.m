//
//  ZHUTableContentView.m
//  oauthshare
//
//  Created by zhukuanxi@gmail.com on 7/13/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//

#import "ZHUTableContentView.h"
@interface ZHUTableContentView ()
- (void)configContentView;
- (void)calculateRectsForDraw;
@end

@implementation ZHUTableContentView
@synthesize contentData = _contentData;

+ (CGSize)getContentSize:(id)object
{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, kDefaultTableCellHeight);
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.opaque = YES;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setContentData:(id)contentData
{
    if (contentData != _contentData) {
        _contentData = contentData;
        [self configContentView];
    }
}

- (void)configContentView
{
    [self calculateRectsForDraw];
}

- (void)prepareForReuse
{
    
}

- (void)calculateRectsForDraw
{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
