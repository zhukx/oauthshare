//
//  ZHUUtil.m
//  oauthshare
//
//  Created by zhukuanxi@gmail.com on 7/9/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//

#import "ZHUUtil.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#import "GTMBase64.h"

#pragma mark - NSData (ZHUUtil)

@implementation NSData (ZHUUtil)

- (NSString *)MD5EncodedString
{
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	CC_MD5([self bytes], [self length], result);
	
	return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
			result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
			result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];
}

- (NSData *)HMACSHA1EncodedDataWithKey:(NSString *)key
{   
	NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    void *buffer = malloc(CC_SHA1_DIGEST_LENGTH);
    CCHmac(kCCHmacAlgSHA1, [keyData bytes], [keyData length], [self bytes], [self length], buffer);
	
	NSData *encodedData = [NSData dataWithBytesNoCopy:buffer length:CC_SHA1_DIGEST_LENGTH freeWhenDone:YES];
    return encodedData;
}

- (NSString *)base64EncodedString
{
	return [GTMBase64 stringByEncodingData:self];
}

@end

#pragma mark - NSString (ZHUUtil)

@implementation NSString (ZHUUtil)

- (NSString *)MD5EncodedString
{
	return [[self dataUsingEncoding:NSUTF8StringEncoding] MD5EncodedString];
}

- (NSData *)HMACSHA1EncodedDataWithKey:(NSString *)key
{
	return [[self dataUsingEncoding:NSUTF8StringEncoding] HMACSHA1EncodedDataWithKey:key];
}

- (NSString *) base64EncodedString
{
	return [[self dataUsingEncoding:NSUTF8StringEncoding] base64EncodedString];
}

- (NSString *)URLEncodedString
{
	return [self URLEncodedStringWithCFStringEncoding:kCFStringEncodingUTF8];
}

- (NSString *)URLEncodedStringWithCFStringEncoding:(CFStringEncoding)encoding
{
    CFStringRef selfStrRef = (__bridge_retained CFStringRef)self;
    CFStringRef enStrRef = CFURLCreateStringByAddingPercentEscapes(NULL, 
                                                                   selfStrRef, 
                                                                   NULL,
                                                                   CFSTR("=,!$&'()*+;@?\n\"<>#\t :/"), 
                                                                   encoding);
    CFRelease(selfStrRef);
    NSString *enStr = (__bridge_transfer NSString *)enStrRef;
	return enStr;
}

- (NSDictionary *)dictionaryFromString
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSArray *pairs = [self componentsSeparatedByString:@"&"];
    [pairs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            NSArray *itemArr = [obj componentsSeparatedByString:@"="];
            if (2 == itemArr.count) {
                [dic setObject:[itemArr lastObject] forKey:[itemArr objectAtIndex:0]];
            }
        }
    }];
    return dic;    
}

- (NSString *)getStringWithKey:(NSString *)key
{
    NSString * str = nil;
	NSRange startRange = [self rangeOfString:key];
	if (NSNotFound != startRange.location) {
		NSRange endRange = [[self substringFromIndex:startRange.location + startRange.length] rangeOfString:@"&"];
		NSUInteger offset = startRange.location + startRange.length;
		str = (endRange.location == NSNotFound)
		? [self substringFromIndex:offset]
		: [self substringWithRange:NSMakeRange(offset, endRange.location)];
		str = [str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	}
	return str;
}

+ (NSString *)GUIDString
{
	CFUUIDRef theUUID = CFUUIDCreate(NULL);
	CFStringRef string = CFUUIDCreateString(NULL, theUUID);
	CFRelease(theUUID);
	return (__bridge_transfer NSString *)string;
}

@end

@implementation NSDictionary (ZHUUtil)
- (NSString *)stringFromDictionary
{
    NSMutableArray *pairs = [NSMutableArray array];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            [pairs addObject:[NSString stringWithFormat:@"%@=%@", key, [obj URLEncodedString]]];
        }
    }];	
    return [pairs componentsJoinedByString:@"&"];
}

@end