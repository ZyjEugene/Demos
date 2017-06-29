//
//  TableViewDelegateObject.h
//  DelegateObject
//
//  Created by tongqu on 2017/5/26.
//  Copyright © 2017年 Eugene Space. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//点击cell的事件，block传递出去
typedef void (^didSelectedCell)(NSIndexPath *indexPath);


//  代理对象(UITableView的协议需要声明在.h文件中，不然外界在使用的时候会报黄色警告，看起来不太舒服)
@interface TableViewDelegateObject : NSObject <UITableViewDelegate, UITableViewDataSource>


/**
 *  创建代理对象实例，并将数据列表传进去
 *  代理对象将消息传递出去，是通过block的方式向外传递消息的
 *  @return 返回实例对象
 */
+ (instancetype)createTableViewDelegateWithDataList:(NSArray <NSString *> *)dataList
                                        didSelectedBlock:(didSelectedCell)didSelectedBlock;

 
@end
