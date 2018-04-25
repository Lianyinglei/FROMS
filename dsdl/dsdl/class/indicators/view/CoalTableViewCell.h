//
//  CoalTableViewCell.h
//  dsdl
//
//  Created by 廉英雷 on 16/11/17.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoalTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *coalLab;
@property (weak, nonatomic) IBOutlet UILabel *oneLab;
@property (weak, nonatomic) IBOutlet UILabel *twoLab;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end
