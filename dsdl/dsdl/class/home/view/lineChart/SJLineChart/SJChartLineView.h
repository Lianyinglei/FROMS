//
//  SJChartLineView.h
//  SJChartViewDemo
//
//  Created by Jaesun on 16/9/9.
//  Copyright © 2016年 S.J. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SJAxisView.h"

typedef void (^SJChartLineViewBlock)(NSArray *strAry ,NSInteger index);
@interface SJChartLineView : SJAxisView

@property (nonatomic, copy)SJChartLineViewBlock lineBlock;

@property (nonatomic, strong) NSArray *valueArray;



@property (nonatomic, strong) NSArray *valueArray2;

@property (nonatomic, strong) NSArray *valueArray3;

@property (nonatomic, strong) NSArray *valueArrayMax;

@property (nonatomic, assign) BOOL isCurve;



/**
 *  绘图
 */
- (void)mapping;

/**
 *  更新折线图数据
 */
- (void)reloadDatas;

@end

