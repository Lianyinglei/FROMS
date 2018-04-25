//
//  LeftLine.m
//  dsdl
//
//  Created by 廉英雷 on 16/11/21.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import "LeftLine.h"

@implementation LeftLine

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)drawRect:(CGRect)rect{

      [self test2];
}

//路径
- (void)test2{
      //1
      // CGContextRef context = UIGraphicsGetCurrentContext();
      //2
      UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(5, 5, 10, 10)];
      
      [path moveToPoint:CGPointMake(10.5, 12.5)];
      [path addLineToPoint:CGPointMake(10, self.height- 10)];
      [[UIColor blueColor] setStroke];
      path.lineWidth = 2.0;
      [path stroke];
      
      
      UIBezierPath *path1 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(7.5, 7.5, 5, 5)];
      [path1 setLineWidth:2.0];
      [[UIColor orangeColor] setStroke];
      [path1 stroke];
      
      
}

@end
