//
//  IndicatorCollectionReusableView.m
//  dsdl
//
//  Created by 廉英雷 on 16/12/8.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import "IndicatorCollectionReusableView.h"

@implementation IndicatorCollectionReusableView

+ (id)headViewWithCollectionView:(UICollectionView *)collectionView andIndexPath:(NSIndexPath *)indexPath
{
      [collectionView registerClass:[IndicatorCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
      
      IndicatorCollectionReusableView * headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
      
      return headView;
}

- (instancetype)initWithFrame:(CGRect)frame{
      self = [super initWithFrame:frame];
      if (self) {
            [self headView];
      }
      return self;
}
- (void)headView{

      UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
      self.labView = lab;
      lab.textColor = [UIColor blackColor];
      [self addSubview:lab];

}


@end
