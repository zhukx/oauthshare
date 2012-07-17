//
//  ZHUSinaUser.m
//  oauthshare
//
//  Created by kuanxi zhu on 7/12/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//

#define US_USER                     (@"user")
#define US_ID                       (@"id")	
#define US_SCREENNAME               (@"screen_name")	
#define US_NAME                     (@"name")		
#define US_PROVINCE                 (@"province")	
#define US_CITY                     (@"city")	
#define US_LOCATION                 (@"location")	
#define US_DESCRIPTION              (@"description")	
#define US_URL                      (@"url")	
#define US_PROFILEIMAGEURL          (@"profile_image_url")	
#define US_DOMAIN                   (@"domain")	
#define US_GENDERO                  (@"gendero")	
#define US_FOLLOWERSCOUNT           (@"followers_count")	
#define US_FRIENDSCOUNT             (@"friends_count")	
#define US_STATUSESCOUNT            (@"statuses_count")	
#define US_FAVOURITESCOUNT          (@"favourites_count")	
#define US_CREATEDAT                (@"created_at")	
#define US_FOLLOWING                (@"following")	
#define US_ALLOWALLACTMSG           (@"allow_all_actmsg")	
#define US_GEOENABLED               (@"geo_enabled")	
#define US_VERIFIED                 (@"verified")	
#define US_ALLOWALLCOMMENT          (@"allow_all_comment")	
#define US_AVATARLARGE              (@"avatar_large")	
#define US_VERIFIEDREASON           (@"verified_reason")	
#define US_FOLLOWME                 (@"follow_me")	
#define US_ONLINESTATUS             (@"online_status")
#define US_BIFOLLOWERSCOUNT         (@"bi_followers_count")	
#define US_STATUS                   (@"status")		


#import "ZHUSinaUser.h"
#import "ZHUSinaStatuses.h"

@implementation ZHUSinaUser
@synthesize id;	//用户UID
@synthesize screen_name;	//用户昵称
@synthesize name;		//友好显示名称
@synthesize province;	//用户所在地区ID
@synthesize city;	//用户所在城市ID
@synthesize location;	//用户所在地
@synthesize description;	//用户描述
@synthesize url;	//用户博客地址
@synthesize profile_image_url;	//用户头像地址
@synthesize domain;	//用户的个性化域名
@synthesize gendero;	//性别，m：男、f：女、n：未知
@synthesize followers_count;	//粉丝数
@synthesize friends_count;	//关注数
@synthesize statuses_count;	//微博数
@synthesize favourites_count;	//收藏数
@synthesize created_at;	//创建时间
@synthesize following;	//当前登录用户是否已关注该用户
@synthesize allow_all_act_msg;	//是否允许所有人给我发私信
@synthesize geo_enabled;	//是否允许带有地理信息
@synthesize verified;	//是否是微博认证用户，即带V用户
@synthesize allow_all_comment;	//是否允许所有人对我的微博进行评论
@synthesize avatar_large;	//用户大头像地址
@synthesize verified_reason;	//认证原因
@synthesize follow_me;	//该用户是否关注当前登录用户
@synthesize online_status;	//用户的在线状态，0：不在线、1：在线
@synthesize bi_followers_count;	//用户的互粉数
@synthesize status;		//用户的最近一条微博信息字段

+ (NSString *)dataKey
{
    return US_USER;
}

- (id)initWithDic:(NSDictionary *)dic
{
    if (self = [super initWithDic:dic]) {
        self.id = [[dic objectForKey:US_ID] intValue];
        self.screen_name = [dic objectForKey:US_SCREENNAME];
        self.name = [dic objectForKey:US_NAME];
        self.province = [[dic objectForKey:US_PROVINCE] intValue];
        self.city = [[dic objectForKey:US_CITY] intValue];
        self.location = [dic objectForKey:US_LOCATION];
        self.description = [dic objectForKey:US_DESCRIPTION];
        self.url = [dic objectForKey:US_URL];
        self.profile_image_url = [dic objectForKey:US_PROFILEIMAGEURL];
        self.domain = [dic objectForKey:US_DOMAIN];
        self.gendero = [dic objectForKey:US_GENDERO];
        self.followers_count = [[dic objectForKey:US_FOLLOWERSCOUNT] intValue];
        self.friends_count = [[dic objectForKey:US_FRIENDSCOUNT] intValue];
        self.statuses_count = [[dic objectForKey:US_STATUSESCOUNT] intValue];
        self.favourites_count = [[dic objectForKey:US_FAVOURITESCOUNT] intValue];
        self.created_at = [dic objectForKey:US_CREATEDAT];
        self.following = [[dic objectForKey:US_FOLLOWING] boolValue];
        self.allow_all_act_msg = [[dic objectForKey:US_ALLOWALLACTMSG] boolValue];
        self.geo_enabled = [[dic objectForKey:US_GEOENABLED] boolValue];
        self.verified = [[dic objectForKey:US_VERIFIED] boolValue];
        self.allow_all_comment = [[dic objectForKey:US_ALLOWALLCOMMENT] boolValue];
        self.avatar_large = [dic objectForKey:US_AVATARLARGE];
        self.verified_reason = [dic objectForKey:US_VERIFIEDREASON];
        self.follow_me = [[dic objectForKey:US_FOLLOWME] boolValue];
        self.online_status = [[dic objectForKey:US_ONLINESTATUS] intValue];
        self.bi_followers_count = [[dic objectForKey:US_BIFOLLOWERSCOUNT] intValue];
        if ([dic objectForKey:[ZHUSinaStatuses dataKey]]) {
            self.status = [[ZHUSinaStatuses alloc] initWithDic:[dic objectForKey:[ZHUSinaStatuses dataKey]]];
        }
    }
    return self;
}
@end
