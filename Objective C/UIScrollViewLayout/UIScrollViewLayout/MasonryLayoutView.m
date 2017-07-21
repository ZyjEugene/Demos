//
//  MasonryLayoutView.m
//  UIScrollViewLayout
//
//  Created by tongqu on 2017/7/13.
//  Copyright © 2017年 Eugene Space. All rights reserved.

/** UIScrollView 在自动布局中，所有的间距类约束，并非相对于父视图本身的，而是相对于父视图的内容视图的（eg, UIScrollView的contentSize），由于一般的UIView的内容视图与自身的大小一样，所以可以当做是相对于它自身，而UIScrollView在加载时，会根据内部子视图计算contentSize的值。
 */
#import "MasonryLayoutView.h"
#import "Masonry.h"

@interface MasonryLayoutView ()


@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation MasonryLayoutView
{
    //定义autoLayout6 方法中的变量
    UIImageView *imageView;
    UILabel *alertlabel;
    UIImageView *headerImageView;
    UIButton *sureButton;
    UIButton *cancelButton;
    
    UIScrollView *myScrollView;
    UIView *layoutView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //[self autoLayout1];
    [self autoLayout2];
    //[self autoLayout3];
    //[self autoLayout4];
    //[self autoLayout5];
    //[self autoLayout6];
    // Do any additional setup after loading the view.
}

//- (void)autoLayout1 {
//    
//    CGFloat height = ([UIScreen mainScreen].bounds.size.height - 30) / 2;
//    
//    // ----垂直方向的滚动视图----
//
//    UIScrollView *verticalScrollView = [UIScrollView new];
//    verticalScrollView.pagingEnabled = YES;
//    [self.view addSubview:verticalScrollView];
//    // 设置scrollView在父视图上的约束
//    [verticalScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.mas_equalTo(10);
//        make.right.mas_equalTo(-10);
//        make.height.mas_equalTo(height);
//    }];
//    
//    // 设置scrollView的子视图，即过渡视图ContentSize，并设置其约束
//    UIView *verticalContainerView = [UIView new];
//    [verticalScrollView addSubview:verticalContainerView];
//    [verticalContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.bottom.right.equalTo(verticalScrollView);//.insets(UIEdgeInsetsZero);
//        make.width.equalTo(verticalScrollView);//因为视图时垂直方向滚动，所以要确定容器视图的width
//    }];
//    
//    // 过渡视图添加到子视图
//    UIView *lastView = nil;
//    for (NSInteger i = 0; i < 6; i++) {
//        UILabel *label = [UILabel new];
//        label.text = [NSString stringWithFormat:@"垂直方向 第 %ld 视图",i];
//        label.backgroundColor = [self randomColor];
//        label.textAlignment = NSTextAlignmentCenter;
//        [verticalContainerView addSubview:label];
//        
//        [label mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.equalTo(verticalContainerView);
//            make.height.mas_equalTo(verticalScrollView.mas_height);//要以scrollview的height来确定label的height，否则不显示
//            if (lastView) {
//                make.top.mas_equalTo(lastView.mas_bottom);
//            } else {
//                make.top.mas_equalTo(0);
//            }
//        }];
//        
//        lastView = label;
//    }
//   
//    // 过渡视图添加的底边距，（它将影响到scrollView的contentSize）
//    [verticalContainerView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(lastView.mas_bottom);
//    }];
//
//    // ---- 水平方向的滚动视图----
//    UIScrollView *horizontalScrollView = [[UIScrollView alloc] init];
//    horizontalScrollView.pagingEnabled = YES;
//    horizontalScrollView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:horizontalScrollView];
//    
//    // 设置scrollView在父视图上的约束
//    [horizontalScrollView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(verticalScrollView.mas_bottom).offset(10);
//        make.left.right.equalTo(verticalScrollView);
//        make.bottom.mas_equalTo(-10);
//    }];
//    
//    // 设置scrollView的子视图，即过渡视图ContentSize，并设置其约束
//    UIView *horizontalContainerView = [UIView new];
//    [horizontalScrollView addSubview:horizontalContainerView];
//    [horizontalContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(horizontalScrollView);
//        make.height.equalTo(horizontalScrollView);
//    }];
//    // 过渡视图添加到子视图
//    UIView *previousView = nil;
//    for (NSInteger j = 0; j < 6; j++) {
//        UILabel *label = [UILabel new];
//        label.text = [NSString stringWithFormat:@"水平方向 第 %ld 视图",j];
//        label.backgroundColor = [self randomColor];
//        label.textAlignment = NSTextAlignmentCenter;
//        [horizontalContainerView addSubview:label];
//        
//        [label mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.bottom.equalTo(horizontalContainerView);//horizontalContainerView的高度已经固定，不需要再约束高
//            make.width.equalTo(horizontalScrollView);//要以scrollview的width来确定label的width，否则不显示
//            
//            if (previousView) {
//                make.left.mas_equalTo(previousView.mas_right);
//            } else {
//                make.left.mas_equalTo(0);
//            }
//        }];
//        previousView = label;
//    }
//    
//    // 过渡视图添加的右边距，（它将影响到scrollView的contentSize）
//    [horizontalScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(previousView.mas_right);
//    }];
//}
//}

