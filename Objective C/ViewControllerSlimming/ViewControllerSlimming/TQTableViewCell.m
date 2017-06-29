//
//  TQTableViewCell.m
//  ViewControllerSlimming
//
//  Created by tongqu on 2017/6/27.
//  Copyright © 2017年 Eugene Space. All rights reserved.
//

#import "TQTableViewCell.h"
#import "TQModel.h"

@implementation TQTableViewCell


- (void)configureWithInfo:(id)info {

    if ([info isKindOfClass:[TQModel class]]) {
        TQModel *model = info;
        self.textLabel.text = [NSString stringWithFormat:@"Developer ：%@",model.name];
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
        self.textLabel.textColor = [UIColor redColor];
    } else {
        self.textLabel.textColor = [UIColor blackColor];
    }
    // Configure the view for the selected state
}

@end
