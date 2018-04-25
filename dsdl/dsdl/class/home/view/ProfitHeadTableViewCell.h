//
//  ProfitHeadTableViewCell.h
//  dsdl
//
//  Created by 廉英雷 on 16/11/9.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfitHeadTableViewCell : UITableViewCell

//日期
@property (weak, nonatomic) IBOutlet UILabel *dateLab;

//发电量
@property (weak, nonatomic) IBOutlet UILabel *proLab;

//供热量
@property (weak, nonatomic) IBOutlet UILabel *heatLab;

//综合用电率
@property (weak, nonatomic) IBOutlet UILabel *proLLab;


@end
