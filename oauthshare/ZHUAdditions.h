//
//  ZHUAdditions.h
//  oauthshare
//
//  Created by zhukuanxi@gmail.com on 7/9/12.
//  Copyright (c) 2012 tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface UITabBarItem (additionalImage)
- (UIImage *)selectedImg;
- (void)setSelectedImg:(UIImage *)img;
@end

@interface NSArray (safeUtil)
- (id)safeObjectAtIndex:(NSUInteger)index;
- (NSArray *)uniqueArray;
@end

@interface NSMutableArray (safeUtil)
- (void)safeAddObject:(id)object;
- (void)uniqueAddObject:(id)objcet;
- (void)safeInsertObject:(id)anObject atIndex:(NSUInteger)index;
@end


@interface NSMutableDictionary (safeUtil)
- (void)safeSetObject:(id)anObject forKey:(id)aKey;
- (void)safeSetValue:(id)value forKey:(NSString *)key;
@end