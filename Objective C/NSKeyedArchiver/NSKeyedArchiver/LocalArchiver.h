//
//  LocalArchiver.h
//  NSKeyedArchiver
//
//  Created by tongqu on 2017/6/15.
//  Copyright © 2017年 Eugene Space. All rights reserved.
//  数据持久化存储管理类，此类自用，健壮性不够，慎用 推荐：EGOCache：一个缓存类，安全 稳定

#import <Foundation/Foundation.h>

@interface LocalArchiver : NSObject

/**单例模式，获取请求管理类*/
+ (LocalArchiver *_Nullable)globalArchiver;
/**
 归档和解归档普通对象及自定义对象
 * anObject 普通对象及自定义对象 如：NSArray、NSDictionary和自定义的Person模型类等
 * key 值对应的键
 */
- (void)saveObject:(id _Nullable)anObject forKey:(NSString* __nonnull)key;
- (id _Nullable)objectForKey:(NSString* __nonnull)key;


/**清除本地的序列化的文件*/
- (void)clearArchiverData;
- (void)removeArchiverForKey:(NSString* _Nullable)key;

@end
