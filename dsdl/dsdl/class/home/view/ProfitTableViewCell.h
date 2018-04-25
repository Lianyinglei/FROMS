//
//  ProfitTableViewCell.h
//  dsdl
//
//  Created by 廉英雷 on 16/11/8.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfitTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *destaiLab;
@property (weak, nonatomic) IBOutlet UILabel *numLab;

@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineViewW;
@end
