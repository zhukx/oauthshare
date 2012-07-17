//
//  ZHUTimeLineContentView.m
//  oauthshare
//
//  Created by zhukuanxi@gmail.com on 7/13/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//

#import "ZHUTimeLineContentView.h"
#import "ZHUSinaStatuses.h"
#import "ZHUSinaUser.h"

@interface ZHUTableContentView ()
+ (CGSize)getContent:(id)object
            nameRect:(CGRect *)nameRect 
            timeRect:(CGRect *)timeRect
            textRect:(CGRect *)textRect
       thumbnailRect:(CGRect *)thumbnailRect;

- (void)drawImage:(UIImage *)image
          inLayer:(CALayer *)layer
           inRect:(CGRect)rect
         animated:(BOOL)animated;

- (void)tapInContentView:(UITapGestureRecognizer *)tapGes;
@end

@implementation ZHUTimeLineContentView
@synthesize fadeImage = _fadeImage;
@synthesize fadeDuration = _fadeDuration;
+ (CGSize)getContentSize:(id)object
{
    return [self getContent:object 
                   nameRect:nil 
                   timeRect:nil 
                   textRect:nil
              thumbnailRect:nil];
}

+ (CGSize)getContent:(id)object
            nameRect:(CGRect *)nameRect 
            timeRect:(CGRect *)timeRect
            textRect:(CGRect *)textRect
       thumbnailRect:(CGRect *)thumbnailRect
{
    if (![object isKindOfClass:[ZHUSinaStatuses class]]) {
        return CGSizeZero;
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
        _fadeImage = YES;
        _fadeDuration = 0.5;
        
        _avatarRect = CGRectMake(kTLOffsetFromFrame, kTLOffsetFromFrame, kTLAvatarWidth, kTLAvatarHeight);
        _avatarLayer = [[CALayer alloc] init];
        _avatarLayer.frame = _avatarRect;
        [self.layer addSublayer:_avatarLayer];
        
        _thumbnailLayer = [[CALayer alloc] init];
        [self.layer addSublayer:_thumbnailLayer];
        
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(tapInContentView:)];
        [self addGestureRecognizer:ges];
    }
    return self;
}

- (void)configContentView
{
    if (![_contentData isKindOfClass:[ZHUSinaStatuses class]]) {
        return;
    }
    [CATransaction begin]; 
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    //[self prepareForReuse];
    [self calculateRectsForDraw];
    [CATransaction commit];
    
    ZHUSinaStatuses *status = _contentData;
    if (status.thumbnail_pic.length) {
#ifdef USE_ADDSUBVIEW 
        if (!_imgView) {
            _imgView = [[ZHUImageView alloc] initWithFrame:self.frame];
            _imgView.contentMode = UIViewContentModeScaleAspectFit;
            [self addSubview:_imgView];
        }
        _imgView.imageUrl = status.thumbnail_pic;
#endif
        _thumbnailOp = [[ZHUWBRequestEngine sharedEngine] imageAtURL:[NSURL URLWithString:status.thumbnail_pic] 
                                         onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
                                             _thumbnailImg = fetchedImage;    
                                             [self setNeedsDisplayInRect:_thumbnailRect];
                                         }];
    }
    
    ZHUSinaUser *user = status.user;
    if (user) {
        if (user.avatar_large.length) {
//            _avatarOp = [[ZHUWBRequestEngine sharedEngine] imageAtURL:[NSURL URLWithString:user.avatar_large] 
//                                                            onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
//                                                                if (isInCache) {
//                                                                    ALog(@"from cache");
//                                                                }
//                                                                else {
//                                                                    ALog(@"from server");
//                                                                }
//                                                                _avatarImg = fetchedImage;    
//                                                                [self setNeedsDisplayInRect:_avatarRect];
//                                                            }];
        }
    }
}

- (void)prepareForReuse
{
#ifdef USE_ADDSUBVIEW
    _imgView.image = nil;
#endif
    _contentData = nil;
    
    _thumbnailLayer.contents = nil;
    _thumbnailImg = nil;
    [_thumbnailOp cancel];
    _thumbnailOp = nil;
    
    _avatarLayer.contents = nil;
    _avatarImg = nil;
    [_avatarOp cancel];
    _avatarOp = nil;
    [self setNeedsDisplay];
}

