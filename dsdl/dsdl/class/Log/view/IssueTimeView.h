//
//  IssueTimeView.h
//  outDoor
//
//  Created by 廉英雷 on 16/7/7.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IssueTimeView : UIView
// 深色背景
@property(assign, nonatomic) BOOL dimBackground;

-(instancetype)initWithContentView:(UIView *)contentView;
+(instancetype)popViewWithContentView:(UIView *)contentView;

-(void)showInRect:(CGRect)rect;
@end
