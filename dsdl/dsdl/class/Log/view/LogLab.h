//
//  LogLab.h
//  dsdl
//
//  Created by 廉英雷 on 16/11/21.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogLab : UIView
@property (weak, nonatomic) IBOutlet UILabel *leftLab;
@property (weak, nonatomic) IBOutlet UILabel *rightLab;

@property (nonatomic, weak) UILabel *lLab;

@property (nonatomic, weak) UILabel *rLab;
@end
