//
//  KeyRightView.m
//  dsdl
//
//  Created by 廉英雷 on 16/11/14.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import "KeyRightView.h"
#import "LineView.h"
@implementation KeyRightView

- (instancetype)initWithFrame:(CGRect)frame{

      if (self = [super initWithFrame:frame]) {
            self.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
            [self creatContentView];
      }
      
      return self;
}

- (void)creatContentView{

      LineView *lineView = [[LineView alloc] initWithFrame:CGRectMake(0, 0, _width,_height *0.4 )];
      [self addSubview:lineView];
      
      LineView *lineView2 = [[LineView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lineView.frame)+10, _width,_height *0.4)];
      [self addSubview:lineView2];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
