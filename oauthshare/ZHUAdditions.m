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