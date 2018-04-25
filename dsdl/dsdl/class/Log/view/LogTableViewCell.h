//
//  LogTableViewCell.h
//  dsdl
//
//  Created by 廉英雷 on 16/11/15.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;

//值别
@property (weak, nonatomic) IBOutlet UILabel *contentLab;

//天气
@property (weak, nonatomic) IBOutlet UILabel *weatherLab;

@end
