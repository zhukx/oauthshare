//
//  ZHUSinaStatuses.h
//  oauthshare
//
//  Created by kuanxi zhu on 7/12/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//

//idstr	string	字符串型的微博ID
//created_at	string	创建时间
//id	int64	微博ID
//text	string	微博信息内容
//source	string	微博来源
//favorited	boolean	是否已收藏
//truncated	boolean	是否被截断
//in_reply_to_status_id	int64	回复ID
//in_reply_to_user_id	int64	回复人UID
//in_reply_to_screen_name	string	回复人昵称
//mid	int64	微博MID
//bmiddle_pic	string	中等尺寸图片地址
//original_pic	string	原始图片地址
//thumbnail_pic	string	缩略图片地址
//reposts_count	int	转发数
//comments_count	int	评论数
//annotations	array	微博附加注释信息
//geo	object	地理信息字段
//user	object	微博作者的用户信息字段

@class ZHUSinaGeo;
@class ZHUSinaUser;
#import "ZHUSinaUser.h"
#import "ZHUWBData.h"

@interface ZHUSinaStatuses : ZHUWBData

@property (strong, nonatomic) NSString *idstr;	//字符串型的微博ID
@property (strong, nonatomic) NSString *created_at;	//创建时间
@property (assign, nonatomic) NSInteger id;	//微博ID
@property (strong, nonatomic) NSString *text;	//微博信息内容
@property (strong, nonatomic) NSString *source;	//微博来源
@property (assign, nonatomic) BOOL favorited;	//是否已收藏
@property (assign, nonatomic) BOOL truncated;	//是否被截断
@property (assign, nonatomic) NSInteger in_reply_to_status_id;	//回复ID
@property (assign, nonatomic) NSInteger in_reply_to_user_id;	//回复人UID
@property (strong, nonatomic) NSString *in_reply_to_screen_name;	//回复人昵称
@property (assign, nonatomic) NSInteger mid;	//微博MID
@property (strong, nonatomic) NSString *bmiddle_pic;	//中等尺寸图片地址
@property (strong, nonatomic) NSString *original_pic;	//原始图片地址
@property (strong, nonatomic) NSString *thumbnail_pic;	//缩略图片地址
@property (assign, nonatomic) NSInteger reposts_count;	//转发数
@property (assign, nonatomic) NSInteger comments_count;	//评论数
@property (strong, nonatomic) NSMutableArray *annotations;	//微博附加注释信息
@property (strong, nonatomic) ZHUSinaGeo *geo;	//地理信息字段
@property (strong, nonatomic) ZHUSinaUser *user;	//微博作者的用户信息字段
@end
