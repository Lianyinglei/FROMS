//
//  LogLab.m
//  dsdl
//
//  Created by 廉英雷 on 16/11/21.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import "LogLab.h"

@implementation LogLab

- (instancetype)initWithFrame:(CGRect)frame{

      if (self = [super initWithFrame:frame]) {
            self.backgroundColor = [UIColor whiteColor];
             [self creatView];
      }
      return self;
}

- (void)creatView{

      
      UILabel *lLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, self.height)];
      [self addSubview:lLab];
      lLab.backgroundColor = [UIColor clearColor];
      lLab.textAlignment = NSTextAlignmentCenter;
      lLab.textColor = [UIColor blackColor];
      self.lLab = lLab;
      lLab.font = [UIFont systemFontOfSize:13];
      
      UILabel *rLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lLab.frame), 0, self.width - lLab.width, self.height)];
      [self addSubview:rLab];
      rLab.backgroundColor = [UIColor clearColor];
      rLab.textAlignment = NSTextAlignmentLeft;
      rLab.textColor = [UIColor blackColor];
      self.rLab = rLab;
      rLab.font = [UIFont systemFontOfSize:13];
      
      
      

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
