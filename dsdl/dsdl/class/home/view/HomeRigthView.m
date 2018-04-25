//
//  HomeRigthView.m
//  dsdl
//
//  Created by 廉英雷 on 16/12/3.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import "HomeRigthView.h"
#import "SJLineChart.h"
#import "HomeLeftHeadView.h"

@interface HomeRigthView ()

@property (nonatomic, weak) HomeLeftHeadView *rView;

@property (nonatomic, weak) HomeLeftHeadView *fView;
@end
@implementation HomeRigthView

- (instancetype)initWithFrame:(CGRect)frame{

      if (self = [super initWithFrame:frame]) {
            [self creatView];
//            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(touchEnd) name:@"touchEnd" object:nil];
      }
      
      return self;
}

//- (void)touchEnd{
//      
//   self.fView.oneLab.text = @"78.92";
//      self.fView.oneDevLab.text = @"-0.92";
//      
//      self.fView.twoLab.text = @"89.3";
//      self.fView.twoDevLab.text = @"+0.92";
//      
//      
//      self.rView.oneLab.text = @"78.92";
//      self.rView.oneDevLab.text = @"+0.92";
//      
//      self.rView.twoLab.text = @"78.92";
//      self.rView.twoDevLab.text = @"+0.92";
//      
//
//}


