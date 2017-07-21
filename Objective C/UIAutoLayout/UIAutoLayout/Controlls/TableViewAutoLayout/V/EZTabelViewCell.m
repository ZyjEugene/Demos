//
//  EZTabelViewCell.m
//  UIAutoLayout
//
//  Created by tongqu on 2017/7/14.
//  Copyright © 2017年 Eugene Space. All rights reserved.
//

#import "EZTabelViewCell.h"
#import "EZModel.h"
#import "Masonry.h"
@interface EZTabelViewCell ()
@property (nonatomic, strong) UILabel *mainLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIImageView * headerImage;
@property (nonatomic, strong) UILabel * nickName;
@property (nonatomic, strong) UILabel * timeLab;
@property (nonatomic, strong) UIButton * collect;
@property (nonatomic, strong) UIButton * comment;
@property (nonatomic, strong) UIButton * like;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, assign) BOOL isExpandedNow;
@end

@implementation EZTabelViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initCellView];
    }
    
    return self;
}

- (void)initCellView {
    
    // ----用户信息----
    {
        self.headerImage = [[UIImageView alloc]init];
        self.headerImage.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.headerImage];
        
        [self.headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.left.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
        
        self.nickName = [[UILabel alloc]init];
        self.nickName.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.nickName];
        
        [self.nickName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.headerImage.mas_top).offset(5);
            make.left.mas_equalTo(self.headerImage.mas_right).offset(10);
            make.size.mas_equalTo(CGSizeMake(80, 20));
        }];
        
        self.timeLab = [[UILabel alloc]init];
        self.timeLab.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.timeLab];
        [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.nickName.mas_bottom).offset(5);
            make.left.mas_equalTo(self.headerImage.mas_right).offset(10);
            make.size.mas_equalTo(CGSizeMake(80, 15));
        }];

    }
    
    // ----标题 文本描述----
    {
        self.mainLabel = [[UILabel alloc] init];
        self.mainLabel.backgroundColor =[UIColor redColor];
        [self.contentView addSubview:self.mainLabel];
        [self.mainLabel sizeToFit];
        self.mainLabel.numberOfLines = 0;
        [self.mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.headerImage.mas_bottom).offset(15);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_lessThanOrEqualTo(80);
        }];
        CGFloat w = [UIScreen mainScreen].bounds.size.width;
        // 应该始终要加上这一句
        // 不然在6/6plus上就不准确了
        self.mainLabel.preferredMaxLayoutWidth = w - 20;
        [self.mainLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [self.mainLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        
        self.descLabel = [[UILabel alloc] init];
        self.descLabel.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:self.descLabel];
        self.descLabel.numberOfLines = 0;
        [self.descLabel sizeToFit];
        [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mainLabel.mas_bottom).offset(15);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
        }];
        // 应该始终要加上这一句
        // 不然在6/6plus上就不准确了
        // 原因：cell中的多行UILabel，如果其width不是固定的话（比如屏幕尺寸不同，width不同），要手动设置其preferredMaxLayoutWidth。 因为计算UILabel的intrinsicContentSize需要预先确定其width才行。
        self.descLabel.preferredMaxLayoutWidth = w - 20;
        [self.descLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        
        self.descLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(onTap)];
        [self.descLabel addGestureRecognizer:tap];
    }
    
    
    // ----底部3视图----
    {
        self.collect = [[UIButton alloc]init];
        self.collect.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.collect];
        [self.collect mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.descLabel.mas_bottom).offset(15);
            make.left.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(50, 20));
        }];
        self.comment = [[UIButton alloc]init];
        self.comment.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.comment];
        [self.comment mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.descLabel.mas_bottom).offset(15);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(50, 20));
        }];
        self.like = [[UIButton alloc]init];
        self.like.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.like];
        [self.like mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.descLabel.mas_bottom).offset(15);
            make.right.mas_equalTo(-10);
            make.size.mas_equalTo(CGSizeMake(50, 20));
        }];
 }
    

}

- (void)configCellWithModel:(EZModel *)model {
    
    self.mainLabel.text = model.title;
    self.descLabel.text = model.desc;
    
    if (model.isExpand != self.isExpandedNow) {
        self.isExpandedNow = model.isExpand;

        if (self.isExpandedNow) {
            [self.descLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.mainLabel.mas_bottom).offset(15);
                make.left.mas_equalTo(10);
                make.right.mas_equalTo(-10);
            }];
        } else {
            [self.descLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_lessThanOrEqualTo(80);
            }];
        }

    }
    
}

+ (CGFloat)cellHeightWithModel:(EZModel *)model {
    
    EZTabelViewCell *cell = [[EZTabelViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    [cell configCellWithModel:model];
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    CGRect bottomViewFrame = cell.like.frame;
    
    return bottomViewFrame.origin.y + bottomViewFrame.size.height + 20;
}

/** 手势传递文本目前的状态 展开和非展开 */
- (void)onTap {
    if (self.expandBlock) {
        self.expandBlock(!self.isExpandedNow);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
