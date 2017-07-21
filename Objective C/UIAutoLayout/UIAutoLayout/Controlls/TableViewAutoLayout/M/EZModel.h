//
//  EZModel.h
//  UIAutoLayout
//
//  Created by tongqu on 2017/7/14.
//  Copyright © 2017年 Eugene Space. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EZModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, assign) int uid;
@property (nonatomic, assign) BOOL isExpand;

@end
