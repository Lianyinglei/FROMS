//
//  LogDestailLeftCell.h
//  dsdl
//
//  Created by 廉英雷 on 16/12/9.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LogDestailLeftModel;
@interface LogDestailLeftCell : UITableViewCell


@property (nonatomic, strong) LogDestailLeftModel *logFrame;
/**
 *  编码
 */
@property (nonatomic, weak) UILabel *numLab;

@property (nonatomic, weak) UILabel *numLabR;




/**
 *  描述内容
 */
@property (nonatomic, weak) UILabel *describeLab;

@property (nonatomic, weak) UILabel *describeLabR;

/**
 *  cell底部的颜色条
 */
@property (nonatomic, weak) UIView *colorView;
@end
