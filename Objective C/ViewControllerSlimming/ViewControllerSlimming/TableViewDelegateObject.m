//
//  TableViewDelegateObject.m
//  DelegateObject
//
//  Created by tongqu on 2017/5/26.
//  Copyright © 2017年 Eugene Space. All rights reserved.
//

#import "TableViewDelegateObject.h"

@interface TableViewDelegateObject ()

@property (nonatomic, copy) didSelectedCell selectBlock;

@end
@implementation TableViewDelegateObject

+ (instancetype)creatTableViewDelegateCellDidSelectedBlock:(didSelectedCell)selectBlock {
    
    return [[[self class] alloc] initTableViewDelegateCellDidSelectedBlock:selectBlock];
}

- (instancetype)initTableViewDelegateCellDidSelectedBlock:(didSelectedCell)selectBlock {
    
    self = [super init];
    if (self) {
        self.selectBlock = selectBlock;
    }
    return self;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //[tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    // 将点击事件通过block的方式传递出去
    if (self.selectBlock) {
        self.selectBlock(indexPath);
    }
}

@end
