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

- (void)layoutSubviews
{
    [super layoutSubviews];
}

@end
