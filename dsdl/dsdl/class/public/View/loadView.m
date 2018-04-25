//
//  loadView.m
//  ehking-pos-ios
//
//  Created by 廉英雷 on 15/9/30.
//  Copyright © 2015年 ehking. All rights reserved.
//

#import "loadView.h"
#define loadImageViewWidth 78
#define  _height  [[UIScreen mainScreen] bounds].size.height

#define  _width   [[UIScreen mainScreen] bounds].size.width
@implementation loadView

-(instancetype)initWithFrame:(CGRect)frame
{
      if (self=[super initWithFrame:frame]) {
            
            self.activtyView=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            self.activtyView.color=[UIColor whiteColor];
            self.activtyView.center=self.center;
            
            self.textLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.activtyView.frame), _width, 40)];
            self.textLabel.textAlignment=NSTextAlignmentCenter;
            self.textLabel.textColor=[UIColor blackColor];
            
            [self addSubview:self.activtyView];
            [self addSubview:self.textLabel];
            
            self.backgroundColor=[[UIColor darkGrayColor] colorWithAlphaComponent:0.1];
            
//            self.loadImageView=[[UIImageView alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.frame)-loadImageViewWidth)/2, (CGRectGetHeight(self.frame)-loadImageViewWidth)/2, loadImageViewWidth, loadImageViewWidth)];
//            NSMutableArray * images=[[NSMutableArray alloc]init];
//            for (int i=1;i<6; i++) {
//                  
//                  UIImage * image=[UIImage imageNamed:[NSString stringWithFormat:@"ds_load_plane_%d",i]];
//                  [images addObject:image];
//            }
//            self.loadImageView.animationDuration=0.2;
//            self.loadImageView.animationImages=images;
//            
//            self.progressImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, loadImageViewWidth, loadImageViewWidth)];
//            self.progressImageView.image=[UIImage imageNamed:@"load_progress"];
//            
//            [self.loadImageView addSubview:self.progressImageView];
//            
//            [self addSubview:_loadImageView];
            
      }
      
      return self;
}

-(void)startLoadWithTitle:(NSString *)title;
{
      if (title) {
            self.textLabel.text=title;
      }else{
            self.textLabel.text=@"正在努力为您加载中……";
      }
      [self.activtyView startAnimating];
      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
      
      
}

-(void)stopLoading;
{
      [self.activtyView stopAnimating];
      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
      
}


@end
