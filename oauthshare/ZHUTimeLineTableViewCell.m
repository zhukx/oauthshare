//
//  ZHUTimeLineTableViewCell.m
//  oauthshare
//
//  Created by kuanxi zhu on 7/12/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//

#import "ZHUTimeLineTableViewCell.h"
#import "ZHUSinaStatuses.h"
#import "ZHUSinaUser.h"
#import "ZHUWBImageRequestEngine.h"

@implementation ZHUTimeLineTableViewCell

+ (CGFloat)tableView:(UITableView*)tableView rowHeightForContent:(id)object
{
    CGSize contentSize = [ZHUTimeLineContentView getContentSize:(id)object];
    return contentSize.height;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

    }
    return self;
}

- (void)configCell
{
    if (!_cellData || ![_cellData isKindOfClass:[ZHUSinaStatuses class]]) {
        return;
    }
}

- (void)refreshContentView:(TLImageType)type withObject:(id)object
{
    if (IMAGE_TYPE_THUMBNAIL == type) {
        [(ZHUTimeLineContentView *)_customContentView setThumbnailImg:object];
    }
    else if (IMAGE_TYPE_AVATAR == type) {
        [(ZHUTimeLineContentView *)_customContentView setAvatarImg:object];        
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

@end
