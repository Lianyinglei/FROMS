//
//  SJChartLineView.m
//  SJChartViewDemo
//
//  Created by Jaesun on 16/9/9.
//  Copyright © 2016年 S.J. All rights reserved.
//

#import "SJChartLineView.h"
#import "SJCircleView.h"

#define P_M(x,y) CGPointMake(x, y)

// Tag 基初值
#define BASE_TAG_COVERVIEW 100
#define BASE_TAG_CIRCLEVIEW 200
#define BASE_TAG_POPBTN 300

@interface SJChartLineView() {
   
    NSMutableArray *pointArray;
    NSInteger lastSelectedIndex;
      CAShapeLayer* currentLayer;
      NSMutableArray *pointArray2;
      NSMutableArray *pointArray3;
      NSMutableArray *pointArrayMax;
}

@property (nonatomic, weak) UIView *coverView;

@property (nonatomic,copy) NSString *dateStr;
//@property (nonatomic, weak) CAShapeLayer* currentLayer;
@end

@implementation SJChartLineView

//- (void)setMaxValue:(CGFloat)maxValue {
//    _maxValue = maxValue;
//}

- (void)setValueArray:(NSArray *)valueArray {
    _valueArray = valueArray;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        lastSelectedIndex = - 1;
        pointArray = [NSMutableArray array];
          pointArray2 = [NSMutableArray array];
          pointArrayMax = [NSMutableArray array];
          pointArray3 = [NSMutableArray array];
          
        self.yAxis_L = frame.size.height;
        self.xAxis_L = frame.size.width;
      
    }
    return  self;
}


- (void)setValueArray2:(NSArray *)valueArray2{

      _valueArray2 = valueArray2;
}
- (void)mapping {
   
    [super mapping];
      
      
      if (self.isDotte) {
            [self drawChartLine:self.valueArray withColor:[UIColor colorWithRed:51/255.0 green:148/255.0 blue:202/255.0 alpha:1.0] withPointAry:pointArray withIsCurve:NO];
           
             [self drawChartLine:self.valueArray2 withColor:[UIColor colorWithRed:238/255.0 green:130/255.0 blue:38/255.0 alpha:1.0] withPointAry:pointArray2 withIsCurve:NO];
            
          //  [self drawGradient:pointArray wihtColorAry:@[(__bridge id)kUIColorFromRGB(0x00a5d3).CGColor,(__bridge id)[UIColor colorWithWhite:1 alpha:0.1].CGColor]];
           
            [self drawGradient:pointArray wihtColorAry:@[(__bridge id)kUIColorFromRGB(0x00a5d3).CGColor,(__bridge id)[UIColor colorWithWhite:1 alpha:0.1].CGColor]];
            
            [self drawGradient:pointArray2 wihtColorAry:@[(__bridge id)kUIColorFromRGB(0xfd9602).CGColor,(__bridge id)[UIColor colorWithWhite:1 alpha:0.1].CGColor]];
            
            
      }else if (self.isKey){
      
            [self drawChartLine:self.valueArray withColor:kUIColorFromRGB(0x0ead6b) withPointAry:pointArray withIsCurve:NO];
            
            [self drawChartLine:self.valueArray2 withColor:kUIColorFromRGB(0x00a5d3) withPointAry:pointArray2 withIsCurve:NO];
            
            [self drawChartLine:self.valueArray3 withColor:kUIColorFromRGB(0xfd9602) withPointAry:pointArray3 withIsCurve:NO];
            
      
      }else if (self.isHome){
      
            [self drawChartLine:self.valueArray withColor:[UIColor colorWithRed:51/255.0 green:148/255.0 blue:202/255.0 alpha:1.0] withPointAry:pointArray withIsCurve:NO];
            
            [self drawChartLine:self.valueArray2 withColor:[UIColor colorWithRed:238/255.0 green:130/255.0 blue:38/255.0 alpha:1.0] withPointAry:pointArray2 withIsCurve:NO];
      
           [self drawChartLine:self.valueArray3 withColor:kUIColorFromRGB(0x05985d) withPointAry:nil withIsCurve:YES];
      }
      else{
      
//            [self drawChartLine:@[@95,@95,@95,@95,@95,@95,@95] withColor:kUIColorFromRGB(0x05985d) withPointAry:pointArrayMax withIsCurve:YES];
            
            [self drawChartLine:self.valueArray withColor:[UIColor colorWithRed:51/255.0 green:148/255.0 blue:202/255.0 alpha:1.0] withPointAry:pointArray withIsCurve:NO];
            
            [self drawChartLine:self.valueArray2 withColor:[UIColor colorWithRed:238/255.0 green:130/255.0 blue:38/255.0 alpha:1.0] withPointAry:pointArray2 withIsCurve:NO];
      
      }
      
    //  [NSThread sleepForTimeInterval:2.5];
      [self performSelector:@selector(setupCircleViews:) withObject:pointArray afterDelay:1.5f];
      [self performSelector:@selector(setupCircleViews:) withObject:pointArray2 afterDelay:1.5f];
      [self performSelector:@selector(setupCircleViews:) withObject:pointArray3 afterDelay:1.5f];
      
//      [self setupCircleViews:pointArray];
//      [self setupCircleViews:pointArray2];
     [self setupCoverViews];
}

