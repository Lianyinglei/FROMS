//
//  SJLineChart.m
//  SJChartViewDemo
//
//  Created by Jaesun on 16/9/9.
//  Copyright © 2016年 S.J. All rights reserved.
//

#import "SJLineChart.h"

#import "SJChartLineView.h"
#import "SJAxisView.h"

@interface SJLineChart() {
    
    NSMutableArray *xMarkTitles;
    NSMutableArray *valueArray;
    
}



/**
 *  表名标签
 */
@property (nonatomic, strong) UILabel *titleLab;

/**
 *  显示折线图的可滑动视图
 */
@property (nonatomic, strong) UIScrollView *scrollView;

/**
 *  折线图
 */
@property (nonatomic, strong) SJChartLineView *chartLineView;

/**
 *  X轴刻度标签 和 对应的折线图点的值
 */
@property (nonatomic, strong) NSArray *xMarkTitlesAndValues;

@end

@implementation SJLineChart

- (void)setXScaleMarkLEN:(CGFloat)xScaleMarkLEN {
    _xScaleMarkLEN = xScaleMarkLEN;
}

- (void)setYMarkTitles:(NSArray *)yMarkTitles {
    _yMarkTitles = yMarkTitles;
}

- (void)setMaxValue:(CGFloat)maxValue {
    _maxValue = maxValue;
 
}

- (void)setMixValue:(CGFloat)mixValue{

      _mixValue = mixValue;

}
- (void)setTitle:(NSString *)title {
    _title = title;
    
}

- (void)setLineArray:(NSArray *)lineArray{

      _lineArray = lineArray;
}
- (void)setValueArray1:(NSMutableArray *)valueArray1{

      _valueArray1 = valueArray1;
}
- (void)setValueArray2:(NSArray *)valueArray2{

      _valueArray2 = valueArray2;
}

- (void)setValueArray3:(NSArray *)valueArray3{

      _valueArray3 = valueArray3;
}
- (void)setLeftColor:(UIColor *)leftColor{
      _leftColor = leftColor;
}
- (void)setIsDotte:(BOOL)isDotte{

      _isDotte = isDotte;
}

- (void)setXMarkArray:(NSMutableArray *)xMarkArray{

      _xMarkArray = xMarkArray;
      if (!xMarkTitles) {
            _xMarkArray = [NSMutableArray array];
            
      }
      
      xMarkTitles = _xMarkArray;
}

- (void)setXMarkTitlesAndValues:(NSArray *)xMarkTitlesAndValues titleKey:(NSString *)titleKey valueKey:(NSString *)valueKey {
    
    _xMarkTitlesAndValues = xMarkTitlesAndValues;
    
    xMarkTitles = [NSMutableArray array];
    valueArray = [NSMutableArray array];
    
    for (NSDictionary *dic in xMarkTitlesAndValues) {
        
        [xMarkTitles addObject:[dic objectForKey:titleKey]];
        [valueArray addObject:[dic objectForKey:valueKey]];
    }
      xMarkTitles = @[@"1日",@"2日",@"3日",@"4日",@"5日",@"6日",@"7日",@"8日",@"9日",@"10日",@"11日",@"12日",@"13日",@"14日",@"15日",@"16日",@"17日",@"18日",@"19日",@"20日",@"21日",@"22日",@"23日",@"24日",@"25日",@"26日",@"27日",@"28日",@"29日",@"30日",@"31日"].mutableCopy;
      valueArray = self.valueArray1;
}

#pragma mark 绘图
- (void)mapping {
    
    static CGFloat topToContainView = 0.f;
    
    if (self.title) {
          
          UIView *colorView =[[UIView alloc] init];
          [self addSubview:colorView];
          colorView.frame = CGRectMake(0, 15, 10, 10);
          colorView.backgroundColor = self.leftColor;
          
          
        self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(colorView.frame)+4, 12, CGRectGetWidth(self.frame), 20)];
        self.titleLab.text = self.title;
        self.titleLab.font = [UIFont systemFontOfSize:13];
        self.titleLab.textAlignment = NSTextAlignmentLeft;
          self.titleLab.textColor = kUIColorFromRGB(0x333333);
        [self addSubview:self.titleLab];
         
        
        topToContainView = 20;
    }
    
    if (!self.xMarkTitlesAndValues) {
        
        xMarkTitles = @[@1,@2,@3,@4,@5].mutableCopy;
        valueArray = @[@2,@2,@2,@2,@2].mutableCopy;
        
        NSLog(@"折线图需要一个显示X轴刻度标签的数组xMarkTitles");
        NSLog(@"折线图需要一个转折点值的数组valueArray");
    }

    
    if (!self.yMarkTitles) {
        self.yMarkTitles = @[@0,@1,@2,@3,@4,@5];
        NSLog(@"折线图需要一个显示Y轴刻度标签的数组yMarkTitles");
    }
    
      if (self.mixValue == 0) {
            self.mixValue  = 0.0;
      }

    if (self.maxValue == 0) {
        self.maxValue = 5;
      
        NSLog(@"折线图需要一个最大值maxValue");
        
    }
        
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, topToContainView, self.frame.size.width,self.frame.size.height - topToContainView)];
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.scrollView setShowsVerticalScrollIndicator:NO];
    [self addSubview:self.scrollView];
    
    self.chartLineView = [[SJChartLineView alloc] initWithFrame:self.scrollView.bounds];
      __weak typeof(self) weakSelf = self;
      
      self.chartLineView.lineBlock = ^(NSArray *strAry,NSInteger index){
      
            weakSelf.lineChartBlock(strAry,index);
      };
      self.chartLineView.isCurve = self.isCurve;
      self.chartLineView.yMarkTitles = self.yMarkTitles;
      self.chartLineView.xMarkTitles = xMarkTitles;
      self.chartLineView.xScaleMarkLEN = self.xScaleMarkLEN;
      self.chartLineView.valueArray = self.valueArray1;
      self.chartLineView.valueArray2 = self.valueArray2;
      self.chartLineView.valueArray3 = self.valueArray3;
      self.chartLineView.linArray = self.lineArray;
      self.chartLineView.maxValue = self.maxValue;
      self.chartLineView.mixValue = self.mixValue;
      self.chartLineView.isDotte = self.isDotte;
      self.chartLineView.isKey = self.isKey;
      self.chartLineView.isHome = self.isHome;
    
    [self.scrollView addSubview:self.chartLineView];
    
    [self.chartLineView mapping];
    
    self.scrollView.contentSize = self.chartLineView.bounds.size;
   
}

#pragma mark 更新数据
- (void)reloadDatas {
    [self.chartLineView reloadDatas];
}


@end
