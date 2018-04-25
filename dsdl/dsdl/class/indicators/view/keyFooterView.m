//
//  keyFooterView.m
//  dsdl
//
//  Created by 廉英雷 on 16/12/1.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import "keyFooterView.h"
#import "NSString+Extension.h"

@interface keyFooterView ()

@end
@implementation keyFooterView


- (instancetype)initWithFrame:(CGRect)frame{

      if (self = [super initWithFrame:frame]) {
            [self creatView];
      }
      return self;
}

- (void)creatView{

//      CGFloat hight = self.height/3;
//      CGFloat colorW = 10;
//      UIView *colorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, colorW, colorW)];
//      colorView.backgroundColor = kUIColorFromRGB(0x0ead6b);
//      [self addSubview:colorView];
//      
//      
//      NSString *str = @"当月累计发电量:";
//      CGSize labSize = [str sizeWithFont:[UIFont systemFontOfSize:14]];
//      UILabel *leftLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(colorView.frame)+2, colorView.y, labSize.width, labSize.height)];
//      [self addSubview:leftLab];
//      //数据
//      UILabel *numLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftLab.frame)+2, leftLab.y, 40, labSize.height)];
//      [self addSubview:numLab];
//      numLab.textAlignment = NSTextAlignmentLeft;
//      numLab.font = [UIFont systemFontOfSize:14];
//      numLab.textColor = kUIColorFromRGB(0x333333);
//      
//      //偏差
//      UILabel *pianLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(numLab.frame)+10, numLab.y, 30, labSize.height)];
//      pianLab.text = @"偏差:";
//      pianLab.textColor = kUIColorFromRGB(0x333333);
//      [self addSubview:pianLab];
//      pianLab.font = [UIFont systemFontOfSize:14];
      
     
      
      

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
