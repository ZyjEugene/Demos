//
//  EZTabelViewCell.h
//  UIAutoLayout
//
//  Created by tongqu on 2017/7/14.
//  Copyright © 2017年 Eugene Space. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EZModel;

typedef void (^EZExpandBlock)(BOOL isExpand);
@interface EZTabelViewCell : UITableViewCell

@property (nonatomic, copy) EZExpandBlock expandBlock;

- (void)configCellWithModel:(EZModel *)model;

+ (CGFloat)cellHeightWithModel:(EZModel *)model;
@end
