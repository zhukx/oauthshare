//
//  ZHUUtil.h
//  oauthshare
//
//  Created by zhukuanxi@gmail.com on 7/9/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
//Functions for Encoding Data.
@interface NSData (ZHUUtil)
- (NSString *)MD5EncodedString;
- (NSData *)HMACSHA1EncodedDataWithKey:(NSString *)key;
- (NSString *)base64EncodedString;
@end

//Functions for Encoding String.
@interface NSString (ZHUUtil)
- (NSString *)MD5EncodedString;
- (NSData *)HMACSHA1EncodedDataWithKey:(NSString *)key;
- (NSString *)base64EncodedString;
- (NSString *)URLEncodedString;
- (NSString *)URLEncodedStringWithCFStringEncoding:(CFStringEncoding)encoding;
- (NSDictionary *)dictionaryFromString;
- (NSString *)getStringWithKey:(NSString *)key;
+ (NSString *)GUIDString;
@end

@interface NSDictionary (ZHUUtil)
- (NSString *)stringFromDictionary;
@end
