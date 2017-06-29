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
@interface TableViewDelegateObject : NSObject <UITableViewDelegate>


+ (instancetype)creatTableViewDelegateCellDidSelectedBlock:(didSelectedCell)selectBlock;

@end
