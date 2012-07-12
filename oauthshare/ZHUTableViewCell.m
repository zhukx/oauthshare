//
//  ZHUTableViewCell.m
//  oauthshare
//
//  Created by kuanxi zhu on 7/12/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//

#import "ZHUTableViewCell.h"
@interface ZHUTableViewCell ()
- (void)configCell;
@end

@implementation ZHUTableViewCell
@synthesize cellData = _cellData;
+ (CGFloat)tableView:(UITableView*)tableView rowHeightForContent:(id)object
{
    return kDefaultTableCellHeight;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setCellData:(id)cellData
{
    if (cellData != _cellData) {
        _cellData = cellData;
        [self configCell];
    }
}

- (void)configCell
{
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
