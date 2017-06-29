//
//  Person.m
//  NSKeyedArchiver
//
//  Created by tongqu on 2017/6/15.
//  Copyright © 2017年 Eugene Space. All rights reserved.
//

#import "Person.h"

@implementation Person


#pragma mark 编码 对对象属性进行编码的处理
// 当将一个自定义对象保存到文件的时候就会调用该方法
// 在该方法中说明如何存储自定义对象的属性
// 也就说在该方法中说清楚存储自定义对象的哪些属性
- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    NSLog(@"调用了encodeWithCoder:方法");
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.sex forKey:@"sex"];
    [aCoder encodeInteger:self.age forKey:@"age"];
    [aCoder encodeDouble:self.height forKey:@"height"];
}

#pragma mark 解码 解码归档数据来初始化对象
// 当从文件中读取一个对象的时候就会调用该方法
// 在该方法中说明如何读取保存在文件中的对象
// 也就是说在该方法中说清楚怎么读取文件中的对象
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    NSLog(@"调用了initWithCoder:方法");
    //注意：在构造方法中需要先初始化父类的方法
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.sex = [aDecoder decodeObjectForKey:@"sex"];
        self.age = [aDecoder decodeIntForKey:@"age"];
        self.height = [aDecoder decodeDoubleForKey:@"height"];
    }
    return self;
}


//⚠️如果是子类，一定要重写这两个方法
//- (void)encodeWithCoder:(NSCoder *)aCoder {
//    [super encodeWithCoder:aCoder];
//    NSLog(@"调用了子类 encodeWithCoder");
//}
//
//- (instancetype)initWithCoder:(NSCoder *)aDecoder {
//    
//    if (self = [super initWithCoder:aDecoder]) {
//        NSLog(@"调用了子类 initWithCoder");
//    }
//    return self;
//}


@end
