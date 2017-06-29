//
//  TableViewDataSourceObject.h
//  ViewControllerSlimming
//
//  Created by tongqu on 2017/6/27.
//  Copyright © 2017年 Eugene Space. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^CellConfigureBlock) (id cell, id item);
@interface TableViewDataSourceObject : NSObject <UITableViewDataSource>


/**
 *  创建代理对象实例，并将数据列表传进去
 *  代理对象将消息传递出去，是通过block的方式向外传递消息的
 *  @return 返回实例对象
 */
+ (instancetype)createTableViewDataSourceWithDataList:(NSArray *)dataList
                                    cellIdentifier:(NSString *)identifier
                                cellConfigureBlock:(CellConfigureBlock)configureBlock;

@end
