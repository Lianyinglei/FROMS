//
//  IndicatorContentView.m
//  dsdl
//
//  Created by 廉英雷 on 16/11/11.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import "IndicatorContentView.h"
#import "KeyViewController.h"
#import "IndicatorCollectionReusableView.h"

#import "IndicatorCollectionViewCell.h"
@interface IndicatorContentView ()<UICollectionViewDataSource,UICollectionViewDelegate>


@property (nonatomic, weak) UICollectionView *collectionView;




@end

@implementation IndicatorContentView



- (instancetype)initWithFrame:(CGRect)frame{


      if (self = [super initWithFrame:frame]) {
            [self creatView];
      }
      return self;
}

- (void)setImageAry:(NSArray *)imageAry{
      _imageAry = imageAry;
      [self.collectionView reloadData];

}

//- (NSArray *)imageAry{
//
//      if (!_imageAry) {
//            
//            _imageAry = @[@[@"gjzb_icon.png",@"mhzb_icon",@"jzzb_icon",@"hbzb_icon",@"chzb.png",@"tptj.png"],@[@"zhongdian",@"duibiao",@"dangqun"],@[@"grxx_icon"]];
//            _imageAry = @[@[@"gjzb",@"meihao",@"jzzb",@"hbzb",@"rlzb",@"zycs"]];
//      }
//      return _imageAry;
//}
- (void)setTextAry:(NSArray *)textAry{

      _textAry = textAry;
      
      
      [self.collectionView reloadData];
}
//- (NSArray *)textAry{
//
//      if (!_textAry) {
//            _textAry = @[@[@"关键指标",@"煤耗指标",@"机组指标",@"环保指标"],@[@"个人信息",@""]];
//      }
//      
//      return _textAry;
//}
- (void)creatView{
      
      CGFloat itemW = _width*0.5 -1.5;
      UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
      layout.itemSize = CGSizeMake(itemW, itemW);
      //item间距
      layout.minimumInteritemSpacing = 0.5;
      layout.minimumLineSpacing = 0.5;
      layout.scrollDirection = UICollectionViewScrollDirectionVertical;
     // layout.sectionInset = UIEdgeInsetsMake(30, 10, 30, 10);

      UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
      [self addSubview:collectionView];
      collectionView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
      collectionView.delegate = self;
      collectionView.dataSource = self;
      self.collectionView = collectionView;
      collectionView.showsHorizontalScrollIndicator = YES;
      collectionView.scrollEnabled = NO;
     
//      [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"IndicatorCell"];
      [self.collectionView registerNib:[UINib nibWithNibName:@"IndicatorCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"IndicatorCell"];
    //  [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
      
}

#pragma mark -- collectionviewdelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
      return self.textAry.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
      
      if (section == 0) {
            NSArray *ary = self.textAry[0];
            return ary.count;
      }if (section==1) {
            NSArray *ary = self.textAry[1];
            return ary.count;
      }
      
      else{
      
            NSArray *ary = self.textAry[2];
            return ary.count;
      }
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

      IndicatorCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IndicatorCell" forIndexPath:indexPath];

      cell.backgroundColor = [UIColor colorWithRed:(float)(arc4random_uniform(256)/255.0) green:(float) (arc4random_uniform(256)/255.0) blue: (float)(arc4random_uniform(256)/255.0) alpha:1.0];
//      UILabel *lab =[[UILabel alloc] initWithFrame:CGRectMake(0, 50, 80, 30)];
//      [cell.contentView addSubview:lab];
//      int num = arc4random_uniform(100);
//      NSString *str1 = [NSString stringWithFormat:@"￥%d元",num];
//      NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:str1];
//      NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor redColor]};
//      [str setAttributes:dic range:NSMakeRange(0, 1)];
//      
//      lab.attributedText = str;
//      lab.textAlignment = NSTextAlignmentCenter;
      cell.backgroundColor = [UIColor whiteColor];
      NSArray *ary  = self.textAry[indexPath.section];
      cell.textLab.text = ary[indexPath.item];
      NSArray *imgAry = self.imageAry[indexPath.section];
      cell.imgView.image = [UIImage imageNamed:imgAry[indexPath.item]];
      cell.imgView.contentMode = UIViewContentModeScaleAspectFit;
      if (!self.isHome) {
            
            cell.imgViewH.constant = 45;
            cell.imgViewW.constant = 45;
      }
      
      if (_width == IPHONE5W) {
            cell.imgViewH.constant = 35;
            cell.imgViewW.constant = 35;
      }
      
      return cell;


}



- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
      
      
      
      IndicatorCollectionReusableView * view = [IndicatorCollectionReusableView headViewWithCollectionView:collectionView andIndexPath:indexPath];

      
      if (indexPath.section == 0) {
           view.labView.text = @"  企业服务";
         
      }if (indexPath.section ==1) {
            
           view.labView.text = @"  个人信息";
          
      }
      
      return view;
}
//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
      if (self.isHome) {
            return CGSizeMake((_width -1)/3, self.height*0.5);
      }else{
      
            return CGSizeMake((_width -1)/3, (self.height -120)*0.25);
      }
      
}

//定义每个Section 的 margin
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//      return UIEdgeInsetsMake(0, 0, 0, 0);//分别为上、左、下、右
//}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
      
      if (self.isHome) {
            CGSize size={_width,0};
            return size;
      }else{
            CGSize size={_width,40};
            return size;
      }
     
}

//点击cell事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

      
            
                  
                  if ([self.delegate respondsToSelector:@selector(deseleCollectionCell:)]) {
                        
                        [self.delegate deseleCollectionCell:indexPath];
                  }
            
      
     // [collectionView deselectItemAtIndexPath:indexPath animated:YES];

}


@end