- (void)reloadDatas {
    
    [super reloadDatas];
    
    [self clearView];
    [self mapping];
}

#pragma mark 画折线图
- (void)drawChartLine:(NSArray *)valueArray withColor:(UIColor *)color withPointAry:(NSMutableArray *)pointAry withIsCurve:(BOOL)isCurve;
    {
         
        UIBezierPath *pAxisPath = [[UIBezierPath alloc] init];
          
        for (int i = 0; i < valueArray.count; i ++) {
              
            CGFloat point_X = self.xScaleMarkLEN * i + self.startPoint.x;
            
            CGFloat value = [valueArray[i] floatValue];
              CGFloat percent;
              
               percent =(value -self.mixValue) / (self.maxValue -self.mixValue);
              
            CGFloat point_Y = self.yAxis_L * (1 - percent) + self.startPoint.y;
            
            CGPoint point = CGPointMake(point_X, point_Y);
            
            // 记录各点的坐标方便后边添加渐变阴影 和 点击层视图 等
            [pointAry addObject:[NSValue valueWithCGPoint:point]];
            
            if (i == 0) {
                  
                [pAxisPath moveToPoint:point];
                  [pAxisPath moveToPoint:point];
            }
            else {
                  if (isCurve) {
                        
                         [pAxisPath addLineToPoint:point];
                  }else{
                        
#pragma mark -----曲线的核心代码---------
                        
                  
//                        CGFloat point_X = self.xScaleMarkLEN * (i-1) + self.startPoint.x;
//                        
//                        CGFloat value = [valueArray[i-1] floatValue];
//                        CGFloat percent = value / self.maxValue;
//                        CGFloat point_Y = self.yAxis_L * (1 - percent) + self.startPoint.y;
                        
                      //  CGPoint point2 = CGPointMake(point_X, point_Y);
                        //曲线的核心代码------
//                        [pAxisPath addCurveToPoint:point controlPoint1:CGPointMake((point.x-point2.x)/2+point2.x, point2.y) controlPoint2:CGPointMake((point.x-point2.x)/2+point2.x, point.y)];
                        
                        [pAxisPath addLineToPoint:point];
                  
                  }
                  
                 
            }
        }

          pAxisPath.lineCapStyle = kCGLineCapRound;
          pAxisPath.lineJoinStyle = kCGLineJoinRound;
          
        CAShapeLayer *pAxisLayer = [CAShapeLayer layer];
          
        pAxisLayer.lineWidth = 2;
        pAxisLayer.strokeColor = color.CGColor;
        pAxisLayer.fillColor = [UIColor clearColor].CGColor;
        pAxisLayer.path = pAxisPath.CGPath;
          
          //第三，动画
          
          CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
          
          ani.fromValue = @0;
          
          ani.toValue = @1;
          
          ani.duration = 1.0;
          
          ani.delegate = self;
          
          [pAxisLayer addAnimation:ani forKey:NSStringFromSelector(@selector(strokeEnd))];
         
        [self.layer addSublayer:pAxisLayer];
}

#pragma mark 渐变阴影
- (void)drawGradient:(NSMutableArray *)pointAry wihtColorAry:(NSArray *)colorAry{
        
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
   // gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:250/255.0 green:170/255.0 blue:10/255.0 alpha:0.8].CGColor,(__bridge id)[UIColor colorWithWhite:1 alpha:0.1].CGColor];
      gradientLayer.colors = colorAry;
      
    gradientLayer.locations=@[@0.0,@1.0];
    gradientLayer.startPoint = CGPointMake(0.0,0.0);
    gradientLayer.endPoint = CGPointMake(0.0,1);
    
    UIBezierPath *gradientPath = [[UIBezierPath alloc] init];
    [gradientPath moveToPoint:CGPointMake(self.startPoint.x, self.yAxis_L + self.startPoint.y)];
    
      
    for (int i = 0; i < pointAry.count; i ++) {
        [gradientPath addLineToPoint:[pointAry[i] CGPointValue]];
    }
    
    CGPoint endPoint = [[pointAry lastObject] CGPointValue];
    endPoint = CGPointMake(endPoint.x + self.startPoint.x-45, self.yAxis_L + self.startPoint.y);
      
    //  [pAxisPath addCurveToPoint:point controlPoint1:CGPointMake((point.x-point2.x)/2+point2.x, point2.y) controlPoint2:CGPointMake((point.x-point2.x)/2+point2.x, point.y)];
     
      //[gradientPath addCurveToPoint:endPoint controlPoint1:CGPointMake((endPoint.x-starPoint.x)/2+starPoint.x, starPoint.y) controlPoint2:CGPointMake((endPoint.x -starPoint.x)/2+starPoint.x, endPoint.y)];
    [gradientPath addLineToPoint:endPoint];
      
    CAShapeLayer *arc = [CAShapeLayer layer];
    arc.path = gradientPath.CGPath;
    gradientLayer.mask = arc;
    [self.layer addSublayer:gradientLayer];

}

