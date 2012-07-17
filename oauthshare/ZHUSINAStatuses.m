//
//  ZHUSinaStatuses.m
//  oauthshare
//
//  Created by kuanxi zhu on 7/12/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//

#define ST_STATUS                              (@"statuses")
#define ST_IDSTR                               (@"idstr")
#define ST_CREATEAT                            (@"created_at")
#define ST_ID                                  (@"id")
#define ST_TEXT                                (@"text")
#define ST_SOURCE                              (@"source")
#define ST_FAVORITED                           (@"favorited")
#define ST_TRUNCATED                           (@"truncated")
#define ST_INREPLYTOSTATUSID                   (@"in_reply_to_status_id")
#define ST_INREPLYTOUSERID                     (@"in_reply_to_user_id")
#define ST_INREPLYTOSCREENNAME                 (@"in_reply_to_screen_name")
#define ST_MID                                 (@"mid")
#define ST_BMIDDLEPIC                          (@"bmiddle_pic")
#define ST_ORIGINALPIC                         (@"original_pic")
#define ST_THUMBNAILPIC                        (@"thumbnail_pic")
#define ST_REPOSTSCOUNT                        (@"reposts_count")
#define ST_COMMENTSCOUNT                       (@"comments_count")
#define ST_ANNOTATIONS                         (@"annotations")
#define ST_GEO                                 (@"geo")
#define ST_USER                                (@"user")

#import "ZHUSinaStatuses.h"
#import "ZHUSinaGeo.h"
#import "ZHUSinaUser.h"

@implementation ZHUSinaStatuses
@synthesize idstr;	
@synthesize created_at;	
@synthesize id;	
@synthesize text;	
@synthesize source;	
@synthesize favorited;	
@synthesize truncated;	
@synthesize in_reply_to_status_id;	
@synthesize in_reply_to_user_id;	
@synthesize in_reply_to_screen_name;	
@synthesize mid;	
@synthesize bmiddle_pic;	
@synthesize original_pic;	
@synthesize thumbnail_pic;
@synthesize reposts_count;	
@synthesize comments_count;	
@synthesize annotations;	
@synthesize geo;	
@synthesize user;	

+ (NSString *)dataKey
{
    return ST_STATUS;
}

- (id)initWithDic:(NSDictionary *)dic
{
    if (self = [super initWithDic:dic]) {
        self.idstr = [dic objectForKey:ST_IDSTR];
        self.created_at = [dic objectForKey:ST_CREATEAT];
        self.id = [[dic objectForKey:ST_ID] intValue];
        self.text = [dic objectForKey:ST_TEXT];
        self.source = [dic objectForKey:ST_SOURCE];
        self.favorited = [[dic objectForKey:ST_FAVORITED] boolValue];
        self.truncated = [[dic objectForKey:ST_TRUNCATED] boolValue];
        self.in_reply_to_status_id = [[dic objectForKey:ST_INREPLYTOSTATUSID] intValue];
        self.in_reply_to_user_id = [[dic objectForKey:ST_INREPLYTOUSERID] intValue];
        self.in_reply_to_screen_name = [dic objectForKey:ST_INREPLYTOSCREENNAME];
        self.mid = [[dic objectForKey:ST_MID] intValue];
        self.bmiddle_pic = [dic objectForKey:ST_BMIDDLEPIC];
        self.original_pic = [dic objectForKey:ST_ORIGINALPIC];
        self.thumbnail_pic = [dic objectForKey:ST_THUMBNAILPIC];
        self.reposts_count = [[dic objectForKey:ST_REPOSTSCOUNT] intValue];
        self.comments_count = [[dic objectForKey:ST_COMMENTSCOUNT] intValue];
//        self.annotations = [obj objectForKey:ST_ANNOTATIONS];
//        self.geo = [obj objectForKey:ST_GEO];
        if ([dic objectForKey:[ZHUSinaUser dataKey]]) {
            self.user = [[ZHUSinaUser alloc] initWithDic:[dic objectForKey:[ZHUSinaUser dataKey]]];
        }

    }
    return self;
}
@end
