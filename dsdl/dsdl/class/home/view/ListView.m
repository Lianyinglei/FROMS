//
//  ListView.m
//  dsdl
//
//  Created by 廉英雷 on 16/11/10.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import "ListView.h"
#import "LeftView.h"

@interface ListView ()

@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic,strong) NSArray *textAry;

@end
@implementation ListView


- (void)setDataAry:(NSArray *)dataAry{

      _dataAry = dataAry;
}
- (instancetype)initWithFrame:(CGRect)frame{


      if (self = [super initWithFrame:frame]) {
            [self contentView];
      }
      return self;
}

- (void)layoutSubviews{

      [super layoutSubviews];
      [self contentView];
}

- (void)contentView{
      
      //左侧的头部view
      LeftView *leftView = [[NSBundle mainBundle] loadNibNamed:@"LeftView" owner:self options:nil].lastObject;
      leftView.frame = CGRectMake(0, 0, 120, self.height);
//      leftView.todayLab.textColor = kUIColorFromRGB(0xa88fd6);
//      leftView.yestadayLab.textColor = kUIColorFromRGB(0x11afea);
      leftView.leftHeadLab.backgroundColor = [UIColor whiteColor];
      leftView.leftDayView.backgroundColor = kUIColorFromRGB(0xc9f4f3);
      leftView.leftYesDayView.backgroundColor = kUIColorFromRGB(0xc9f4f3);
      [self addSubview:leftView];
      
      UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftView.frame), 0, self.width - leftView.width, self.height)];
      scrollView.contentSize = CGSizeMake(_width *2+120, scrollView.height);
      [self addSubview:scrollView];
      self.scrollView = scrollView;
      self.scrollView.showsHorizontalScrollIndicator = NO;
      self.scrollView.backgroundColor = [UIColor whiteColor];
      [self labView];
      

}

- (void)labView{

      CGFloat height = 50;
      UIView *labView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.contentSize.width, height)];
      
     
      CGFloat width = labView.width/10;
      
      for (int i = 0; i<10;i++) {
            
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(width *i, 0, width, height)];
            lab.numberOfLines = 0;
            lab.textAlignment = NSTextAlignmentCenter;
            lab.font = [UIFont systemFontOfSize:15];
            [self.scrollView addSubview:lab];
            lab.backgroundColor = [UIColor whiteColor];
            lab.text = self.textAry[i];
           
      }
      [self.scrollView addSubview:labView];
      
      CGFloat labH = (self.scrollView.height - height)*0.25;
      
     
      
      for (int j = 0; j<4; j++) {
            CGFloat y = j *labH;
            
            for (int i = 0 ; i< 10; i++) {
                  UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(width *i, height+ y, width, labH)];
                  [self.scrollView addSubview:lab];
                  
                  lab.textAlignment = NSTextAlignmentCenter;
                  
                  lab.text = self.dataAry[i];
                  
                 //  lab.backgroundColor = [UIColor whiteColor];
//                  if (j<2) {
////                        lab.backgroundColor = [UIColor colorWithRed:137/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
//                  }else{
//                       
//                  }

                  
            }
           

      }
           }

- (NSArray *)textAry{
      if (!_textAry) {
            _textAry = @[@"功率 \n (MW)",@"主汽压力\n(MPa)",@"主汽温度\n（℃）",@"再热温度\n（℃）",@"给水温度\n（℃）",@"真空\n（kPa）",@"排烟温度\n（℃）",@"氧量\n（%）",@"锅炉热效率\n（%）",@"汽机热耗\n(kj/kwh)"];
      }
      return _textAry;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
