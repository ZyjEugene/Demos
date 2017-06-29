//
//  LocalArchiver.m
//  NSKeyedArchiver
//
//  Created by tongqu on 2017/6/15.
//  Copyright © 2017年 Eugene Space. All rights reserved.
//

#import "LocalArchiver.h"

@implementation LocalArchiver

+ (LocalArchiver *)globalArchiver {
    
    static id instance;
    static dispatch_once_t onceTocken;
    dispatch_once(&onceTocken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

- (instancetype)init {
    
    self = [super init];
    if(self) {
        
        [self createFolder];
    }
    return self;
}


#pragma mark - Public Function
//沙盒目录
- (NSString *)documentPath {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true) firstObject];
}

//沙盒目录下的存储目录，文件夹名可以随便取
- (NSString *)documentAchiverFolder {
    return [self.documentPath stringByAppendingPathComponent:@"Achiver"];
}

- (void)createFolder {
    //拼接路径
    NSString * path = [self documentAchiverFolder];
    
    BOOL isDirectory;
    
    //查找是否存在这个文件夹,isDirectory用来判断是文件夹还是文件，如果路径不存在，返回为undefined，表示不能确定
    if ([[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory]) {
        //存在这个文件夹
        return;//不做操作
    }
    //不存在创建文件夹
    else {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:true attributes:nil error:nil];
    }
}

//根据key 获取归档文件
- (NSString *)archiverPathForKey:(NSString *)key {
    
    if ([key containsString:@"_"] || [key containsString:@"."]) {
        key = [key stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
        key = [key stringByReplacingOccurrencesOfString:@"/" withString:@"."];
    }
    
    NSString *filePath = [self.documentAchiverFolder stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.archiver",key]];
    
    NSLog(@"key:%@ %@",key,filePath);
    return filePath;
}

//清理所有归档文件
- (void)clearArchiverData {
    NSError *error;
    if([[NSFileManager defaultManager] removeItemAtPath:self.documentAchiverFolder error:&error]) {
        NSLog(@"清除本地序列化的文件成功");
    } else {
        NSLog(@"清除本地序列化的文件失败....:%@",error);
    }
}

//移除指定归档文件
- (void)removeArchiverForKey:(NSString *)key {
    
    NSString *filePath = [self archiverPathForKey:key];
    
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:NULL];
}

#pragma mark -
#pragma mark Object methods
- (id _Nullable)objectForKey:(NSString* __nonnull)key {
    
    if ([key containsString:@"_"] || [key containsString:@"."]) {
        key = [key stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
        key = [key stringByReplacingOccurrencesOfString:@"/" withString:@"."];
    }
    
    //解归档
    //1、从磁盘读取文件，生成NSData实例
    NSString *filePath = [self.documentAchiverFolder stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.archiver",key]];
    //开始解码获取
    return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
}

- (void)saveObject:(id _Nullable)anObject forKey:(NSString* __nonnull)key {
    
    //解归档
    //1、从磁盘读取文件，生成NSData实例
    NSString *filePath = [self archiverPathForKey:key];
    //开始编码存数据
    [NSKeyedArchiver archiveRootObject:anObject toFile:filePath];
    
}


@end
