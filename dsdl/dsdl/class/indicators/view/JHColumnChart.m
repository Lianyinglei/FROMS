//
//  JHColumnChart.m
//  JHChartDemo
//
//  Created by cjatech-简豪 on 16/5/10.
//  Copyright © 2016年 JH. All rights reserved.
//

#import "JHColumnChart.h"

@interface JHColumnChart ()

//背景图
@property (nonatomic,strong)UIScrollView *BGScrollView;



//横向最大值
@property (nonatomic,assign) CGFloat maxWidth;

//Y轴辅助线数据源
@property (nonatomic,strong)NSMutableArray * yLineDataArr;

//所有的图层数组
@property (nonatomic,strong)NSMutableArray * layerArr;

//所有的柱状图数组
@property (nonatomic,strong)NSMutableArray * showViewArr;
@end

@implementation JHColumnChart


-(NSMutableArray *)showViewArr{

    if (!_showViewArr) {
        _showViewArr = [NSMutableArray array];
    }
    
    return _showViewArr;
    
}

-(NSMutableArray *)layerArr{
    
    
    if (!_layerArr) {
        _layerArr = [NSMutableArray array];
    }
    
    return _layerArr;
}


-(UIScrollView *)BGScrollView{
    
    
    if (!_BGScrollView) {

        _BGScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
//        _BGScrollView.backgroundColor = [UIColor lightGrayColor];
        _BGScrollView.showsHorizontalScrollIndicator = NO;
        _bgVewBackgoundColor = [UIColor whiteColor];
          _BGScrollView.scrollEnabled = YES;
        [self addSubview:_BGScrollView];
        
    }
    
    return _BGScrollView;
    
    
}


-(NSMutableArray *)yLineDataArr{
    
    
    if (!_yLineDataArr) {
        _yLineDataArr = [NSMutableArray array];
    }
    return _yLineDataArr;
    
}


-(instancetype)initWithFrame:(CGRect)frame{
    
    
    if (self = [super initWithFrame:frame]) {

        _needXandYLine = YES;
       
        
    }
    return self;
    
}



-(void)setValueArr:(NSArray<NSArray *> *)valueArr{
    
    
    _valueArr = valueArr;
    CGFloat max = 0;
      
      
            for (NSArray *arr in _valueArr) {
                  
                  for (id number in arr) {
                        
                        CGFloat currentNumber = [NSString stringWithFormat:@"%@",number].floatValue;
                        if (currentNumber>max) {
                              max = currentNumber;
                        }
                        
                  }
                  
            }
      max = max+20;

//      }else{
//      
//            for (NSString *number in _lineRedAry) {
//                  
//                 
//                        
//                        CGFloat currentNumber = [NSString stringWithFormat:@"%@",number].floatValue;
//                        if (currentNumber>max) {
//                              max = currentNumber;
//                        }
//                        
//                  
//                  
//            }

     // }
 
      
    if (max<5.0) {
        _maxHeight = 5.0;
    }else if(max<10){
        _maxHeight = 10;
    }else{
        _maxHeight = max;
    }
    
    
   
    
    
    
}

//- (void)setXShowInfoText:(NSArray *)xShowInfoText{
//
//      _xShowInfoText = xShowInfoText;
//}

