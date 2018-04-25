//
//  SJAxisView.h
//  SJChartViewDemo
//
//  Created by Jaesun on 16/9/6.
//  Copyright © 2016年 S.J. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJAxisView : UIView

/**
 *  Y轴刻度标签
 */
@property (nonatomic, strong) NSArray *yMarkTitles;
/**
 *  X轴刻度标签
 */
@property (nonatomic, strong) NSArray *xMarkTitles;

/**
 *  与x轴平行的网格线的间距
 */
@property (nonatomic, assign) CGFloat xScaleMarkLEN;

/**
 *  网格线的起始点
 */
@property (nonatomic, assign) CGPoint startPoint;

/**
 *  x 轴长度
 */
@property (nonatomic, assign) CGFloat yAxis_L;
/**
 *  y 轴长度
 */
@property (nonatomic, assign) CGFloat xAxis_L;


//最大值
@property (nonatomic, assign) CGFloat maxValue;

//最小值
@property (nonatomic, assign) CGFloat mixValue;


/**
 *  画虚线
 */
@property (nonatomic, strong) NSArray *linArray;

/**
 *  是否有虚线
 *
 *  @return <#return value description#>
 */
@property (nonatomic, assign) BOOL isDotte;


@property (nonatomic, assign) BOOL isKey;

@property (nonatomic, assign) BOOL isHome;



/**
 *  绘图
 */
- (void)mapping;
/**
 *  更新做标注数据
 */
- (void)reloadDatas;
@end
