//
//  ViewController.m
//  TQStarScoreView
//
//  Created by tongqu on 2017/6/26.
//  Copyright © 2017年 Eugene Space. All rights reserved.
//

#import "ViewController.h"
#import "TQStarScoreView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TQStarScoreView *starScoreView = [[TQStarScoreView alloc] initWithFrame:CGRectMake(100, 100, 200, 30) finish:^(CGFloat currentScore) {
        NSLog(@"%f",currentScore);
    }];
    starScoreView.currentScore = 2.6;
//    starScoreView.isLockDisplay = YES;
//    starScoreView.rateStyle = TQRateStyleWholeStar;
    [self.view addSubview:starScoreView];
    
    TQStarScoreView *starScoreView1 = [[TQStarScoreView alloc] initWithFrame:CGRectMake(100, 140, 200, 30) starCount:8 rateStyle:TQRateStyleHalfStar finish:^(CGFloat currentScore) {
        NSLog(@"%f",currentScore);
    }];
    starScoreView1.currentScore = 2.6;
    //    starScoreView.isLockDisplay = YES;
    starScoreView1.rateStyle = TQRateStyleHalfStar;
    [self.view addSubview:starScoreView1];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
