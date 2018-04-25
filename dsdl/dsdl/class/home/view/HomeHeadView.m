//
//  HomeHeadView.m
//  dsdl
//
//  Created by 廉英雷 on 16/12/23.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import "HomeHeadView.h"
#import "HomeHeadOneView.h"

@interface HomeHeadView ()

@property (nonatomic, weak) HomeHeadOneView *twoView;

@property (nonatomic, weak) HomeHeadOneView *thridView;

@end

@implementation HomeHeadView

- (void)setDataArray:(NSArray *)dataArray{
      _dataArray = dataArray;
      
      NSArray *dataAry1 = dataArray[0];
      
//      for (int i = 0; i<dataAry1.count; i++) {
//            NSString *str = dataAry1[i];
//            if ([str isEqualToString:@""]) {
//                 
//                  if (i == 0) {
//                        self.twoView.fuLab.text = @"-";
//                  }else{
//                  self.twoView.fuLab.text = [NSString stringWithFormat:@"%.2f",[dataAry1[0] floatValue ]];
//                  }if (i == 1) {
//                        
//                         self.twoView.proLLab.text = @"-";
//                  }else{
//                  
//                         self.twoView.proLLab.text = [NSString stringWithFormat:@"%.2f",[dataAry1[1] floatValue ]];
//                  }
//                  if (i == 2) {
//                        
//                        self.twoView.proLab.text = @"-";
//                  }else{
//                  
//                  self.twoView.proLab.text = [NSString stringWithFormat:@"%.2f",[dataAry1[2] floatValue ]];
//                  }
//                  
//                  if (i == 3) {
//                         self.twoView.heatLab.text = @"-";
//                  }else{
//                  
//                   self.twoView.heatLab.text = [NSString stringWithFormat:@"%.2f",[dataAry1[3] floatValue ]];
//                  }
//            }
//      }
      
//       self.twoView.fuLab.text = [NSString stringWithFormat:@"%.2f",[dataAry1[0] floatValue ]];
//     
//      self.twoView.proLLab.text = [NSString stringWithFormat:@"%.2f",[dataAry1[1] floatValue ]];
//      self.twoView.proLab.text = [NSString stringWithFormat:@"%.2f",[dataAry1[2] floatValue ]];
//       self.twoView.heatLab.text = [NSString stringWithFormat:@"%.2f",[dataAry1[3] floatValue ]];
      
      
       self.twoView.fuLab.text = [Tools getNumberTwo:dataAry1[0]];
      self.twoView.proLLab.text = [[Tools getNumberTwo:dataAry1[1]] stringByAppendingString:@"%"];
      self.twoView.proLab.text = [Tools getNumberTwo:dataAry1[2]];
      self.twoView.heatLab.text = [Tools getNumberTwo:dataAry1[3]];


     
      
     
      
      NSArray *dataAry2 = dataArray[1];
     
//      self.thridView.fuLab.text = [NSString stringWithFormat:@"%.2f",[dataAry2[0] floatValue ]];
//      self.thridView.proLLab.text = [NSString stringWithFormat:@"%.2f",[dataAry2[1] floatValue ]];
//      self.thridView.proLab.text = [NSString stringWithFormat:@"%.2f",[dataAry2[2] floatValue ]];
//      self.thridView.heatLab.text = [NSString stringWithFormat:@"%.2f",[dataAry2[3] floatValue ]];


      self.thridView.fuLab.text = [Tools getNumberTwo:dataAry2[0]];
      self.thridView.proLLab.text = [[Tools getNumberTwo:dataAry2[1]] stringByAppendingString:@"%"];
      self.thridView.proLab.text = [Tools getNumberTwo:dataAry2[2]];
      self.thridView.heatLab.text = [Tools getNumberTwo:dataAry2[3]];



}

- (instancetype)initWithFrame:(CGRect)frame{

      if (self = [super initWithFrame:frame]) {
            
            self.backgroundColor = kUIColorFromRGB(0xedfffc);
            [self creatView];
      }
      return self;
}

- (void)creatView{

      CGFloat width = 40;
      UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _width, width+10)];
      [self addSubview:backView];
      backView.backgroundColor = kUIColorFromRGB(0x1f9d85);
      
      HomeHeadOneView *oneView = [[NSBundle mainBundle] loadNibNamed:@"HomeHeadOneView" owner:self options:nil].lastObject;
      oneView.frame = CGRectMake(10, 0, _width-20, width+10);
      [backView addSubview:oneView];
      oneView.backgroundColor = kUIColorFromRGB(0x1f9d85);
      oneView.fuLab.textColor = [UIColor whiteColor];
      oneView.leftLab.textColor = [UIColor whiteColor];
      oneView.proLab.textColor = [UIColor whiteColor];
      oneView.proLLab.textColor = [UIColor whiteColor];
      oneView.heatLab.textColor = [UIColor whiteColor];
      oneView.leftLab.hidden = YES;
      
      
      HomeHeadOneView *twoView = [[NSBundle mainBundle] loadNibNamed:@"HomeHeadOneView" owner:self options:nil].lastObject;
      twoView.frame = CGRectMake(15, CGRectGetMaxY(oneView.frame)+10 , _width-30, width);
      [self addSubview:twoView];
      twoView.backgroundColor = kUIColorFromRGB(0xa3e5d9);
      twoView.layer.cornerRadius = 6;
      twoView.layer.masksToBounds = YES;
      self.twoView = twoView;
    
      twoView.leftLab.text = @"1#机组";
      twoView.proLLab.text = @"611.2";
      twoView.proLab.text = @"4.97";
      twoView.heatLab.text = @"1220";
      
      
      HomeHeadOneView *thridView = [[NSBundle mainBundle] loadNibNamed:@"HomeHeadOneView" owner:self options:nil].lastObject;
      thridView.frame = CGRectMake(15, CGRectGetMaxY(twoView.frame)+10 , _width-30, width);
      [self addSubview:thridView];
      thridView.backgroundColor = kUIColorFromRGB(0xa3e5d9);
      thridView.layer.cornerRadius = 6;
      thridView.layer.masksToBounds = YES;
      
      self.thridView = thridView;
      thridView.leftLab.text = @"2#机组";
      thridView.proLLab.text = @"611.2";
      thridView.proLab.text = @"4.97";
      thridView.heatLab.text = @"1220";
      
      if (_width == IPHONE5W) {
            
            
            oneView.fuLab.font = [UIFont systemFontOfSize:14];
            oneView.proLab.font = [UIFont systemFontOfSize:14];
            oneView.leftLab.font = [UIFont systemFontOfSize:14];
            oneView.proLLab.font = [UIFont systemFontOfSize:14];
            oneView.heatLab.font = [UIFont systemFontOfSize:14];
            
            // oneView.proLab.textColor = [UIColor redColor];
            twoView.fuLab.font = [UIFont systemFontOfSize:14];
            twoView.proLab.font = [UIFont systemFontOfSize:14];
            twoView.leftLab.font = [UIFont systemFontOfSize:14];
            twoView.proLLab.font = [UIFont systemFontOfSize:14];
            twoView.heatLab.font = [UIFont systemFontOfSize:14];
            
            thridView.fuLab.font = [UIFont systemFontOfSize:14];
            thridView.proLab.font = [UIFont systemFontOfSize:14];
            thridView.leftLab.font = [UIFont systemFontOfSize:14];
           thridView.proLLab.font = [UIFont systemFontOfSize:14];
           thridView.heatLab.font = [UIFont systemFontOfSize:14];

            
      }

      
     
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
