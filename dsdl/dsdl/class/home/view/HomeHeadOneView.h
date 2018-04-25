//
//  HomeHeadOneView.h
//  dsdl
//
//  Created by 廉英雷 on 16/12/23.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeHeadOneView : UIView


//机组lab

@property (weak, nonatomic) IBOutlet UILabel *leftLab;

//发电量
@property (weak, nonatomic) IBOutlet UILabel *proLab;

//供热量
@property (weak, nonatomic) IBOutlet UILabel *heatLab;
@property (weak, nonatomic) IBOutlet UILabel *fuLab;

//负荷率
@property (weak, nonatomic) IBOutlet UILabel *proLLab;
@end
