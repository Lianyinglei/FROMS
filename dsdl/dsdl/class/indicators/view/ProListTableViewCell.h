//
//  ProListTableViewCell.h
//  dsdl
//
//  Created by 廉英雷 on 16/11/25.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *indLab;
@property (weak, nonatomic) IBOutlet UILabel *oneValueLab;
@property (weak, nonatomic) IBOutlet UILabel *oneMaxLab;
@property (weak, nonatomic) IBOutlet UILabel *twoValueLab;
@property (weak, nonatomic) IBOutlet UILabel *twoMaxLab;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end
