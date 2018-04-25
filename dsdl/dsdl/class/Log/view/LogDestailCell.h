//
//  LogDestailCell.h
//  dsdl
//
//  Created by 廉英雷 on 16/11/28.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LogFrameModel;
@interface LogDestailCell : UITableViewCell

@property (nonatomic, strong) LogFrameModel *logFrame;

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
 *  执行说明
 */
@property (nonatomic, weak) UILabel *performLab;

@property (nonatomic, weak) UILabel *performLabR;


/**
 *  顺延
 */
@property (nonatomic,weak) UILabel *postLab;
@property (nonatomic,weak) UILabel *postLabR;



/**
 *  顺延原因
 */
@property (nonatomic, weak) UILabel *pWhyLab;
@property (nonatomic, weak) UILabel *pWhyLabR;

/**
 *  cell底部的颜色条
 */
@property (nonatomic, weak) UIView *colorView;
@end
