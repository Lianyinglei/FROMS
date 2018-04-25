//
//  IndicatorCollectionReusableView.h
//  dsdl
//
//  Created by 廉英雷 on 16/12/8.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndicatorCollectionReusableView : UICollectionReusableView

@property (nonatomic, weak) UILabel *labView;

+ (id)headViewWithCollectionView:(UICollectionView *)collectionView andIndexPath:(NSIndexPath *)indexPath;
@end
