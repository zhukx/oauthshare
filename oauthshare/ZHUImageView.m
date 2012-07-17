//
//  ZHUImageView.m
//  oauthshare
//
//  Created by zhukuanxi@gmail.com on 7/13/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//
static char IMAGEURL_KEY;
#import "ZHUImageView.h"

@implementation UIImageView (ZHUImageView)
- (NSString *)imageUrl
{
    return objc_getAssociatedObject(self, &IMAGEURL_KEY);
}

- (void)setImageUrl:(NSString *)imageUrl
{
    objc_setAssociatedObject(self, &IMAGEURL_KEY, imageUrl, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end

@interface ZHUImageView ()
- (void)loadRequest;
@end

@implementation ZHUImageView
@synthesize fadeImage = _fadeImage;
@synthesize fadeDuration = _fadeDuration;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _fadeImage = YES;
        _fadeDuration = 0.5;

    }
    return self;
}

- (void)setImageUrl:(NSString *)imageUrl
{
    if (imageUrl && ![imageUrl isEqualToString:[self imageUrl]]) {
        if ([self imageUrl]) {
            [super setImageUrl:nil];
            self.image = nil;
        }
        [super setImageUrl:imageUrl];
        [self loadRequest];
    }
}

- (void)loadRequest
{
    if (_request.isExecuting) {
        [_request cancel];
    }
    _request = [[ZHUWBRequest alloc] initWithURLString:self.imageUrl 
                                                             params:nil 
                                                         httpMethod:@"GET" 
                                                         requestType:WBREQUEST_TYPE_IMAGE
                                                        finishBlock:^(id returnInfo) {
                                                            if ([returnInfo isKindOfClass:[UIImage class]]) {
                                                                if (_fadeImage) {
                                                                    CATransition *tran = [CATransition animation];
                                                                    tran.type = kCATransitionFade;
                                                                    tran.duration = _fadeDuration;
                                                                    self.image = returnInfo;    
                                                                    [self.layer addAnimation:tran forKey:nil];
                                                                }
                                                                else {
                                                                    self.image = returnInfo;
                                                                }
                                                                DLog(@"image size %f--%f", self.image.size.width, self.image.size.height);
                                                            }
                                                        } 
                                                         errorBlock:^(NSError *error) {
                                                             DLog(@"return error \n%@", [error localizedDescription]);
                                                         }];
    DLog(@"request url \n%@", _request.url);
    [[ZHUWBRequestEngine sharedEngine] loadWBRequest:_request];
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
