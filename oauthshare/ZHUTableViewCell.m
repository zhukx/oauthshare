//
//  ZHUTableViewCell.m
//  oauthshare
//
//  Created by kuanxi zhu on 7/12/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//

#import "ZHUTableViewCell.h"
#import "ZHUTimeLineTableViewCell.h"

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
#ifdef CUSTOM_DRAW_CELL
        if ([self isKindOfClass:[ZHUTimeLineTableViewCell class]]) {
            _customContentViewClass = [ZHUTimeLineContentView class];
        }
        else if (0) {
            
        }
        else {
            _customContentViewClass = [ZHUTableContentView class];
        }
        _customContentView = [[_customContentViewClass alloc] initWithFrame:self.contentView.bounds];
        _customContentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:_customContentView];
#endif
    }
    return self;
}

- (void)setCellData:(id)cellData
{
    if (cellData && cellData != _cellData) {
        _cellData = cellData;
        [self configCell];
#ifdef CUSTOM_DRAW_CELL
        _customContentView.contentData = _cellData;
#endif
    }
}

- (void)prepareForReuse
{
    [super prepareForReuse];
#ifdef CUSTOM_DRAW_CELL
    [_customContentView prepareForReuse];
#endif
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
