//
//  ViewController.m
//  ViewControllerSlimming
//
//  Created by tongqu on 2017/6/27.
//  Copyright © 2017年 Eugene Space. All rights reserved.
//

#import "ViewController.h"
#import "TQTableViewCell.h"
#import "TQModel.h"

#import "TableViewDelegateObject.h"
#import "TableViewDataSourceObject.h"

@interface ViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *array;


@property (nonatomic, strong) TableViewDelegateObject *delegateObject;
@property (nonatomic, strong) TableViewDataSourceObject *dataSourceObject;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.dataSourceObject = [TableViewDataSourceObject \
                             createTableViewDataSourceWithDataList:[self models] \
                             cellIdentifier:@"cellIdentifier"\
                             cellConfigureBlock:^(TQTableViewCell *cell, TQModel *item) \
                             {
                              [cell configureWithInfo:item];
                             }];

    __weak typeof(self) weakSelf = self;
    self.delegateObject = [TableViewDelegateObject \
                           creatTableViewDelegateCellDidSelectedBlock:^(NSIndexPath *indexPath)\
                           {
        TQModel *model = [[weakSelf models] objectAtIndex:indexPath.row];
        NSLog(@"%ld.%@",indexPath.row,model.name);
        
    }];
    [self.view addSubview:self.tableView];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSArray<TQModel *> *)models {
    
    NSArray *dataList = @[
                          @{@"name":@"Eugene"},
                          @{@"name":@"ZyjEugene"},
                          @{@"name":@"Eugene Space"}
                          ];
    
    NSMutableArray *dataAry = [NSMutableArray new];
    [dataList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dict = dataList[idx];
        TQModel *model = [[TQModel alloc] init];
        model.name = [dict objectForKey:@"name"];
        [dataAry addObject:model];
    }];
    
    return [dataAry copy];
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
        _tableView.frame = self.view.frame;
        _tableView.delegate = self.delegateObject;
        _tableView.dataSource = self.dataSourceObject;
        [_tableView registerClass:[TQTableViewCell class] forCellReuseIdentifier:@"cellIdentifier"];
    }
    return _tableView;
}

@end
