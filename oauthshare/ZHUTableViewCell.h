//
//  ZHUTableViewCell.h
//  oauthshare
//
//  Created by kuanxi zhu on 7/12/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHUTableContentView.h"
#import "ZHUTimeLineContentView.h"

@interface ZHUTableViewCell : UITableViewCell {
    id _cellData;
    ZHUTableContentView *_customContentView;
    Class _customContentViewClass;
}

@property (strong, nonatomic) id cellData;
+ (CGFloat)tableView:(UITableView*)tableView rowHeightForContent:(id)object;
@end