- (void)drawImage:(UIImage *)image
          inLayer:(CALayer *)layer
           inRect:(CGRect)rect
         animated:(BOOL)animated
{    
    if (animated && image) {
        layer.hidden = NO;
        CATransition *tran = [CATransition animation];
        tran.duration = _fadeDuration;
        tran.type = kCATransitionFade;
        layer.contents = (id)image.CGImage;
        [layer addAnimation:tran forKey:nil];
        
    }
    else {
        [CATransaction begin]; 
        [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
        layer.hidden = YES;  
        [CATransaction commit];
        
        if (image) {
            [image drawInRect:rect];
        }
    }
}

- (void)calculateRectsForDraw
{
    [[self class] getContent:_contentData 
                    nameRect:&_nameRect
                    timeRect:&_timeRect
                    textRect:&_textRect
               thumbnailRect:&_thumbnailRect];
    _thumbnailLayer.frame = _thumbnailRect;
}

- (void)tapInContentView:(UITapGestureRecognizer *)tapGes
{
    CGPoint touchPt = [tapGes locationInView:self];
    if (CGRectContainsPoint(_thumbnailRect, touchPt)) {
        NSLog(@"thumbnail touched");
    }
    else if (CGRectContainsPoint(_avatarRect, touchPt)) {
        NSLog(@"avatar touched");
    }
    else {
        NSLog(@"content touched");
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    if (CGRectEqualToRect(rect, _thumbnailRect)) {
        if (_thumbnailImg) {
            [CATransaction begin]; 
            [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
            CGRect frame = _thumbnailRect;
            frame.size.width = MIN(_thumbnailImg.size.width, 300);
            _thumbnailRect = frame;
            _thumbnailLayer.frame = _thumbnailRect;
            [CATransaction commit]; 
            [self drawImage:_thumbnailImg
                    inLayer:_thumbnailLayer
                     inRect:_thumbnailRect
                   animated:_fadeImage];
        }
        return;
    }
    
    if (CGRectEqualToRect(rect, _avatarRect)) {
        if (_avatarImg) {
            [self drawImage:_avatarImg
                    inLayer:_avatarLayer
                     inRect:_avatarRect
                   animated:_fadeImage];
        }
        return;
    }
    
    ZHUSinaStatuses *status = _contentData;
    ZHUSinaUser *user = status.user;
    UILineBreakMode lineMode = UILineBreakModeTailTruncation;
    UITextAlignment alignMode = UITextAlignmentLeft;
    
    //1.draw time
    if (status.created_at.length) {
        NSString *formatTime = [status.created_at formatRelativeTime];
        if (formatTime.length) {
            UIFont *textFont = [UIFont systemFontOfSize:kTLFontTime];
            [formatTime drawInRect:_timeRect
                          withFont:textFont
                     lineBreakMode:lineMode
                         alignment:alignMode];

        }
    }
    
    //2.draw name
    if (user.screen_name.length) {
        UIFont *textFont = [UIFont systemFontOfSize:kTLFontName];
        [user.screen_name drawInRect:_nameRect
                       withFont:textFont
                  lineBreakMode:lineMode
                      alignment:alignMode];
    }

    //3.draw text
    if (status.text.length) {
        UIFont *textFont = [UIFont systemFontOfSize:kTLFontText];
        [status.text drawInRect:_textRect
                            withFont:textFont
                       lineBreakMode:lineMode
                           alignment:alignMode];
    }
    
    //4.draw avatar
    if (_avatarImg) {
        [self drawImage:_avatarImg
                inLayer:_avatarLayer
                 inRect:_avatarRect
               animated:_fadeImage];
    }
    
    //5.draw thumbnial
    if (_thumbnailImg) {
        [CATransaction begin]; 
        [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
        CGRect frame = _thumbnailRect;
        frame.size.width = MIN(_thumbnailImg.size.width, 300);
        _thumbnailRect = frame;
        _thumbnailLayer.frame = _thumbnailRect;
        [CATransaction commit];
        [self drawImage:_thumbnailImg
                inLayer:_thumbnailLayer
                 inRect:_thumbnailRect
               animated:_fadeImage];
    }
}


@end
