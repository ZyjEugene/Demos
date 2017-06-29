//
//  TQStarScoreView.h
//  TQStarScoreView
//
//  Created by tongqu on 2017/6/26.
//  Copyright © 2017年 Eugene Space. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TQFinishBlock) (CGFloat currentScore);
typedef NS_ENUM(NSInteger, TQRateStyle) {
    
    TQRateStyleDefault, //自由滑动星级评论，
    TQRateStyleWholeStar,//只能整星评论
    TQRateStyleHalfStar, //允许半星评论
};


@interface TQStarScoreView : UIView

@property (nonatomic, assign) BOOL isLockDisplay;//是否是展示评分状态（不可更改评分），默认NO
@property (nonatomic, assign) CGFloat currentScore;// 当前评分：0-5  默认0
@property (nonatomic, assign) TQRateStyle rateStyle;//评分样式.默认是WholeStar

- (instancetype)initWithFrame:(CGRect)frame finish:(TQFinishBlock)finish;
- (instancetype)initWithFrame:(CGRect)frame
                    starCount:(NSInteger)stars
                    rateStyle:(TQRateStyle)style
                       finish:(TQFinishBlock)finish;
@end
