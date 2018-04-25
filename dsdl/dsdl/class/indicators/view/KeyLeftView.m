//
//  KeyLeftView.m
//  dsdl
//
//  Created by 廉英雷 on 16/11/14.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import "KeyLeftView.h"
#import "WMGaugeView.h"
#import "ProfitContentView.h"
#import "JHColumnChart.h"

@interface KeyLeftView ()

@property (nonatomic, strong) WMGaugeView *gaugeView;

@property (nonatomic, weak) UIView *headVeiw;


@end

@implementation KeyLeftView

- (instancetype)initWithFrame:(CGRect)frame{

      if (self = [super initWithFrame:frame]) {
            
            [self creatView];
      }
      return self;
}

- (void)creatView{
      self.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
      
      UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _width, 200)];
      [self addSubview:headView];
      self.headVeiw = headView;
      headView.backgroundColor = [UIColor whiteColor];

      self.gaugeView = [[WMGaugeView alloc] initWithFrame:CGRectMake(0, 20, 150, 150)];
      [headView addSubview:self.gaugeView];
      
      self.gaugeView.backgroundColor = [UIColor clearColor];
      //最大数
      _gaugeView.maxValue = 240.0;
      
      //最外圈的是否显示
      _gaugeView.showRangeLabels = YES;
      
      _gaugeView.rangeColors = @[kUIColorFromRGB(0x0fa8df)];
      _gaugeView.rangeValues = @[            @240            ];
      //      _gaugeView.rangeColors = @[ RGB(232, 111, 33),    RGB(232, 231, 33),  RGB(27, 202, 33),   RGB(231, 32, 43)    ];
      //      _gaugeView.rangeLabels = @[ @"VERY LOW",          @"LOW",             @"OK",              @"OVER FILL"        ];
      _gaugeView.unitOfMeasurement = @"psi";
      _gaugeView.innerBackgroundStyle = WMGaugeViewInnerBackgroundStyleFlat;
      _gaugeView.showUnitOfMeasurement = YES;
      
      //日利润view
      ProfitContentView *profitView = [[ProfitContentView alloc] initWithFrame:CGRectMake( CGRectGetMaxX(self.gaugeView.frame)+10, 10, _width -self.gaugeView.width-10, headView.height -20)];
      [headView addSubview:profitView];
      profitView.dataAry = @[@"9.55",@"188.88",@"66.67%",@"33.32%"];
     
      [self creatFooterView];

}

- (void)creatFooterView{

      /*        创建对象         */
      JHColumnChart *column = [[JHColumnChart alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headVeiw.frame) +10, _width, _height*0.5)];
      /*        创建数据源数组 每个数组即为一个模块数据 例如第一个数组可以表示某个班级的不同科目的平均成绩 下一个数组表示另外一个班级的不同科目的平均成绩         */
      column.valueArr = @[
                          @[@12,@15,@20],
                          @[@22,@15,@20],
                          @[@12,@5,@40],
                          @[@2,@15,@20],
                          @[@33,@12,@30]
                          ];
      /*       该点 表示原点距左下角的距离         */
      column.originSize = CGPointMake(30, 30);
      
      /*        第一个柱状图距原点的距离         */
      column.drawFromOriginX = 10;
      /*        柱状图的宽度         */
      column.columnWidth = 20;
      /*        X、Y轴字体颜色         */
      column.drawTextColorForX_Y = [UIColor greenColor];
      /*        X、Y轴线条颜色         */
      column.colorForXYLine = [UIColor greenColor];
      
      /*        每个模块的颜色数组 例如A班级的语文成绩颜色为红色 数学成绩颜色为绿色         */
      column.columnBGcolorsArr = @[[UIColor redColor],[UIColor greenColor],[UIColor orangeColor],[UIColor blueColor]];
      /*        模块的提示语         */
      column.xShowInfoText = @[@"A班级",@"B班级",@"C班级",@"D班级"];
      column.bgVewBackgoundColor = [UIColor whiteColor];
      /*        开始动画         */
      [column showAnimation];
      [self addSubview:column];


}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
