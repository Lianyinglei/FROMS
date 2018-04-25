//
//  IndicatorCollectionViewCell.h
//  dsdl
//
//  Created by 廉英雷 on 16/11/11.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndicatorCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *textLab;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgViewW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgViewH;

@end
