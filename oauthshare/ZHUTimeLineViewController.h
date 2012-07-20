//
//  ZHUTimeLineViewController.h
//  oauthshare
//
//  Created by zhukuanxi@gmail.com on 7/10/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//


@class ZHUWBRequest;
#import "ZHUTableViewController.h"

@interface ZHUTimeLineViewController : ZHUTableViewController {
    ZHUWBRequest *_timeLineOp;
#ifdef LOAD_CELL_IMAGE_IN_CONTROLLER
    NSMutableDictionary *_imageLoadDic;
    dispatch_queue_t _imageQueue;
#endif
}

@end