#pragma mark 折线上的圆环----
- (void)setupCircleViews:(NSMutableArray *)pointAry{
    
    for (int i = 0; i < pointAry.count; i ++) {
          
          if (i%5 == 0) {
                SJCircleView *circleView = [[SJCircleView alloc] initWithCenter:[pointAry[i] CGPointValue] radius:4];
                circleView.tag = i + BASE_TAG_CIRCLEVIEW;
                circleView.borderColor = [UIColor orangeColor];
                circleView.borderWidth = 1.0;
                [self addSubview:circleView];
          }
        
       
    }
}

#pragma mark 覆盖一层点击图层----长按手势
- (void)setupCoverViews {

    for (int i = 0; i < pointArray.count; i ++) {
        
        UIView *coverView = [[UIView alloc] init];
        coverView.tag = BASE_TAG_COVERVIEW + i;
          self.coverView = coverView;
        if (i == 0) {
            
            coverView.frame = CGRectMake(self.startPoint.x, self.startPoint.y, self.xScaleMarkLEN  / 2, self.yAxis_L);
            [self addSubview:coverView];
        }
        else if (i == pointArray.count - 1 && pointArray.count == self.xMarkTitles.count) {
            CGPoint point = [pointArray[i] CGPointValue];
            coverView.frame = CGRectMake(point.x - self.xScaleMarkLEN / 2, self.startPoint.y, self.xScaleMarkLEN  / 2, self.yAxis_L);
            [self addSubview:coverView];
        }
        else {
            CGPoint point = [pointArray[i] CGPointValue];
            coverView.frame = CGRectMake(point.x - self.xScaleMarkLEN / 2, self.startPoint.y, self.xScaleMarkLEN, self.yAxis_L);
            [self addSubview:coverView];
        }
          coverView.userInteractionEnabled = YES;
          
        UITapGestureRecognizer *gesutre = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(event_longPressAction:)];
        [coverView addGestureRecognizer:gesutre];
          
          gesutre.numberOfTapsRequired = 1;
          //长按手势
//          UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGes:)];
//          ges.numberOfTapsRequired = 1;
          
          UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(event_longPressAction:)];
          [coverView addGestureRecognizer:longPress];
    }
}


#pragma mark  ---长按点击事件-------
//- (void)event_longPressAction:(UITapGestureRecognizer *)longPress{