- (void)setLineRedAry:(NSArray *)lineRedAry{

      _lineRedAry = lineRedAry;
}
-(void)showAnimation{
    
    
    
    [self clear];
    
    _columnWidth = (_columnWidth<=0?30:_columnWidth);
    NSInteger count = _valueArr.count * [_valueArr[0] count];
    _typeSpace = (_typeSpace<=0?15:_typeSpace);
    _maxWidth = count * _columnWidth + _valueArr.count * _typeSpace + _typeSpace + 40;
    self.BGScrollView.contentSize = CGSizeMake(_maxWidth, 0);
    self.BGScrollView.backgroundColor = _bgVewBackgoundColor;
    
    
    /*        绘制X、Y轴  可以在此改动X、Y轴字体大小       */
    if (_needXandYLine) {
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        
        [self.layerArr addObject:layer];
        
        UIBezierPath *bezier = [UIBezierPath bezierPath];
        
        [bezier moveToPoint:CGPointMake(self.originSize.x, CGRectGetHeight(self.frame) - self.originSize.y)];
        
        [bezier addLineToPoint:P_M(self.originSize.x, 20)];
        
        
        [bezier moveToPoint:CGPointMake(self.originSize.x, CGRectGetHeight(self.frame) - self.originSize.y)];
    
        [bezier addLineToPoint:P_M(_maxWidth , CGRectGetHeight(self.frame) - self.originSize.y)];
        
        
        layer.path = bezier.CGPath;
        
        layer.strokeColor = (_colorForXYLine==nil?([UIColor blackColor].CGColor):_colorForXYLine.CGColor);
        
        
        CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        
        
        basic.duration = 1.5;
        
        basic.fromValue = @(0);
        
        basic.toValue = @(1);
        
        basic.autoreverses = NO;
        
        basic.fillMode = kCAFillModeForwards;
        
        
        [layer addAnimation:basic forKey:nil];
        
        [self.BGScrollView.layer addSublayer:layer];
        
#pragma mark -----设置警戒线------------------
          if (self.isPro) {
                /*        设置虚线辅助线         */
                UIBezierPath *second = [UIBezierPath bezierPath];
                for (NSInteger i = 4; i<5; i++) {
                      
                     // CGFloat height = (CGRectGetHeight(self.frame) - _originSize.y - 30)/5 * (i+1);
                      
                      //画警戒线
                    //  self.lineRedAry = @[@"1",@"2"];
                      if (self.lineRedAry.count>0) {
                            
                            for (int j =0; j<self.lineRedAry.count; j++) {
                                  CGFloat h = [self.lineRedAry[j] floatValue];
                                  
                                  CGFloat redH = (1 -  h/self.maxHeight) *(CGRectGetHeight(self.frame) - _originSize.y - 30) +30;
                                  
                                        [second moveToPoint:P_M(_originSize.x+self.typeSpace*(j+1)+self.columnWidth *2*j,redH)];
                                        
                                        [second addLineToPoint:P_M(_originSize.x+self.typeSpace*(j+1)+self.columnWidth *2*j+self.columnWidth *2, redH)];
                                  
                                  CAShapeLayer *shapeLayer = [CAShapeLayer layer];
                                  
                                  shapeLayer.path = second.CGPath;
                                  
                                  shapeLayer.strokeColor = [UIColor redColor].CGColor;
                                  
                                  shapeLayer.fillColor =[UIColor redColor].CGColor;
                                  
                                //  [shapeLayer setLineDashPattern:@[@(1),@(1)]];
                                  
                                  
                                  
                                  
                                  shapeLayer.lineWidth = 1.5;
                                  
                                  
                                  
                                  CABasicAnimation *basic2 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
                                  
                                  
                                  basic2.duration = 1.0;
                                  
                                  basic2.fromValue = @(0);
                                  
                                  basic2.toValue = @(1);
                                  
                                  basic2.autoreverses = NO;
                                  
                                  
                                  
                                  basic2.fillMode = kCAFillModeForwards;
                                  
                                 
                                  [shapeLayer addAnimation:basic2 forKey:nil];
                                  
                                  [self.BGScrollView.layer addSublayer:shapeLayer];
                            }
                            


                            
                      }
                      
//                      CGPoint p1 = P_M(_originSize.x, CGRectGetHeight(self.frame) - _originSize.y -height+5);
//                      CGPoint p2 = P_M(_maxWidth, CGRectGetHeight(self.frame) - _originSize.y - height+5);
                      
                      
//                      for (int j =0; j<3; j++) {
//                            
//                            if (j == 2) {
//                        [second moveToPoint:P_M(_originSize.x+self.typeSpace*(j+1)+self.columnWidth *2*j, CGRectGetHeight(self.frame) - _originSize.y -height+10)];
//                                  
//                                  [second addLineToPoint:P_M(_originSize.x+self.typeSpace*(j+1)+self.columnWidth *2*j+self.columnWidth *2, CGRectGetHeight(self.frame) - _originSize.y - height+10)];
//                            }else{
//                            
//                                  [second moveToPoint:P_M(_originSize.x+self.typeSpace*(j+1)+self.columnWidth *2*j, CGRectGetHeight(self.frame) - _originSize.y -height+5)];
//                                  
//                                  [second addLineToPoint:P_M(_originSize.x+self.typeSpace*(j+1)+self.columnWidth *2*j+self.columnWidth *2, CGRectGetHeight(self.frame) - _originSize.y - height+5)];
//                            }
//                           
//                            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//                            
//                            shapeLayer.path = second.CGPath;
//                            
//                            shapeLayer.strokeColor = [UIColor redColor].CGColor;
//                            
//                            
//                            
//                            [shapeLayer setLineDashPattern:@[@(5),@(5)]];
//                            
//                            
//                            
//                            
//                            shapeLayer.lineWidth = 0.5;
//                            
//                            
//                            
//                            CABasicAnimation *basic2 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//                            
//                            
//                            basic2.duration = 1.5;
//                            
//                            basic2.fromValue = @(0);
//                            
//                            basic2.toValue = @(1);
//                            
//                            basic2.autoreverses = NO;
//                            
//                            
//                            
//                            basic2.fillMode = kCAFillModeForwards;
//                            
//                            [shapeLayer addAnimation:basic2 forKey:nil];
//                            
//                            [self.BGScrollView.layer addSublayer:shapeLayer];
//                      }
                     
                
                }
               

                
          }
        
        /*        设置虚线辅助线         */
        UIBezierPath *second = [UIBezierPath bezierPath];
        for (NSInteger i = 0; i<5; i++) {

            CGFloat height = (CGRectGetHeight(self.frame) - _originSize.y - 30)/5 * (i+1);
            [second moveToPoint:P_M(_originSize.x, CGRectGetHeight(self.frame) - _originSize.y -height)];
            [second addLineToPoint:P_M(_maxWidth, CGRectGetHeight(self.frame) - _originSize.y - height)];
            
            
            
            CATextLayer *textLayer = [CATextLayer layer];
             
            
            NSInteger pace = _maxHeight / 5;
            NSString *text =[NSString stringWithFormat:@"%ld",(i + 1) * pace];
            CGFloat be = [self getTextWithWhenDrawWithText:text];
            textLayer.frame = CGRectMake(self.originSize.x - be-5 , CGRectGetHeight(self.frame) - _originSize.y -height - 5, be+5, 15);
            
            UIFont *font = [UIFont systemFontOfSize:9];
            CFStringRef fontName = (__bridge CFStringRef)font.fontName;
            CGFontRef fontRef = CGFontCreateWithFontName(fontName);
            textLayer.font = fontRef;
            textLayer.fontSize = font.pointSize;
            CGFontRelease(fontRef);
              textLayer.contentsScale = 2;
            
            textLayer.string = text;
            textLayer.foregroundColor = (_drawTextColorForX_Y==nil?[UIColor blackColor].CGColor:_drawTextColorForX_Y.CGColor);
            [_BGScrollView.layer addSublayer:textLayer];
            [self.layerArr addObject:textLayer];

        }
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        
        shapeLayer.path = second.CGPath;
          if (self.isPro) {
                shapeLayer.strokeColor = [UIColor colorWithWhite:0.9 alpha:1.0].CGColor;
          }else{
          
          shapeLayer.strokeColor = (_dashColor==nil?([UIColor redColor].CGColor):_dashColor.CGColor);
                 [shapeLayer setLineDashPattern:@[@(3),@(3)]];
          }
        
        
        
        shapeLayer.lineWidth = 0.5;
        
       
        
        CABasicAnimation *basic2 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        
        
        basic2.duration = 1.5;
        
        basic2.fromValue = @(0);
        
        basic2.toValue = @(1);
        
        basic2.autoreverses = NO;
        
        
        
        basic2.fillMode = kCAFillModeForwards;
        
        [shapeLayer addAnimation:basic2 forKey:nil];
        
        [self.BGScrollView.layer addSublayer:shapeLayer];
        [self.layerArr addObject:shapeLayer];
        
    }
    
    
    
#pragma mark ----关键页面的x轴的坐标显示
    /*        绘制X轴提示语  不管是否设置了是否绘制X、Y轴 提示语都应有         */
    if (_xShowInfoText.count == _valueArr.count&&_xShowInfoText.count>0) {
        
        NSInteger count = [_valueArr[0] count];
        
        for (NSInteger i = 0; i<_xShowInfoText.count; i++) {
            

            
            CATextLayer *textLayer = [CATextLayer layer];
            
              textLayer.contentsScale = 2.0;
            CGFloat wid =  count * _columnWidth;
            
            
            CGSize size = [_xShowInfoText[i] boundingRectWithSize:CGSizeMake(wid, MAXFLOAT) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} context:nil].size;
              if (self.isKey) {
                    if (i == 1 || i ==3) {
                          
                          
                          if (i ==1) {
                                 textLayer.frame = CGRectMake( i * (count * _columnWidth + _typeSpace) + _typeSpace + _originSize.x-20, CGRectGetHeight(self.frame) - _originSize.y+5,wid*2, size.height+10);
                                
                                //textLayer.frame.origin.x = 30;
                          }else{
                          
                           textLayer.frame = CGRectMake( i * (count * _columnWidth + _typeSpace) + _typeSpace + _originSize.x-10, CGRectGetHeight(self.frame) - _originSize.y+5,wid*2, size.height+10);
                          }
                         
                          
                          textLayer.string = _xShowInfoText[i];
                          
                          UIFont *font = [UIFont systemFontOfSize:14];
                          textLayer.fontSize = font.pointSize;
                          textLayer.foregroundColor = _drawTextColorForX_Y.CGColor;
                          
                          textLayer.alignmentMode = kCAAlignmentCenter;
                          
                          [_BGScrollView.layer addSublayer:textLayer];
                          
                          [self.layerArr addObject:textLayer];
                    }
              }else{
              
                    textLayer.frame = CGRectMake( i * (count * _columnWidth + _typeSpace) + _typeSpace + _originSize.x, CGRectGetHeight(self.frame) - _originSize.y+5,wid, size.height);
                    textLayer.string = _xShowInfoText[i];
                    UIFont *font = [UIFont systemFontOfSize:11];
                    
                    textLayer.fontSize = font.pointSize;
                    textLayer.contentsScale = 3.0;
                    textLayer.foregroundColor = _drawTextColorForX_Y.CGColor;
                    
                    textLayer.alignmentMode = kCAAlignmentCenter;
                    
                    [_BGScrollView.layer addSublayer:textLayer];
                    
                    [self.layerArr addObject:textLayer];
              
              }
            
            
            
            
            
        }
        
        
    }
    
    
    
    
    
    
    /*        动画展示         */
    for (NSInteger i = 0; i<_valueArr.count; i++) {
        
        
        NSArray *arr = _valueArr[i];

        for (NSInteger j = 0; j<arr.count; j++) {
            

            CGFloat height = [NSString stringWithFormat:@"%@",arr[j]].floatValue/_maxHeight * (CGRectGetHeight(self.frame) - 30 -   _originSize.y-1);
            

            UIView *itemsView = [UIView new];
            [self.showViewArr addObject:itemsView];
             
              
              itemsView.frame = CGRectMake((i * arr.count + j)*_columnWidth+ + i*_typeSpace+_originSize.x + _typeSpace, CGRectGetHeight(self.frame) - _originSize.y-1, _columnWidth, 0);
              
              if (self.isKey) {
                    
                   
                    if (i==0) {
                          if (j==0) {
                                itemsView.backgroundColor = kUIColorFromRGB(0x0ead6b);

                          }else{
                                itemsView.backgroundColor = kUIColorFromRGB(0xfd9602);
                          }
                                              }
                    if (i == 1) {
                          if (j ==0) {
                                itemsView.backgroundColor = kUIColorFromRGB(0x0ead6b);
                          }else{
                          
                                 itemsView.backgroundColor = kUIColorFromRGB(0xfd9602);
                          }
                          
                    }if (i == 2) {
                          if (j == 0) {
                                itemsView.backgroundColor = kUIColorFromRGB(0xfd9602);
                          }else{
                          
                                itemsView.backgroundColor = kUIColorFromRGB(0x00a5d3);
                          }
                          
                    }if (i==3) {
                          if (j == 0) {
                                itemsView.backgroundColor = kUIColorFromRGB(0xff562f);
                          }else{
                          
                                itemsView.backgroundColor = kUIColorFromRGB(0x00a5d3);
                          }
                          
                    }
                    if (i == 4) {
                          if (j == 0) {
                                itemsView.backgroundColor = kUIColorFromRGB(0xfd9602);

                          }else{
                          itemsView.backgroundColor = kUIColorFromRGB(0x00a5d3);
                          
                          }
                                              }if (i == 5) {
                                                    if (j == 0) {
                                                           itemsView.backgroundColor = kUIColorFromRGB(0xfd9602);
                                                    }else{
                                                    
                                                          itemsView.backgroundColor = kUIColorFromRGB(0xe4e9e9);
                                                    }
                         
                    }

              }else{
              itemsView.backgroundColor = (UIColor *)(_columnBGcolorsArr.count<arr.count?[UIColor greenColor]:_columnBGcolorsArr[j]);
              
              }
                          [UIView animateWithDuration:1 animations:^{
                  
                  
                                if (self.isKey) {
                                      if (i>=3) {
                                            itemsView.frame = CGRectMake((i * arr.count + j)*_columnWidth + i*_typeSpace+_originSize.x + _typeSpace+20, CGRectGetHeight(self.frame) - height - _originSize.y -1, _columnWidth, height);
                                      }else{
                                      itemsView.frame = CGRectMake((i * arr.count + j)*_columnWidth + i*_typeSpace+_originSize.x + _typeSpace, CGRectGetHeight(self.frame) - height - _originSize.y -1, _columnWidth, height);
                                      
                                      }
                                      
                                }else{
                                itemsView.frame = CGRectMake((i * arr.count + j)*_columnWidth + i*_typeSpace+_originSize.x + _typeSpace, CGRectGetHeight(self.frame) - height - _originSize.y -1, _columnWidth, height);
                                
                                }
                
                  
                
            } completion:^(BOOL finished) {
                  
#pragma mark ----动画结束后添加提示文字---
                /*        动画结束后添加提示文字         */
                if (finished) {
                    
                    CATextLayer *textLayer = [CATextLayer layer];
                    
                    [self.layerArr addObject:textLayer];
                   // NSString *str = [NSString stringWithFormat:@"%.2f",[arr[j] floatValue]];
                      NSString *str = [Tools getNumberTwo:arr[j]];
                      
                    
                                         CGSize size = [str boundingRectWithSize:CGSizeMake(_columnWidth+10, MAXFLOAT) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
                      
                      
                     // textLayer.font = [UIFont systemFontOfSize:12];
                      
            if (self.isKey) {
                            
                  if (i >=3) {
                                  textLayer.frame = CGRectMake((i * arr.count + j)*_columnWidth + i*_typeSpace+_originSize.x+20 + _typeSpace, CGRectGetHeight(self.frame) - height - _originSize.y -3 - size.width, size.width+15, size.height);
                            }else{
                            
                        textLayer.frame = CGRectMake((i * arr.count + j)*_columnWidth + i*_typeSpace+_originSize.x + _typeSpace, CGRectGetHeight(self.frame) - height - _originSize.y -3 - size.width, size.width+15, size.height);
                            }
                            
                      }else{
                      
                       textLayer.frame = CGRectMake((i * arr.count + j)*_columnWidth + i*_typeSpace+_originSize.x + _typeSpace, CGRectGetHeight(self.frame) - height - _originSize.y -3 - size.width+10, _columnWidth+10, size.height);
                      }
                     
                      if ([str isEqualToString:@"0"]) {
                            str = @"";
                      }

                      
                    textLayer.string = str;
                    
                    textLayer.fontSize = 12.0;
                      textLayer.contentsScale = 3.0;
                    
                    textLayer.alignmentMode = kCAAlignmentCenter;
                    
                      if (self.isKey) {
                            if (j%2) {
                                  textLayer.foregroundColor = [UIColor blackColor].CGColor;
                            }else{
                                  textLayer.foregroundColor = itemsView.backgroundColor.CGColor;
                            
                            }
                            
                      }else{
                      
                            textLayer.foregroundColor = itemsView.backgroundColor.CGColor;
                      }
                    
                    
                    [_BGScrollView.layer addSublayer:textLayer];
                    
                }
                
            }];
            
            [self.BGScrollView addSubview:itemsView];
            

        }
        
    }
    
    
    
    
    
}


-(void)clear{
    
    
    for (CALayer *lay in self.layerArr) {
        [lay removeAllAnimations];
        [lay removeFromSuperlayer];
    }
    
    for (UIView *subV in self.showViewArr) {
        [subV removeFromSuperview];
    }
    
}









@end
