//
//  Person.h
//  NSKeyedArchiver
//
//  Created by tongqu on 2017/6/15.
//  Copyright © 2017年 Eugene Space. All rights reserved.
//

#import <Foundation/Foundation.h>

// 如果想将一个自定义对象保存到文件中必须实现NSCoding协议
@interface Person : NSObject<NSCoding>

//姓名
@property(nonatomic,copy) NSString *name;
//性别
@property(nonatomic,copy) NSString *sex;
//年龄
@property(nonatomic,assign) int age;
//身高
@property(nonatomic,assign) double height;

@end
