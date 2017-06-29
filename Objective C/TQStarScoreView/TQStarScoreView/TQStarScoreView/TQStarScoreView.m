//
//  TQStarScoreView.m
//  TQStarScoreView
//
//  Created by tongqu on 2017/6/26.
//  Copyright © 2017年 Eugene Space. All rights reserved.
//
#define TQSelectedStar @"star_selected"
#define TQUnselectedStar @"star_unselected"

#import "TQStarScoreView.h"

typedef void(^TQCompleteBlock) (CGFloat currentScore);

@interface TQStarScoreView ()

@property (nonatomic, strong) UIView *foreStarView;//评分视图

@property (nonatomic, assign) NSInteger starCount;
@property (nonatomic, copy) TQCompleteBlock complete;

@end

@implementation TQStarScoreView

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame finish:(TQFinishBlock)finish {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _starCount = 5;
        _rateStyle = TQRateStyleDefault;
        _complete = ^(CGFloat currentScore) {
            finish(currentScore);
        };
        
        [self initStarScoreView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
                    starCount:(NSInteger)stars
                    rateStyle:(TQRateStyle)style
                       finish:(TQFinishBlock)finish {
    self = [super initWithFrame:frame];
    if (self) {
        
        _starCount = stars;
        _rateStyle = style;
        _complete = ^(CGFloat currentScore) {
            finish(currentScore);
        };
        
        [self initStarScoreView];
    }
    return self;
}

- (void)layoutSubviews {

    [super layoutSubviews];
    
    [UIView animateWithDuration:0.15 animations:^{
        self.foreStarView.frame = \
        CGRectMake(0, 0,
                   self.bounds.size.width \
                   * (self.currentScore / self.starCount),
                   self.bounds.size.height);
    }];
    
}

#pragma mark - private method
- (void)initStarScoreView {
    
    {//底部创建表示未选择状态下的imageView
        for (NSInteger i = 0; i < self.starCount; i ++)
        {
            UIImageView *itemImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:TQUnselectedStar]];
            itemImageView.frame = CGRectMake(i * self.bounds.size.width / self.starCount,
                                         0,
                                         self.bounds.size.width / self.starCount,
                                         self.bounds.size.height);
            itemImageView.contentMode = UIViewContentModeScaleAspectFit;
            [self addSubview:itemImageView];
        }
    }
    
    {//创建表示选择状态下的imageView
        for (NSInteger i = 0; i < self.starCount; i ++)
        {
            UIImageView *itemImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:TQSelectedStar]];
            itemImageView.frame = CGRectMake(i * self.bounds.size.width / self.starCount,
                                             0,
                                             self.bounds.size.width / self.starCount,
                                             self.bounds.size.height);
            itemImageView.contentMode = UIViewContentModeScaleAspectFit;
            [self.foreStarView addSubview:itemImageView];
        }
        [self addSubview:self.foreStarView];
    }
    
}

#pragma mark - move
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self calculateStarDisplayLocationWithTouches:touches];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self calculateStarDisplayLocationWithTouches:touches];
}

- (void)calculateStarDisplayLocationWithTouches:(NSSet<UITouch *> *)touches {

    if (self.isLockDisplay) {
        return;
    }
    
    //round() / roundf() / roundl() ----四舍五入
    //ceil() / ceilf() / ceill() ----向上取整
    
    CGPoint point = [[touches anyObject] locationInView:self];
    CGFloat realStarScore = point.x / (self.bounds.size.width / _starCount);
    switch (_rateStyle) {
        case TQRateStyleDefault: {
         
            self.currentScore = realStarScore;
            break;
        }
        case TQRateStyleWholeStar: {
            
            self.currentScore = ceilf(realStarScore);
            break;
        }
        case TQRateStyleHalfStar: {
            
            self.currentScore = \
            roundf(realStarScore) > realStarScore ? \
            ceilf(realStarScore) : (ceilf(realStarScore) - 0.5);
            
            break;
        }
    }
}

#pragma mark - setter
- (void)setCurrentScore:(CGFloat)currentScore {
    
    NSLog(@"currentScore:%f",currentScore);
    
    if (_currentScore == currentScore) {
        return;
    }
    
    if (currentScore < 0) {
        _currentScore = 0;
    } else if (currentScore > _starCount){
        _currentScore = _starCount;
    } else {
        _currentScore = currentScore;
    }
    
    if (self.complete) {
        _complete(_currentScore);
    }
    
    [self setNeedsLayout];
}

#pragma mark - lazy
- (UIView *)foreStarView {
    
    if (_foreStarView == nil) {
        _foreStarView = [[UIView alloc] initWithFrame:self.bounds];
        _foreStarView.clipsToBounds = YES;
    }
    return _foreStarView;
}

@end