- (void)autoLayout2 {
   
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    UILabel *lastLabel = nil;
    for (NSInteger index = 0 ; index < 6; index++) {
        UILabel *label = [[UILabel alloc] init];
        label.text = [self randomText];
        label.backgroundColor = [UIColor redColor];
        // 多行显示时设置
        label.numberOfLines = 0;
        label.preferredMaxLayoutWidth = screenWidth - 30;
        [label setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [scrollView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            //make.left.mas_equalTo(15);
            make.left.mas_equalTo(self.view.mas_left).offset(15);
            make.right.mas_equalTo(self.view).offset(-15);
            
            if (lastLabel) {
                make.top.mas_equalTo(lastLabel.mas_bottom).offset(10);
            } else {
                make.top.mas_equalTo(0);
                //make.top.mas_equalTo(self.scrollView).offset(20);
            }
        }];
        
        lastLabel = label;
    }
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        //让scrollView的ContentSize随着内容的增多而变化
        make.bottom.mas_equalTo(lastLabel.mas_bottom).offset(20);
    }];
    
    
}

/////竖屏滑动
//- (void)autoLayout3 {
//    
//    self.scrollView = [UIScrollView new];
//    UIView *redView = [UIView new];
//    redView.backgroundColor = [UIColor redColor];
//    
//    UIView *yellowView = [UIView new];
//    yellowView.backgroundColor = [UIColor yellowColor];
//    
//    UIView *view = [UIView new];
//    view.backgroundColor = [UIColor orangeColor];
//    
//  
//    // ----add sub view to super view----
//    [self.view addSubview:self.scrollView];
//    [self.scrollView addSubview:redView];
//    [self.scrollView addSubview:yellowView];
//    [self.scrollView addSubview:view];
//    
//    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
//    }];
//    
//    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.scrollView.mas_top).offset(20);
//        make.left.equalTo(self.scrollView.mas_left);
//        make.width.height.equalTo(self.view);
//    }];
//    
//    [yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(redView.mas_bottom).offset(10);
//        make.left.right.equalTo(redView);
//        make.height.equalTo(redView);
//    }];
//    
//    [view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(yellowView.mas_bottom).offset(10);
//        make.left.equalTo(yellowView.mas_left).offset(60);
//        make.right.equalTo(yellowView.mas_right).offset(-60);
//        make.height.mas_equalTo(40);
//    }];
//    
//    [self.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(view.mas_bottom).offset(20).priorityLow();
//        make.bottom.greaterThanOrEqualTo(self.view);
//    }];
//
//}
//
/////横屏滑动
//- (void)autoLayout4 {
//    
//    self.scrollView = [UIScrollView new];
//    UIView *redView = [UIView new];
//    redView.backgroundColor = [UIColor redColor];
//    
//    UIView *yellowView = [UIView new];
//    yellowView.backgroundColor = [UIColor yellowColor];
//    
//    // ----add sub view to super view----
//    [self.view addSubview:self.scrollView];
//    [self.scrollView addSubview:redView];
//    [self.scrollView addSubview:yellowView];
//    
//    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
//        make.right.equalTo(yellowView.mas_right);
//    }];
//    
//    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.equalTo(self.view);
//        make.left.equalTo(self.scrollView);
//        make.width.equalTo(self.view.mas_width);
//    }];
//    
//    [yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.equalTo(self.view);
//        make.left.equalTo(redView.mas_right);
//        make.width.equalTo(self.view.mas_width);
//    }];
//    
//}
//
/////将需要布局的视图作为一个底部view的子视图在UIScrollView上布局。竖屏滑动
//- (void)autoLayout5 {
//    
//    self.scrollView = [UIScrollView new];
//    UIView *redView = [UIView new];
//    redView.backgroundColor = [UIColor redColor];
//    
//    UIView *yellowView = [UIView new];
//    yellowView.backgroundColor = [UIColor yellowColor];
//    
//    UIView *bgView = [UIView new];
//    bgView.backgroundColor = [UIColor purpleColor];
//    
//    // ----add sub view to super view----
//    [self.view addSubview:self.scrollView];
//    [self.scrollView addSubview:bgView];
//    [bgView addSubview:redView];
//    [bgView addSubview:yellowView];
//    
//    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
//    }];
//    
//    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.mas_equalTo(0);
//        make.width.equalTo(self.view);
//        make.bottom.equalTo(yellowView.mas_bottom).offset(20);
//    }];
//    
//    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(bgView.mas_top).offset(20);
//        make.left.equalTo(bgView.mas_left).offset(0);
//        make.width.height.equalTo(self.view);
//    }];
//    
//    [yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(redView.mas_bottom).offset(10);
//        make.left.equalTo(redView.mas_left);
//        make.width.height.equalTo(redView);
//    }];
//    
//    [self.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(yellowView.mas_bottom).priorityLow();
//        make.bottom.mas_greaterThanOrEqualTo(self.view);
//    }];
//
//}
//
/////将需要布局的视图作为一个底部view的子视图在UIScrollView上布局。竖屏滑动
//- (void)autoLayout6 {
//    
//    [self initView];
//    [self configView];
//}
//
///** 布局 */
//- (void)initView {
//    
//    myScrollView = [UIScrollView new];
//    myScrollView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:myScrollView];
//    
//    layoutView = [UIView new];
//    layoutView.backgroundColor = [UIColor whiteColor];
//    [myScrollView addSubview:layoutView];
//    
//    
//    imageView = [UIImageView new];
//    imageView.image = [UIImage imageNamed:@"success"];
//    [layoutView addSubview:imageView];
//    
//    alertlabel = [UILabel new];
//    alertlabel.preferredMaxLayoutWidth = 374 - 30;
//    alertlabel.numberOfLines = 0;
//    alertlabel.text = @"您已经成功的修改手机号！";
//    alertlabel.font = [UIFont systemFontOfSize:14.0f];
//    alertlabel.textAlignment = NSTextAlignmentCenter;
//    [layoutView addSubview:alertlabel];
//    
//    headerImageView = [UIImageView new];
//    headerImageView.image = [UIImage imageNamed:@"setting-hf"];
//    [layoutView addSubview:headerImageView];
//    
//    sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    sureButton.backgroundColor = [UIColor colorWithRed:0 green:160.0f/255 blue:223.0f/255 alpha:1.0f];
//    [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
//    [layoutView addSubview:sureButton];
//    
//    cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    cancelButton.layer.borderWidth = 1.0f;
//    cancelButton.layer.borderColor = [UIColor colorWithRed:0 green:160.0f/255 blue:223.0f/255 alpha:1.0f].CGColor;
//    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
//    [cancelButton setTitleColor:[UIColor colorWithRed:0 green:160.0f/255 blue:223.0f/255 alpha:1.0f] forState:UIControlStateNormal];
//    [layoutView addSubview:cancelButton];
//}
//
//- (void)configView {
//    
//    [myScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
//    }];
//    
//    
//    [layoutView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.mas_equalTo(0);
//        make.width.mas_equalTo(self.view);
//        make.bottom.equalTo(cancelButton.mas_bottom).offset(20);
//    }];
//    
//    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.equalTo(layoutView).offset(60);
//        make.centerX.equalTo(myScrollView);
//        make.width.mas_equalTo(@60);
//        make.height.mas_equalTo(@60);
//    }];
//    
//    [alertlabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.equalTo(imageView.mas_bottom).offset(80);
//        make.left.equalTo(layoutView).offset(15);
//        make.right.equalTo(layoutView).offset(-15);
//    }];
//    
//    [headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.equalTo(alertlabel.mas_bottom).offset(70);
//        make.centerX.equalTo(myScrollView);
//        make.width.mas_equalTo(@277);
//        make.height.mas_equalTo(@165);
//    }];
//    
//    [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.equalTo(headerImageView.mas_bottom).offset(60);
//        make.left.equalTo(layoutView).offset(15);
//        make.right.equalTo(layoutView).offset(-15);
//        make.height.mas_equalTo(@40);
//    }];
//    
//    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.equalTo(sureButton.mas_bottom).offset(160);
//        make.left.equalTo(sureButton);
//        make.right.equalTo(sureButton);
//        make.height.mas_equalTo(@40);
//    }];
//    
//    [myScrollView mas_updateConstraints:^(MASConstraintMaker *make) {
//        
//        make.bottom.mas_equalTo(layoutView.mas_bottom).priorityLow();
//        make.bottom.mas_greaterThanOrEqualTo(self.view);
//    }];
//}

- (UIColor *)randomColor {
    return [UIColor colorWithHue:((arc4random() % 100 + 200 )/ 256.0) saturation:((arc4random() % 100 + 200 ) / 256.0) brightness:((arc4random() % 100 + 200 ) / 256.0) alpha:1];
}

- (NSString *)randomText {
    
    NSArray *textAry = @[@"Eugene Test Data",@"UIScrollView自动布局学习",@"这是Eugene学习的测试数据"];
    CGFloat length = arc4random() % 50 + 5;
    
    NSMutableString *str = [[NSMutableString alloc] init];
    for (NSUInteger i = 0; i < length; ++i) {
        NSString *tempStr = textAry[arc4random() % 2];
        [str appendString:tempStr];
    }
    
    return str;
}
@end
