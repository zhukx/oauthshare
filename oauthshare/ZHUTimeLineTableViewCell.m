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
@interface ZHUTimeLineTableViewCell ()
+ (CGSize)getContent:(id)object
          avatarRect:(CGRect *)avatarRect
            nameRect:(CGRect *)nameRect 
            timeRect:(CGRect *)timeRect
            textRect:(CGRect *)textRect
       thumbnailRect:(CGRect *)thumbnailRect;
@end

@implementation ZHUTimeLineTableViewCell
@synthesize nameLabel = _nameLabel;
@synthesize timeLabel = _timeLabel;
@synthesize weiboLabel = _weiboLabel;
@synthesize avatarImageView = _avatarImageView;
@synthesize thumbnailImageView = _thumbnailImageView;

+ (CGFloat)tableView:(UITableView*)tableView rowHeightForContent:(id)object
{
    return [self getContent:object 
                 avatarRect:nil
                   nameRect:nil 
                   timeRect:nil 
                   textRect:nil
              thumbnailRect:nil].height;
}


+ (CGSize)getContent:(id)object
          avatarRect:(CGRect *)avatarRect
            nameRect:(CGRect *)nameRect 
            timeRect:(CGRect *)timeRect
            textRect:(CGRect *)textRect
       thumbnailRect:(CGRect *)thumbnailRect
{
    if (![object isKindOfClass:[ZHUSinaStatuses class]]) {
        return CGSizeZero;
    }
    if (avatarRect) {
        *avatarRect = CGRectMake(kTLOffsetFromFrame, kTLOffsetFromFrame, kTLAvatarWidth, kTLAvatarHeight);
    }
    
    CGFloat rectWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat rectHeight = [UIScreen mainScreen].bounds.size.height;
    //1.avatar
    CGFloat offsetX = kTLOffsetFromFrame + kTLAvatarWidth;
    CGFloat offsetY = kTLOffsetFromFrame + kTLAvatarHeight;
    
    ZHUSinaStatuses *status = object;
    ZHUSinaUser *user = status.user;
    UILineBreakMode lineMode = UILineBreakModeTailTruncation;
    
    //2.time
    CGFloat timeWidth = 0.0;
    if (status.created_at.length) {
        NSString *formatTime = [status.created_at formatRelativeTime];
        if (formatTime.length) {
            UIFont *textFont = [UIFont systemFontOfSize:kTLFontTime];
            CGSize maxSize = CGSizeMake(rectWidth / 3, kTLAvatarWidth);
            CGSize textSize = [formatTime sizeWithFont:textFont 
                                     constrainedToSize:maxSize
                                         lineBreakMode:lineMode];
            timeWidth = textSize.width + kTLOffsetFromFrame;
            if (timeRect) {
                *timeRect = CGRectMake(rectWidth - textSize.width - kTLOffsetFromFrame, kTLOffsetFromFrame, textSize.width, textSize.height);
            }
        }
    }
    
    //3.name
    if (user.screen_name.length) {
        offsetX += kTLOffsetBetweenItemH;
        UIFont *textFont = [UIFont systemFontOfSize:kTLFontName];
        CGSize maxSize = CGSizeMake(rectWidth - offsetX - timeWidth - kTLOffsetBetweenItemH, kTLAvatarHeight);
        CGSize textSize = [user.screen_name sizeWithFont:textFont 
                                       constrainedToSize:maxSize
                                           lineBreakMode:lineMode];
        if (nameRect) {
            *nameRect = CGRectMake(offsetX, kTLOffsetFromFrame, textSize.width, textSize.height);
        }
    }
    
    //4.text
    if (status.text.length) {
        offsetY += kTLOffsetBetweenItemV;
        UIFont *textFont = [UIFont systemFontOfSize:kTLFontText];
        CGSize maxSize = CGSizeMake(rectWidth - offsetX - kTLOffsetFromFrame, rectHeight);
        CGSize textSize = [status.text sizeWithFont:textFont 
                                  constrainedToSize:maxSize
                                      lineBreakMode:lineMode];
        if (textRect) {
            *textRect = CGRectMake(offsetX, offsetY, textSize.width, textSize.height);
        }
        offsetY += textSize.height;
    }
    //5.thumbnial
    if (status.thumbnail_pic.length) {
        offsetY += kTLOffsetBetweenItemV;
        if (thumbnailRect) {
            *thumbnailRect = CGRectMake(offsetX, offsetY, kTLThumbnailWidth, kTLThumbnailHeight);
        }
        offsetY += kTLThumbnailHeight;
    }
    
    offsetY += kTLOffsetFromFrame;
    
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, offsetY);    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

    }
    return self;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:_nameRect];
        _nameLabel.font = [UIFont systemFontOfSize:kTLFontTime];
        _nameLabel.numberOfLines = 0;
        _nameLabel.lineBreakMode = UILineBreakModeTailTruncation;
        _nameLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_nameLabel];
    }
    return _nameLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:_timeRect];
        _timeLabel.font = [UIFont systemFontOfSize:kTLFontTime];
        _timeLabel.numberOfLines = 0;
        _timeLabel.lineBreakMode = UILineBreakModeTailTruncation;
        _timeLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_timeLabel];
    }
    return _timeLabel;
}

