//
//  TodoContentCell.h
//  dsdl
//
//  Created by 廉英雷 on 16/12/6.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodoContentCell : UITableViewCell

//序号
@property (weak, nonatomic) IBOutlet UILabel *noLab;
//库房
@property (weak, nonatomic) IBOutlet UILabel *kuLab;
@property (weak, nonatomic) IBOutlet UILabel *headLab;

@property (weak, nonatomic) IBOutlet UILabel *desLab;

//单位成本
@property (weak, nonatomic) IBOutlet UILabel *danLab;
//要求数量
@property (weak, nonatomic) IBOutlet UILabel *numLab;

//行成本
@property (weak, nonatomic) IBOutlet UILabel *xingLab;

@end
