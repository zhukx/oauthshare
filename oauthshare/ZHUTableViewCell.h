//
//  ZHUTableViewCell.h
//  oauthshare
//
//  Created by kuanxi zhu on 7/12/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHUTableViewCell : UITableViewCell {
    id _cellData;
}

@property (strong, nonatomic) id cellData;
+ (CGFloat)tableView:(UITableView*)tableView rowHeightForContent:(id)object;
@end