- (void)event_longPressAction:(UILongPressGestureRecognizer *)longPress {
      
     
//      if(UIGestureRecognizerStateChanged == longPress.state || UIGestureRecognizerStateBegan == longPress.state) {
    //  NSArray *ary =      self.layer.sublayers;
            
           CGPoint location = [longPress locationInView:self];
            
           
            if (location.x>30 && location.x <_width-20) {
                  
            
            if (currentLayer) {
                  [currentLayer removeFromSuperlayer];
            }
            
            UIBezierPath *xAxisPath = [[UIBezierPath alloc] init];
            [xAxisPath moveToPoint:CGPointMake(location.x, self.frame.origin.y+10)];
            
            [xAxisPath addLineToPoint:CGPointMake(location.x, self.frame.origin.y+self.frame.size.height-20)];
            
            CAShapeLayer *xAxisLayer = [CAShapeLayer layer];
            [xAxisLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:0], nil]];
            xAxisLayer.lineWidth = 3;;
                  xAxisLayer.strokeColor = kUIColorFromRGB(0x00a5d3).CGColor;
            xAxisLayer.path = xAxisPath.CGPath;
            currentLayer = xAxisLayer;
                  
                  CATextLayer *textLayer = [CATextLayer layer];
                  textLayer.frame = CGRectMake(location.x-10, self.frame.origin.y+self.frame.size.height-20, 20, 30);
                  
                  textLayer.fontSize = [UIFont systemFontOfSize:13].pointSize;
                  textLayer.backgroundColor = [UIColor whiteColor].CGColor;
                  textLayer.foregroundColor = kUIColorFromRGB(0x00a5d3).CGColor;
                  textLayer.alignmentMode = kCAAlignmentCenter;
                  [currentLayer addSublayer:textLayer];
    // textLayer.string = @"";
             [self.layer addSublayer:currentLayer];
                  
    //---------获取当前的点并显示--------
                //  NSArray *ary = pointArray;
                   CGFloat locationX = location.x;
                  NSInteger locaX = (NSInteger)locationX;
                  //判断当前点是否大于最大点的x值
                  CGPoint maxPoint = [pointArray.lastObject CGPointValue];
                  
                  if (locationX < maxPoint.x) {
                        
                  for (NSValue *value in pointArray) {
                        CGPoint p = [value CGPointValue];
                        NSInteger px = (NSInteger)p.x;
                        
                        if (px ==locaX) {
                             
                              NSInteger index = (NSInteger)(p.x+1 -self.startPoint.x)/self.xScaleMarkLEN;
                              
                              self.dateStr = self.xMarkTitles[index];
                              
                              self.dateStr = [self.dateStr substringToIndex:self.dateStr.length -1];
                              NSLog(@"下标结果----%ld",index);
                              NSLog(@"结果2----%@",self.dateStr);
                              
                              
                              textLayer.string = self.dateStr;
                              
                              if (self.isKey) {
                                   
//                                    NSNumber *num = self.valueArray[index];
//                                    NSNumber *num2 = self.valueArray2[index];
//                                    NSNumber *num3 = self.valueArray[index];
//                                    NSLog(@"结果----%@",num);
//                                    NSLog(@"结果2----%@",num2);
//                                    
                                    NSString *str1 = [NSString stringWithFormat:@"%ld",(long)index];
//                                    NSString *str2 = [NSString stringWithFormat:@"%@",num2];
                                    __weak typeof(self) weakSelf = self;
                                    NSArray *strAry = @[str1];
                                    weakSelf.lineBlock(strAry,index);
                                    
                              }else{
                              
                                    
                                    NSNumber *num = self.valueArray[index];
                                    NSNumber *num2 = self.valueArray2[index];

                                    
                                    NSString *str1 = [NSString stringWithFormat:@"%@",num];
                                    NSString *str2 = [NSString stringWithFormat:@"%@",num2];
                                    __weak typeof(self) weakSelf = self;
                                    
                                    NSArray *strAry = @[str1,str2];
                                    weakSelf.lineBlock(strAry,index);
                              
                              }
                              
                              
                              
                        }else{
                        
                              textLayer.string = self.dateStr;
                        };
                  }
                        
                                     //   }
            
            
            }
            
            
      }else{
      
            [[NSNotificationCenter defaultCenter] postNotificationName:@"touchEnd" object:nil];
          //  [currentLayer removeFromSuperlayer];
      }
}


#pragma mark- 点击层视图的点击事件
      
- (void)gesutreAction:(UITapGestureRecognizer *)sender {
      
      
    
    NSInteger index = sender.view.tag - BASE_TAG_COVERVIEW;
    
    if (lastSelectedIndex != -1) {
        
        SJCircleView *lastCircleView = (SJCircleView *)[self viewWithTag:lastSelectedIndex + BASE_TAG_CIRCLEVIEW];
        lastCircleView.borderWidth = 1;
        
        UIButton *lastPopBtn = (UIButton *)[self viewWithTag:lastSelectedIndex + BASE_TAG_POPBTN];
        [lastPopBtn removeFromSuperview];
    }
    
    SJCircleView *circleView = (SJCircleView *)[self viewWithTag:index + BASE_TAG_CIRCLEVIEW];
    circleView.borderWidth = 2;
    
    CGPoint point = [pointArray[index] CGPointValue];
    
    UIButton *popBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    popBtn.tag = index + BASE_TAG_POPBTN;
    popBtn.frame = CGRectMake(point.x - 10, point.y - 20, 20, 15);
    
    [popBtn setBackgroundImage:[UIImage imageNamed:@"btg_pop_bg.png"] forState:UIControlStateNormal];
    
    [popBtn setTitleEdgeInsets:UIEdgeInsetsMake(- 3, 0, 0, 0)];
    popBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [popBtn setTitle:[NSString stringWithFormat:@"%@",self.valueArray[index]] forState:(UIControlStateNormal)];
    
    [self addSubview:popBtn];

    lastSelectedIndex = index;
}

#pragma mark- 清空视图
- (void)clearView {
    [self removeSubviews];
    [self removeSublayers];
}

#pragma mark 移除 点击图层 、圆环 、数值标签
- (void)removeSubviews {
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}

#pragma mark 移除折线
- (void)removeSublayers {
    for (CALayer *layer in self.layer.sublayers) {
        [layer removeFromSuperlayer];
    }
}



@end
