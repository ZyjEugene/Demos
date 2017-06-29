//
//  ViewController.m
//  NSKeyedArchiver
//
//  Created by tongqu on 2017/6/15.
//  Copyright © 2017年 Eugene Space. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "LocalArchiver.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //iOS数据持久化存储--NSKeyedArchiver(归档)
    //归档是把对象转为字节码，以文件的形式存储到磁盘上(也称为序列化，持久化)；程序运行过程中或者当再次重写打开程序的时候，可以通过解归档（反序列化）还原这些对象。归档和解归档用于少量数据的持久化存储和读取。
    
    /**
     注意：
     *1、默认情况下，只能对NSDate, NSNumber, NSString, NSArray, or NSDictionary来进行归档。
     *2、若对自定义的对象进行归档，需要实现NSCoding协议，并实现NSCoding方法。
     *3、如果用了继承，则子类一定要重写NSCoding协议的两个方法。
     NSCoding协议的方法：
     - (void)encodeWithCoder:(NSCoder *)aCoder;
     - (id)initWithCoder:(NSCoder *)aDecoder;
    */
    
    /**
     归档的方式：
     * 针对对象进行归档（NSArray，NSDictionary等）
     * 对自定义的内容进行归档
     * 对自定义的对象进行归档
     */
    
    [self objArchiver];
    
    [self customContentArchiver];
    
    [self customObjectArchiver];
    
    [self customArchiverManagerClass];
 
}

- (void)objArchiver {
    
    //归档（序列化）
    NSArray *archiverAry = @[
                             @{@"Eugene" : @"ZhangYanJin"},
                             @{@"Chana" : @"LiChang"}
                             ];
    NSString *filePath = [self filePathWithName:@"Object"];
    if ([NSKeyedArchiver archiveRootObject:archiverAry toFile:filePath]) {
        NSLog(@"\n\n\n归档成功：路径%@",filePath);
    }
    
    //解归档 (反序列化)
    NSArray *unArchiverAry = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSLog(@"\n解归档成功 %@",unArchiverAry);
    
    /**
     总结：
     *优点：归档和解归档操作步骤简单方便
     *缺点：一次只能归档一个对象，如果归档多个对象，需要分开麻烦，操作繁琐费时
     */
}

- (void)customContentArchiver {
    
    //归档
    //1、使用Data存放归档数据
    NSMutableData *archiverData = [NSMutableData data];
    
    //2、根据Data实例创建和初始化归档对象
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:archiverData];
    
    //3、添加归档内容（设置键值对）
    [archiver encodeObject:@"Eugene" forKey:@"name"];
    [archiver encodeObject:@"man" forKey:@"sex"];
    [archiver encodeInt:25 forKey:@"age"];
    [archiver encodeObject:@[@"OC",@"Swift",@"Html"] forKey:@"laguage"];
    [archiver encodeObject:@{@"favorite" : @"cook"} forKey:@"life"];
    [archiver encodeCGPoint:CGPointMake(1.0, 2.0) forKey:@"point"];
    
    //4、完成归档
    [archiver finishEncoding];
    
    //5、将归档的信息存储到磁盘上
    NSString *filePath = [self filePathWithName:@"CustomContent"];
    if ([archiverData writeToFile:filePath atomically:YES]) {
        NSLog(@"\n\n\n归档成功：路径%@",filePath);
    }
    
    //解归档
    //1、从磁盘读取文件，生成NSData实例
    NSData *unarchiverData = [NSData dataWithContentsOfFile:filePath];

    //2、根据Data实例创建和初始化解归档对象
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:unarchiverData];

    //3、解归档，根据key值访问
    NSString *name = [unarchiver decodeObjectForKey:@"name"];
    NSDictionary *life = [unarchiver decodeObjectForKey:@"life"];
    NSLog(@"\n解归档成功: %@ %@",name,life);
    
    //4、完成解归档
    [unarchiver finishDecoding];

    /**
     总结：
     *优点：可以同时归档多个对象、以及不同类型的对象（如：Int、CGFloat、CGPoint）
     *缺点：这里的对象都是基本类型数据，如果我想对自己定义类生成的实例对象进行归档，这样做将使操作又变得繁琐费时了
     */
}

- (void)customObjectArchiver {
    
    //序列化和反序列化遵循NSCoding协议的自定义类
    
    //归档
    Person *person = [[Person alloc] init];
    person.name = @"Eugene";
    person.sex = @"man";
    person.age = 25;
    person.height = 175;
    
    NSString *filePath = [self filePathWithName:@"CustomObject"];

    if ([NSKeyedArchiver archiveRootObject:person toFile:filePath]) {
        NSLog(@"\n\n\n归档成功：路径%@",filePath);
    }
    
    //解归档
    Person *unArchiverObj = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSLog(@"\n解归档成功: %@ %@",unArchiverObj,unArchiverObj.name);
    
}


- (void)customArchiverManagerClass {
    
    
    //归档
    [[LocalArchiver globalArchiver] saveObject:@"Eugene" forKey:@"name"];
    //解归档
    NSString *unArchiverObj = [[LocalArchiver globalArchiver] objectForKey:@"name"];
    NSLog(@"\n解归档成功: %@",unArchiverObj);
    
    
    NSArray *archiverAry = @[
                             @{@"Eugene" : @"ZhangYanJin"},
                             @{@"Chana" : @"LiChang"}
                             ];
    //归档
    [[LocalArchiver globalArchiver] saveObject:archiverAry forKey:@"personInfo"];
    //解归档
    NSArray *unArchiver = [[LocalArchiver globalArchiver] objectForKey:@"personInfo"];
    NSLog(@"\n解归档成功: %@",unArchiver);
    
    //[[LocalArchiver globalArchiver] removeArchiverForKey:@"personInfo"];

    
//    Person *person = [[Person alloc] init];
//    person.name = @"Eugene";
//    person.sex = @"man";
//    person.age = 25;
//    person.height = 175;
//     //归档
//    [[LocalArchiver globalArchiver] saveObject:person forKey:@"personInfo"];
//    //解归档
//    Person *unArchiverObj = [[LocalArchiver globalArchiver] objectForKey:@"personInfo"];
//    NSLog(@"\n解归档成功: %@ %@",unArchiverObj,unArchiverObj.name);
    
}


- (NSString *)filePathWithName:(NSString *)name {

    name = [[NSString alloc] initWithFormat:@"%@.archiver",name];
    
    //归档后的文件是加密的，所以归档文件的扩展名可以随意取,我这里后缀用archiver
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:name];
}



@end
