//
//  TableViewDelegateObject.m
//  DelegateObject
//
//  Created by tongqu on 2017/5/26.
//  Copyright © 2017年 Eugene Space. All rights reserved.
//

#import "TableViewDelegateObject.h"

@interface TableViewDelegateObject ()

@property (nonatomic, strong) NSArray *dataList;
@property (nonatomic, copy) didSelectedCell selectBlock;

@end
@implementation TableViewDelegateObject

+ (instancetype)createTableViewDelegateWithDataList:(NSArray <NSString *> *)dataList didSelectedBlock:(didSelectedCell)didSelectedBlock {
    return [[[self class] alloc] initTableViewDelegateWithDataList:dataList didSelectedBlock:didSelectedBlock];
}

- (instancetype)initTableViewDelegateWithDataList:(NSArray <NSString *> *)dataList didSelectedBlock:(didSelectedCell)didSelectedBlock {
    self = [super init];
    if (self) {
        self.dataList = dataList;
        self.selectBlock = didSelectedBlock;
    }
    return self;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.dataList[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    // 将点击事件通过block的方式传递出去
    self.selectBlock(indexPath);
}

@end
