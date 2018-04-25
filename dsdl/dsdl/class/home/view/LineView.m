//
//  LineView.m
//  dsdl
//
//  Created by 廉英雷 on 16/11/10.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import "LineView.h"
#import "JHLineChart.h"
#define degreesToRadians(x) (M_PI*(x)/180.0) //把角度转换成PI的方式
#define  PROGREESS_WIDTH 80 //圆直径
#define PROGRESS_LINE_WIDTH 4 //弧线的宽度

@interface LineView ()


@end
@implementation LineView

- (instancetype)initWithFrame:(CGRect)frame
{
      self = [super initWithFrame:frame];
      if (self) {
            
            [self showFirstQuardrant];
          
           // [self cashpaLayer];
            
      }
      return self;
}


- (void)cashpaLayer{
      
     


      int radius = 20;
      
      CAShapeLayer *arc = [CAShapeLayer layer];
      arc.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(50, 50) radius:radius startAngle:60.0 endAngle:0.0 clockwise:YES].CGPath;
      
      arc.position = CGPointMake(CGRectGetMidX(self.frame)-radius,
                                 CGRectGetMidY(self.frame)-radius);
      
      arc.fillColor = [UIColor clearColor].CGColor;
      arc.strokeColor = [UIColor purpleColor].CGColor;
      arc.lineWidth = 15;
      CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
      drawAnimation.duration            = 5.0; // "animate over 10 seconds or so.."
      drawAnimation.repeatCount         = 1.0;  // Animate only once..
      drawAnimation.removedOnCompletion = NO;   // Remain stroked after the animation..
      drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
      drawAnimation.toValue   = [NSNumber numberWithFloat:10.0f];
      drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
      [arc addAnimation:drawAnimation forKey:@"drawCircleAnimation"];
      
      CAGradientLayer *gradientLayer = [CAGradientLayer layer];
      gradientLayer.frame = self.frame;
      gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,(__bridge id)[UIColor blueColor].CGColor ];
      gradientLayer.startPoint = CGPointMake(0,0.5);
      gradientLayer.endPoint = CGPointMake(1,0.5);
      
      [self.layer addSublayer:gradientLayer];
      //Using arc as a mask instead of adding it as a sublayer.
      //[self.view.layer addSublayer:arc]; 
      gradientLayer.mask = arc;
      
      

}
- (void)changeColor{

      //设置渐变颜色
      CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
      gradientLayer.frame = self.bounds;
//      [gradientLayer setColors:[NSArray arrayWithObjects:(id)[UIColor redColor].CGColor,(id)[UIColor whiteColor].CGColor, nil];
       gradientLayer.colors = [NSArray arrayWithObjects:(id)[UIColor redColor].CGColor, (id)[UIColor whiteColor].CGColor, nil];
      gradientLayer.startPoint = CGPointMake(0, 0);
      gradientLayer.endPoint = CGPointMake(1, 1);
      
      [self.layer addSublayer:gradientLayer];
}

//第一象限折线图
- (void)showFirstQuardrant{
      
      
      /*        创建表对象         */
      JHLineChart *lineChart = [[JHLineChart alloc] initWithFrame:self.bounds andLineChartType:JHChartLineValueNotForEveryX];
      //  [self.scrollView addSubview:lineChart];
      
      /* X轴的刻度值 可以传入NSString或NSNumber类型  并且数据结构随折线图类型变化而变化 详情看文档或其他象限X轴数据源示例*/
      lineChart.xLineDataArr = @[@"0",@"1",@"2",@3,@4,@5,@6,@7,@8,@9,@10,@11,@12];
      /* 折线图的不同类型  按照象限划分 不同象限对应不同X轴刻度数据源和不同的值数据源 */
      lineChart.lineChartQuadrantType = JHLineChartQuadrantTypeFirstQuardrant;
      /* 数据源 */
      lineChart.valueArr = @[@[@"1",@"12",@"1",@6,@4,@9,@6,@7],@[@"3",@"1",@"2",@16,@2,@3,@5,@10]];
      /* 值折线的折线颜色 默认暗黑色*/
      lineChart.valueLineColorArr =@[ [UIColor redColor], [UIColor brownColor]];
      /* 值点的颜色 默认橘黄色*/
      lineChart.pointColorArr = @[[UIColor orangeColor],[UIColor yellowColor]];
      /* X和Y轴的颜色 默认暗黑色 */
      lineChart.xAndYLineColor = [UIColor blackColor];
      /* XY轴的刻度颜色 m */
      lineChart.xAndYNumberColor = [UIColor blueColor];
      /* 坐标点的虚线颜色 */
      lineChart.positionLineColorArr = @[[UIColor blueColor],[UIColor greenColor]];
      /*        设置是否填充内容 默认为否         */
      lineChart.contentFill = NO;
      /*        设置为曲线路径         */
      lineChart.pathCurve = NO;
      
      /*        设置填充颜色数组         */
      lineChart.contentFillColorArr = @[[UIColor colorWithRed:0.500 green:0.000 blue:0.500 alpha:0.468],[UIColor colorWithRed:0.500 green:0.214 blue:0.098 alpha:0.468]];
      lineChart.backgroundColor = [UIColor whiteColor];
     
      [self addSubview:lineChart];
      /*        开始动画         */
      [lineChart showAnimation];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
