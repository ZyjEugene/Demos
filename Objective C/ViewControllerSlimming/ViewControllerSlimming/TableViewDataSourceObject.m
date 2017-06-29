//
//  TableViewDataSourceObject.m
//  ViewControllerSlimming
//
//  Created by tongqu on 2017/6/27.
//  Copyright © 2017年 Eugene Space. All rights reserved.
//

#import "TableViewDataSourceObject.h"

@interface TableViewDataSourceObject ()

@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) CellConfigureBlock configureBlock;
@end

@implementation TableViewDataSourceObject

+ (instancetype)createTableViewDataSourceWithDataList:(NSArray *)dataList
                                     cellIdentifier:(NSString *)identifier
                                   cellConfigureBlock:(CellConfigureBlock)configureBlock {
    return [[[self class] alloc] initTableViewDataSourceWithDataList:dataList
                                                    cellIdentifier:identifier
                                                  cellConfigureBlock:configureBlock];
}

- (instancetype)initTableViewDataSourceWithDataList:(NSArray *)dataList
                                   cellIdentifier:(NSString *)identifier
                                 cellConfigureBlock:(CellConfigureBlock)configureBlock {
    self = [super init];
    if (self) {
        self.dataList = [dataList mutableCopy];
        self.cellIdentifier = identifier;
        self.configureBlock = configureBlock;
    }
    return self;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    
    id item = self.dataList[indexPath.row];
    
    self.configureBlock(cell, item);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.dataList removeObjectAtIndex:indexPath.row];
    [tableView reloadData];
}


@end