- (void)creatView{
      
      UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _width, 270)];
      [self addSubview:headView];
      headView.backgroundColor = [UIColor whiteColor];
      
      HomeLeftHeadView *rView = [[NSBundle mainBundle] loadNibNamed:@"HomeLeftHeadView" owner:self options:nil].lastObject;;
      self.rView = rView;
      rView.frame = CGRectMake(0, 0, headView.width, 90);
      rView.backgroundColor = [UIColor whiteColor];
      rView.leftTitle.text = @"计划日利润";
      [headView addSubview:rView];
      
      
      
      // 初始化折线图
      SJLineChart *lineChart = [[SJLineChart alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(rView.frame), headView.width-60, headView.height - rView.height -5)];
      
      
      lineChart.lineChartBlock = ^(NSArray *strAry,NSInteger index){
            
            CGFloat oneNum = [strAry[0] floatValue];
            CGFloat twoNum = [strAry[1] floatValue];
            
            CGFloat devNum = oneNum  -80;
             rView.oneLab.text = strAry[0];
            if (devNum>=0) {
                  rView.oneDevLab.text = [NSString stringWithFormat:@"+%.2f",devNum];
                  rView.oneDevLab.textColor = kUIColorFromRGB(0x05985d);
            }else{
                  rView.oneDevLab.text = [NSString stringWithFormat:@"%.2f",devNum];
                  rView.oneDevLab.textColor = kUIColorFromRGB(0xff0000);
            
            }
            
                  CGFloat devNum2 = twoNum  -75;
            rView.twoLab.text = strAry[1];
            if (devNum2>=0) {
                  rView.twoDevLab.text = [NSString stringWithFormat:@"+%.2f",devNum2];
                  rView.twoDevLab.textColor = kUIColorFromRGB(0x05985d);
            }else{
                  rView.twoDevLab.text = [NSString stringWithFormat:@"%.2f",devNum2];
                  rView.twoDevLab.textColor = kUIColorFromRGB(0xff0000);
                  
            }

           
            
           
      };

      
      // 设置折线图属性
      
      lineChart.title = @"计划日利润"; // 折线图名称
      lineChart.maxValue = 100;   // 最大值
      lineChart.yMarkTitles = @[@"0",@"20",@"40",@"60",@"80",@"100"]; // Y轴刻度标签
      lineChart.isCurve = YES;
      lineChart.leftColor = kUIColorFromRGB(0x05985d);
      
      lineChart.valueArray2 = @[@30,@20,@60,@30,@40,@50,@60];
      [lineChart setXMarkTitlesAndValues:@[@{@"item":@"1日",@"count":@60},@{@"item":@"6日",@"count":@31},@{@"item":@"11日",@"count":@50},@{@"item":@"16日",@"count":@67},@{@"item":@"21日",@"count":@66},@{@"item":@"26日",@"count":@60},@{@"item":@"31日",@"count":@12}] titleKey:@"item" valueKey:@"count"]; // X轴刻度标签及相应的值
      
      
      // lineChart.xScaleMarkLEN = 60; // 可以不设，会根据视图的宽度自适应,设置后如果折线图的宽度大于视图宽度，折线图可以滑动
      
      //设置完数据等属性后绘图折线图
      [lineChart mapping];
      
      [headView addSubview:lineChart];
      
      
      
      //   --------------footerView-----------
      
      UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headView.frame)+5, _width, _height - headView.height - 10)];
      [self addSubview:footView];
      footView.backgroundColor = [UIColor whiteColor];
      
      HomeLeftHeadView *fView = [[NSBundle mainBundle] loadNibNamed:@"HomeLeftHeadView" owner:self options:nil].lastObject;;
      self.fView = fView;
      fView.frame = CGRectMake(0, 0, headView.width, 100);
      fView.backgroundColor = [UIColor whiteColor];
      [footView addSubview:fView];
      
      
      fView.leftTitle.text = @"月利润";
      
      
      UIView *colorView = [[UIView alloc] initWithFrame:CGRectMake(30, fView.height - 15, 10, 10)];
      [fView addSubview:colorView];
      colorView.backgroundColor = kUIColorFromRGB(0x00a5d3);
      UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(colorView.frame)+3, fView.height - 20, 150, 20)];
      
      lab.text = @"1#月利润计划值";
      lab.font = [UIFont systemFontOfSize:13];
      lab.textAlignment = NSTextAlignmentLeft;
      lab.textColor = kUIColorFromRGB(0x333333);
      [fView addSubview:lab];
      
      // 初始化折线图
      SJLineChart *lineChart2 = [[SJLineChart alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(rView.frame), headView.width-60, headView.height - rView.height -5)];
      
      lineChart2.lineChartBlock = ^(NSArray *strAry,NSInteger index){
            
            CGFloat oneNum = [strAry[0] floatValue];
            CGFloat twoNum = [strAry[1] floatValue];
            
            CGFloat devNum = oneNum  -2000;
            fView.oneLab.text = strAry[0];
            if (devNum>=0) {
                  fView.oneDevLab.text = [NSString stringWithFormat:@"+%.2f",devNum];
                  fView.oneDevLab.textColor = kUIColorFromRGB(0x05985d);
            }else{
                  fView.oneDevLab.text = [NSString stringWithFormat:@"%.2f",devNum];
                  fView.oneDevLab.textColor = kUIColorFromRGB(0xff0000);
                  
            }
            
            CGFloat devNum2 = twoNum  -1800;
            fView.twoLab.text = strAry[1];
            if (devNum2>=0) {
                  fView.twoDevLab.text = [NSString stringWithFormat:@"+%.2f",devNum2];
                  fView.twoDevLab.textColor = kUIColorFromRGB(0x05985d);
            }else{
                  fView.twoDevLab.text = [NSString stringWithFormat:@"%.2f",devNum2];
                  fView.twoDevLab.textColor = kUIColorFromRGB(0xff0000);
                  
            }

      };

      // 设置折线图属性
      
      lineChart2.title = @"2#月利润计划值"; // 折线图名称
      lineChart2.maxValue = 3000;   // 最大值
      lineChart2.yMarkTitles = @[@"0",@"500",@"1000",@"1500",@"2000",@"2500",@"3000"]; // Y轴刻度标签
      lineChart2.isCurve = NO;
      lineChart2.leftColor = kUIColorFromRGB(0xfd9602);
      lineChart2.isDotte = YES;
      lineChart2.valueArray2 = @[@400,@900,@1200,@1600,@2000,@2300,@2700];
      
      [lineChart2 setXMarkTitlesAndValues:@[@{@"item":@"1日",@"count":@100},@{@"item":@"6日",@"count":@600},@{@"item":@"11日",@"count":@800},@{@"item":@"16日",@"count":@1000},@{@"item":@"21日",@"count":@1500},@{@"item":@"26日",@"count":@1800},@{@"item":@"31日",@"count":@2000}] titleKey:@"item" valueKey:@"count"]; // X轴刻度标签及相应的值
      
      
      // lineChart.xScaleMarkLEN = 60; // 可以不设，会根据视图的宽度自适应,设置后如果折线图的宽度大于视图宽度，折线图可以滑动
      
      //设置完数据等属性后绘图折线图
      [lineChart2 mapping];
      
      [footView addSubview:lineChart2];
      
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
