//
//  LeftView.h
//  dsdl
//
//  Created by 廉英雷 on 16/11/10.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftView : UIView
@property (weak, nonatomic) IBOutlet UIView *leftDayView;

@property (weak, nonatomic) IBOutlet UILabel *todayLab;
@property (weak, nonatomic) IBOutlet UILabel *yestadayLab;
@property (weak, nonatomic) IBOutlet UILabel *leftHeadLab;

@property (weak, nonatomic) IBOutlet UIView *leftYesDayView;

@end
