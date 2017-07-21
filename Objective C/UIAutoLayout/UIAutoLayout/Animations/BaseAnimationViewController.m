//
//  BaseAnimationViewController.m
//  UIAutoLayout
//
//  Created by tongqu on 2017/7/14.
//  Copyright © 2017年 Eugene Space. All rights reserved.
//注释

#import "BaseAnimationViewController.h"
#import "Masonry.h"
@interface BaseAnimationViewController ()

@end

@implementation BaseAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self moveAnimation];
    
    [self scaleAnimation];
    
    // Do any additional setup after loading the view.
}

- (void)moveAnimation {
    
    UIButton *redView = [[UIButton alloc] init];
    redView.backgroundColor = [UIColor redColor];
    [redView setTitle:@"Move" forState:UIControlStateNormal];
    [redView addTarget:self action:@selector(moveAnimationAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:redView];
    
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(80);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
}


- (void)scaleAnimation {
    
    UIButton *orangeView = [[UIButton alloc] init];
    orangeView.backgroundColor = [UIColor orangeColor];
    [orangeView setTitle:@"Scale" forState:UIControlStateNormal];
    [orangeView addTarget:self action:@selector(scaleAinmationAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:orangeView];
    
    [orangeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(80);
        make.left.mas_equalTo(100);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
}

- (void)moveAnimationAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    [sender mas_updateConstraints:^(MASConstraintMaker *make) {
        if (sender.selected) {
            make.top.mas_equalTo(200);
        } else {
            make.top.mas_equalTo(80);
        }
    }];
    
    [UIView animateWithDuration:1 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)scaleAinmationAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    [sender mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (sender.selected) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(200);
        } else {
            make.top.mas_equalTo(80);
            make.left.mas_equalTo(80);
            make.size.mas_equalTo(CGSizeMake(60, 60));
        }
    }];
    
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    [UIView animateWithDuration:1 animations:^{
        [self.view layoutIfNeeded];
    }];
    
}
@end
