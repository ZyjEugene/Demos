//
//  ViewController.m
//  DelegateObject
//
//  Created by tongqu on 2017/5/26.
//  Copyright © 2017年 Eugene Space. All rights reserved.
/**
 控制器瘦身-----》代理对象
 
 我们将UITableView的delegate和DataSource单独拿出来，由一个代理对象类进行控制，只将必须控制器处理的逻辑传递给控制器处理。
 UITableView的数据处理、展示逻辑和简单的逻辑交互都由代理对象去处理，和控制器相关的逻辑处理传递出来，交由控制器来处理，这样控制器的工作少了很多，而且耦合度也大大降低了。这样一来，我们只需要将需要处理的工作交由代理对象处理，并传入一些参数即可。
 
 
 在控制器中创建一个代理对象类，并将UITableView的delegate和dataSource都交给代理对象去处理，让代理对象成为UITableView的代理，来解决控制器臃肿以及和UITableView的解藕
 */

#import "ViewController.h"
#import "TableViewDelegateObject.h"

@interface ViewController () 

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) TableViewDelegateObject *delegateObject;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *dataList = @[@"Eugene", @"ZyjEugene", @"Eugene Space"];
    
    self.delegateObject = [TableViewDelegateObject createTableViewDelegateWithDataList:dataList didSelectedBlock:^(NSIndexPath *indexPath) {
        NSLog(@"%@",dataList[indexPath.row]);
    }];
    [self.view addSubview:self.tableView];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
        _tableView.frame = self.view.frame;
        _tableView.backgroundColor = [UIColor redColor];
        _tableView.delegate = self.delegateObject;
        _tableView.dataSource = self.delegateObject;
    }
    return _tableView;
}

@end
