//
//  ZHUWBData.h
//  oauthshare
//
//  Created by kuanxi zhu on 7/12/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZHUWeiboDef.h"
@interface ZHUWBData : NSObject {

}
+ (NSString *)dataKey;
- (id)initWithDic:(NSDictionary *)dic;
@end