- (UILabel *)weiboLabel
{
    if (!_weiboLabel) {
        _weiboLabel = [[UILabel alloc] initWithFrame:_textRect];
        _weiboLabel.font = [UIFont systemFontOfSize:kTLFontText];
        _weiboLabel.numberOfLines = 0;
        _weiboLabel.lineBreakMode = UILineBreakModeTailTruncation;
        _weiboLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_weiboLabel];
    }
    return _weiboLabel;
}

- (ZHUImageView *)avatarImageView
{
    if (!_avatarImageView) {
        _avatarImageView = [[ZHUImageView alloc] initWithFrame:_avatarRect];
        [self.contentView addSubview:_avatarImageView];
    }
    return _avatarImageView;
}

- (ZHUImageView *)thumbnailImageView
{
    if (!_thumbnailImageView) {
        _thumbnailImageView = [[ZHUImageView alloc] initWithFrame:_thumbnailRect];
        [self.contentView addSubview:_thumbnailImageView];
    }
    return _thumbnailImageView;
}

- (void)configCell
{
    if (!_cellData || ![_cellData isKindOfClass:[ZHUSinaStatuses class]]) {
        return;
    }

    [[self class] getContent:_cellData
                  avatarRect:&_avatarRect
                    nameRect:&_nameRect
                    timeRect:&_timeRect
                    textRect:&_textRect
               thumbnailRect:&_thumbnailRect];
    
    ZHUSinaStatuses *status = _cellData;

    if (status.text.length) {
        _weiboLabel.hidden = NO;
        self.weiboLabel.text = status.text;
    }
    else {
        _weiboLabel.hidden = YES;
    }
    
    if (status.created_at.length) {
        NSString *formatTime = [status.created_at formatRelativeTime];
        if (formatTime.length) {
            _timeLabel.hidden = NO;
            self.timeLabel.text = formatTime;
        }
    }
    else {
        _timeLabel.hidden = YES;
    }
    
    if (status.thumbnail_pic.length) {
        _thumbnailImageView.hidden = NO;
        self.thumbnailImageView.imageUrl = status.thumbnail_pic;
    }
    else {
        _thumbnailImageView.hidden = YES;
    }
    
    ZHUSinaUser *user = status.user;
    if (user.avatar_large.length) {
        _avatarImageView.hidden = NO;
        self.avatarImageView.imageUrl = user.avatar_large;
    }
    else {
        _avatarImageView.hidden = YES;
    }
    
    if (user.screen_name.length) {
        _nameLabel.hidden = NO;
        self.nameLabel.text = user.screen_name;
    }
    else {
        _nameLabel.hidden = YES;
    }
}

#ifdef LOAD_CELL_IMAGE_IN_CONTROLLER
- (void)refreshContentView:(TLImageType)type withObject:(id)object
{
    if (IMAGE_TYPE_THUMBNAIL == type) {
        [(ZHUTimeLineContentView *)_customContentView setThumbnailImg:object];
    }
    else if (IMAGE_TYPE_AVATAR == type) {
        [(ZHUTimeLineContentView *)_customContentView setAvatarImg:object];        
    }
}
#endif

- (void)layoutSubviews
{
    [super layoutSubviews];    
//    [[self class] getContent:_cellData
//                  avatarRect:&_avatarRect
//                    nameRect:&_nameRect
//                    timeRect:&_timeRect
//                    textRect:&_textRect
//               thumbnailRect:&_thumbnailRect];
    
    _nameLabel.frame = _nameRect;
    _timeLabel.frame = _timeRect;
    _weiboLabel.frame = _textRect;
    _avatarImageView.frame = _avatarRect;
    _thumbnailImageView.frame = _thumbnailRect;
}

@end
