//
//  ZHUSinaUser.h
//  oauthshare
//
//  Created by kuanxi zhu on 7/12/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//

//id	int64	用户UID
//screen_name	string	用户昵称
//name	string	友好显示名称
//province	int	用户所在地区ID
//city	int	用户所在城市ID
//location	string	用户所在地
//description	string	用户描述
//url	string	用户博客地址
//profile_image_url	string	用户头像地址
//domain	string	用户的个性化域名
//gender	string	性别，m：男、f：女、n：未知
//followers_count	int	粉丝数
//friends_count	int	关注数
//statuses_count	int	微博数
//favourites_count	int	收藏数
//created_at	string	创建时间
//following	boolean	当前登录用户是否已关注该用户
//allow_all_act_msg	boolean	是否允许所有人给我发私信
//geo_enabled	boolean	是否允许带有地理信息
//verified	boolean	是否是微博认证用户，即带V用户
//allow_all_comment	boolean	是否允许所有人对我的微博进行评论
//avatar_large	string	用户大头像地址
//verified_reason	string	认证原因
//follow_me	boolean	该用户是否关注当前登录用户
//online_status	int	用户的在线状态，0：不在线、1：在线
//bi_followers_count	int	用户的互粉数
//status	object	用户的最近一条微博信息字段

@class ZHUSinaStatuses;
#import "ZHUWBData.h"

@interface ZHUSinaUser : ZHUWBData

@property (assign, nonatomic) NSInteger id;	//用户UID
@property (strong, nonatomic) NSString *screen_name;	//用户昵称
@property (strong, nonatomic) NSString *name;		//友好显示名称
@property (assign, nonatomic) NSInteger province;	//用户所在地区ID
@property (assign, nonatomic) NSInteger city;	//用户所在城市ID
@property (strong, nonatomic) NSString *location;	//用户所在地
@property (strong, nonatomic) NSString *description;	//用户描述
@property (strong, nonatomic) NSString *url;	//用户博客地址
@property (strong, nonatomic) NSString *profile_image_url;	//用户头像地址
@property (strong, nonatomic) NSString *domain;	//用户的个性化域名
@property (strong, nonatomic) NSString *gendero;	//性别，m：男、f：女、n：未知
@property (assign, nonatomic) NSInteger followers_count;	//粉丝数
@property (assign, nonatomic) NSInteger friends_count;	//关注数
@property (assign, nonatomic) NSInteger statuses_count;	//微博数
@property (assign, nonatomic) NSInteger favourites_count;	//收藏数
@property (strong, nonatomic) NSString *created_at;	//创建时间
@property (assign, nonatomic) BOOL following;	//当前登录用户是否已关注该用户
@property (assign, nonatomic) BOOL allow_all_act_msg;	//是否允许所有人给我发私信
@property (assign, nonatomic) BOOL geo_enabled;	//是否允许带有地理信息
@property (assign, nonatomic) BOOL verified;	//是否是微博认证用户，即带V用户
@property (assign, nonatomic) BOOL allow_all_comment;	//是否允许所有人对我的微博进行评论
@property (strong, nonatomic) NSString *avatar_large;	//用户大头像地址
@property (strong, nonatomic) NSString *verified_reason;	//认证原因
@property (assign, nonatomic) BOOL follow_me;	//该用户是否关注当前登录用户
@property (assign, nonatomic) NSInteger online_status;	//用户的在线状态，0：不在线、1：在线
@property (assign, nonatomic) NSInteger bi_followers_count;	//用户的互粉数
@property (strong, nonatomic) ZHUSinaStatuses *status;		//用户的最近一条微博信息字段
@end
