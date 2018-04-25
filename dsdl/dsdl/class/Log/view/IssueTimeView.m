//
//  IssueTimeView.m
//  outDoor
//
//  Created by 廉英雷 on 16/7/7.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import "IssueTimeView.h"

@interface IssueTimeView ()

@property(weak, nonatomic) UIView *cover;


@property (weak, nonatomic) UIView *bottom;

@property (strong, nonatomic) UIView *contentView;

@end

@implementation IssueTimeView


-(instancetype)initWithFrame:(CGRect)frame
{
      if (self = [super initWithFrame:frame]) {
            
            UIView *cover = [[UIView alloc]init];
            cover.backgroundColor = [UIColor clearColor];
            self.cover = cover;
            [self addSubview:cover];
            
            UIView *bottom = [[UIView alloc]init];
            bottom.backgroundColor = [UIColor blueColor];
            bottom.userInteractionEnabled = YES;
            self.bottom = bottom;
            [self addSubview:bottom];
            
      }
      return self;
}

-(instancetype)initWithContentView:(UIView *)contentView;
{
      self.contentView = contentView;
      
      if (self = [super init]) {
            
      }
      return self;
}

+(instancetype)popViewWithContentView:(UIView *)contentView;
{
      return [[self alloc]initWithContentView:contentView];
}

-(void)showInRect:(CGRect)rect
{
      self.bottom.frame = rect;
      
      UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
      
      self.frame = window.bounds;
      
      self.contentView.x = 0;
      self.contentView.y = 0;
      self.contentView.width = self.bottom.width;
      self.contentView.height = self.bottom.height;
      
      [self.bottom addSubview:self.contentView];
      
      [window addSubview:self];
      
}

-(void)layoutSubviews
{
      [super layoutSubviews];
      
      self.cover.frame = [UIScreen mainScreen].bounds;
      
}

-(void)setDimBackground:(BOOL)dimBackground
{
      _dimBackground = dimBackground;
      
      // 改变cover的背景
      if (dimBackground) {
            self.cover.backgroundColor = [UIColor blackColor];
            self.cover.alpha = 0.2;
      }
      else
      {
            self.cover.backgroundColor = [UIColor clearColor];
            self.cover.alpha = 1.0;
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
