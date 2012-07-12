//
//  ZHUTimeLineTableViewCell.m
//  oauthshare
//
//  Created by kuanxi zhu on 7/12/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//

#import "ZHUTimeLineTableViewCell.h"
#import "ZHUSINAStatuses.h"

@implementation ZHUTimeLineTableViewCell
+ (CGFloat)tableView:(UITableView*)tableView rowHeightForContent:(id)object
{
    return kDefaultTableCellHeight;
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
    if (!_cellData || ![_cellData isKindOfClass:[ZHUSINAStatuses class]]) {
        return;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

@end
