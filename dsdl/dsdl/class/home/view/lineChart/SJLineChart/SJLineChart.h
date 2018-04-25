//
//  SJLineChart.h
//  SJChartViewDemo
//
//  Created by Jaesun on 16/9/9.
//  Copyright © 2016年 S.J. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SJLineChartBlock)(NSArray *strAry,NSInteger index);
@interface SJLineChart : UIView

@property (nonatomic, copy) SJLineChartBlock lineChartBlock;

/**
 *  表名
 */
@property (nonatomic, strong) NSString *title;

/**
 *  Y轴刻度标签title
 */
@property (nonatomic, strong) NSArray *yMarkTitles;

/**
 *  Y轴最大值
 */
@property (nonatomic, assign) CGFloat maxValue;

@property (nonatomic, assign) CGFloat mixValue;

/**
 *  X轴刻度标签的长度（单位长度）
 */
@property (nonatomic, assign) CGFloat xScaleMarkLEN;

/**
 *  警戒线数组
 */
@property (nonatomic, strong) NSArray *lineArray;

/**
 *  是否为曲线
 *
 *  @param 如:80 <#如:80 description#>
 *
 *  @return <#return value description#>
 */
@property (nonatomic, assign) BOOL isCurve;

@property (nonatomic, assign) BOOL isDotte;

@property (nonatomic, strong) NSArray *dataAry;


/**
 *  是否在关键指标页面
 */
@property (nonatomic, assign) BOOL isKey;

//是否是主界面
@property (nonatomic, assign) BOOL isHome;


/**
 *  设置折线图显示的数据和对应X坐标轴刻度标签
 *
 *  @param xMarkTitlesAndValues 折线图显示的数据和X坐标轴刻度标签
 *  @param titleKey             标签（如:9月1日）
 *  @param valueKey             数据 (如:80)
 */

@property (nonatomic, strong) UIColor *leftColor;


@property (nonatomic, strong) NSMutableArray *valueArray1;

/**
 *  数据源，第二条上的数据
 */
@property (nonatomic, strong) NSArray *valueArray2;

/**
 *  x轴上的刻度title
 */

@property (nonatomic, strong) NSMutableArray *xMarkArray;

/**
 *  第三条上的数据
 */

@property (nonatomic, strong) NSArray *valueArray3;


- (void)setXMarkTitlesAndValues:(NSArray *)xMarkTitlesAndValues titleKey:(NSString *)titleKey valueKey:(NSString *)valueKey;

- (void)mapping;

- (void)reloadDatas;


@end
