//
//  ZHUAdditions.m
//  oauthshare
//
//  Created by zhukuanxi@gmail.com on 7/9/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//

static char SELECTIMG_KEY;
#import "ZHUAdditions.h"

@implementation UITabBarItem (additionalImage)
- (void)setSelectedImg:(UIImage *)img
{
    objc_setAssociatedObject(self, &SELECTIMG_KEY, img, OBJC_ASSOCIATION_RETAIN_NONATOMIC);    
}

- (UIImage *)selectedImg
{
    UIImage *img = objc_getAssociatedObject(self, &SELECTIMG_KEY);
    return img;
}
@end

@implementation NSArray (safeUtil)
- (id)safeObjectAtIndex:(NSUInteger)index {
    if (index < self.count) {
        return [self objectAtIndex:index];
    }
    return nil;
}

- (NSArray *)uniqueArray {
    NSMutableArray *uniqeArr = [NSMutableArray array];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (![uniqeArr containsObject:obj]) {
            [uniqeArr safeAddObject:obj];
        }
    }];
    return uniqeArr;
}

@end

@implementation NSMutableArray (safeUtil)
- (void)uniqueAddObject:(id)objcet {
    if (objcet && ![self containsObject:objcet]) {
        [self safeAddObject:objcet];
    }
}

- (void)safeAddObject:(id)object {
    if (object) {
        [self addObject:object];
    }
}

- (void)safeInsertObject:(id)anObject atIndex:(NSUInteger)index {
    if (anObject) {
        [self insertObject:anObject atIndex:index];
    }
}
@end


@implementation NSMutableDictionary (safeUtil)
- (void)safeSetObject:(id)anObject forKey:(id)aKey {
    if (anObject) {
        [self setObject:anObject forKey:aKey];
    }
}

- (void)safeSetValue:(id)value forKey:(NSString *)key {
    if (value) {
        [self setValue:value forKey:key];
    }
}
@end

@implementation NSString (timeUtil)
- (time_t)convertToUnixTime
{
    time_t createdAt;
    struct tm created;
    time_t now;
    time(&now);
    
    if (self) {
        if (strptime([self UTF8String], "%a %b %d %H:%M:%S %z %Y", &created) == NULL) {
            strptime([self UTF8String], "%a, %d %b %Y %H:%M:%S %z", &created);
        }
        createdAt = mktime(&created);
    }
    return createdAt;
}

- (NSString *)formatRelativeTime
{
    time_t sourceTime = [self convertToUnixTime];
    NSString *_timestamp = nil;
    time_t now;
    time(&now);
    
    int distance = (int)difftime(now, sourceTime);
    if (distance < 0) {
        distance = 0;        
    }
    
    if (distance < kMINUTE) {
        _timestamp = [NSString stringWithFormat:@"in %d %@", distance, NSLocalizedString(@"seconds", nil)];
    }
    else if (distance < kHOUR) {  
        distance = distance / kMINUTE;
        _timestamp = [NSString stringWithFormat:@"in %d %@", distance, NSLocalizedString(@"minutes", nil)];
    }  
    else if (distance < kDAY) {
        distance = distance / kHOUR;
        _timestamp = [NSString stringWithFormat:@"in %d %@", distance, NSLocalizedString(@"hours", nil)];
    }
    else if (distance < kWEEK) {
        distance = distance / kDAY;
        _timestamp = [NSString stringWithFormat:@"in %d %@", distance, NSLocalizedString(@"days", nil)];
    }
    else if (distance < kMONTH) {
        distance = distance / kWEEK;
        _timestamp = [NSString stringWithFormat:@"in %d %@", distance, NSLocalizedString(@"weeks", nil)];
    }
    else {
        static NSDateFormatter *dateFormatter = nil;
        if (dateFormatter == nil) {
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateStyle:NSDateFormatterShortStyle];
            [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        }
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:sourceTime];        
        _timestamp = [dateFormatter stringFromDate:date];
    }
    return _timestamp;

}
@end
