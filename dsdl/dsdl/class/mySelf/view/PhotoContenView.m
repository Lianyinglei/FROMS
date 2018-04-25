//
//  PhotoContenView.m
//  dsdl
//
//  Created by 廉英雷 on 17/1/5.
//  Copyright © 2017年 廉英雷. All rights reserved.
//

#import "PhotoContenView.h"
#import "PhotoCollectionViewCell.h"

@interface PhotoContenView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, weak) UICollectionView *collectionView;


@end

@implementation PhotoContenView

- (instancetype)initWithFrame:(CGRect)frame{
      
      
      if (self = [super initWithFrame:frame]) {
            [self creatView];
      }
      return self;
}

- (void)setTextAry:(NSArray *)textAry{

      _textAry = textAry;
      [self.collectionView reloadData];
}



//- (NSArray *)textAry{
//      
//      if (!_textAry) {
//            
//            _textAry = @[@"tu01",@"tu02",@"tu03",@"tu04",@"tu05",@"tu06"];
//      }
//      
//      return _textAry;
//}


//- (void)setImageAry:(NSArray *)imageAry{
//      _imageAry = imageAry;
//      [self.collectionView reloadData];
//      
//}

//- (NSArray *)imageAry{
//
//      if (!_imageAry) {
//
//            _imageAry = @[@[@"gjzb_icon.png",@"mhzb_icon",@"jzzb_icon",@"hbzb_icon",@"chzb.png",@"tptj.png"],@[@"zhongdian",@"duibiao",@"dangqun"],@[@"grxx_icon"]];
//            _imageAry = @[@[@"gjzb",@"meihao",@"jzzb",@"hbzb",@"rlzb",@"zycs"]];
//      }
//      return _imageAry;
//}
//- (void)setTextAry:(NSArray *)textAry{
//      
//      _textAry = textAry;
//      
//      
//      [self.collectionView reloadData];
//}


- (void)creatView{
      
      CGFloat itemW = (_width -45)/3 -1;
      UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
      layout.itemSize = CGSizeMake(itemW, itemW);
      //item间距
      layout.minimumInteritemSpacing = 5;
      layout.minimumLineSpacing = 5;
      layout.scrollDirection = UICollectionViewScrollDirectionVertical;
       layout.sectionInset = UIEdgeInsetsMake(15, 15, 0, 15);
      
      UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
      self.collectionView = collectionView;
      [self addSubview:collectionView];
      collectionView.backgroundColor = kUIColorFromRGB(0xf9f9f9);
      collectionView.delegate = self;
      collectionView.dataSource = self;
      self.collectionView = collectionView;
      collectionView.showsHorizontalScrollIndicator = YES;
      collectionView.scrollEnabled = NO;
      
      //      [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"IndicatorCell"];
      [self.collectionView registerNib:[UINib nibWithNibName:@"PhotoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"photoCell"];
      //  [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
      
}

#pragma mark -- collectionviewdelegate


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
      
      return self.textAry.count;
     }


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
      
      PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoCell" forIndexPath:indexPath];
      
      cell.imgView.image = [UIImage imageNamed:self.textAry[indexPath.row]];
      cell.imgView.contentMode =  UIViewContentModeScaleAspectFit;
      cell.imgView.backgroundColor = [UIColor whiteColor];
      
      cell.contentView.layer.cornerRadius = 5;
      cell.contentView.layer.masksToBounds = YES;
      cell.contentView.layer.borderWidth = 1.0;
      cell.contentView.layer.borderColor = themeColor.CGColor;
      
      return cell;
      
}



//定义每个UICollectionViewCell 的大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//      
//            return CGSizeMake((self.width -40)/3, (self.width -40)/3);
//      
//      
//}

//定义每个Section 的 margin
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//      return UIEdgeInsetsMake(0, 0, 0, 0);//分别为上、左、下、右
//}

//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//      
//      if (self.isHome) {
//            CGSize size={_width,0};
//            return size;
//      }else{
//            CGSize size={_width,40};
//            return size;
//      }
//      
//}

//点击cell事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
      
      
      if ([self.delegate respondsToSelector:@selector(deseleCollectionCell:)]) {
            
            [self.delegate deseleCollectionCell:indexPath];
      }
      
      
     //  [collectionView deselectItemAtIndexPath:indexPath animated:YES];
      
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
