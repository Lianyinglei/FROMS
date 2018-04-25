//
//  GoodsPictureView.m
//  XianJinBao
//
//  Created by 廉英雷 on 16/3/17.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import "GoodsPictureView.h"
#import "UIView+XLExtension.h"
//#import "detailGoodView.h"

@interface GoodsPictureView ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

//滚动的页数标识
@property(nonatomic, weak) UIPageControl * pageControl;

//滚动视图
@property(nonatomic, weak) UICollectionView * collectionView;

@end
@implementation GoodsPictureView

- (instancetype)initWithFrame:(CGRect)frame{

      if (self = [super initWithFrame:frame]) {
            [self createSubVIew];
           
      }
      return self;
}

- (void)createSubVIew{

      UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
      //水平滚动
      layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
      //collectionview的每个item之间不留任何空隙
      layout.minimumLineSpacing = 0;
      layout.itemSize = self.bounds.size;
      
      UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, _width, self.height)collectionViewLayout:layout];
      collectionView.backgroundColor = [UIColor clearColor];
      collectionView.dataSource = self;
      collectionView.delegate = self;
      collectionView.pagingEnabled = YES;
      collectionView.showsHorizontalScrollIndicator = NO;
      [self addSubview:collectionView];
      self.collectionView = collectionView;
      
      UIPageControl * pageControl = [[UIPageControl alloc] init];
      pageControl.frame = CGRectMake(15, self.frame.size.height-20, _width, 20);
//      pageControl.frame = CGRectMake(15, collectionView.height -30, collectionView.width, 30);
      pageControl.currentPageIndicatorTintColor = [UIColor redColor];
      [self addSubview:pageControl];
      
      self.pageControl = pageControl;
      
     
         //   [self creatDetailGoodView];
      
      

//      UIButton *footerBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, self.height -40, self.width, 40)];
//      [self addSubview:footerBtn];
//      [footerBtn setTitle:@"选择 尺码 颜色" forState:UIControlStateNormal];
//      [footerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
////      footerBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//      footerBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -_width*0.5, 0, 0);
//      [footerBtn addTarget:self action:@selector(changeSize) forControlEvents:UIControlEventTouchUpInside];
}

//创建图表下边的产品详情界面
- (void)creatDetailGoodView{
//      detailGoodView *detailView = [[NSBundle mainBundle] loadNibNamed:@"detailGoodView" owner:self options:nil].lastObject;
//      detailView.frame = CGRectMake(0, self.height - 113, self.width, 113);
//      [self addSubview:detailView];

}
//选择大小颜色尺码
- (void)changeSize{
      if ([self.delegate respondsToSelector:@selector(goodsChangeBuy)]) {
            [self.delegate goodsChangeBuy];
      }

}


- (void)setPictureArray:(NSArray *)pictureArray
{
      if (pictureArray.count>0)
      {
           // pictureArray = @[@"1",@"2",@"3",@"4"];
            _pictureArray = pictureArray;
            
            self.pageControl.numberOfPages = pictureArray.count;
            [self.collectionView reloadData];
      }
}

#pragma mark - 数据源方法

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
      return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
      return self.pictureArray.count;
      
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
      [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"GoodsPictureCell"];
      UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsPictureCell" forIndexPath:indexPath];
      
    //  GoodsPicture * pic = self.pictureArray[indexPath.item];
      UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width,cell.frame.size.height)];
//      [imgView sd_setImageWithURL:[NSURL URLWithString:@"http://qa.ehking.com/mall/api/custom/goods/detail/ff8080814dd70288014dd755c92d005a"] placeholderImage:[UIImage imageNamed:@"image_placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"firstImage" object:self userInfo:@{@"image":image}];
//      }];
          // imgView.image = [UIImage imageNamed:@"02.png"];
      UIView *view = self.pictureArray[indexPath.item];
      view.frame = self.bounds;
      imgView.backgroundColor = [UIColor greenColor];
      
      [cell.contentView addSubview:view];
      
      return cell;
}


#pragma mark -- UICollectionView 代理方法

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
      //NSLog(@"collectionView didSelectItemAtIndexPath %ld",indexPath.item);
      if (self.picTouchBlock)
      {
            self.pictureArray = @[@"1",@"2",@"3",@"4"];
            self.picTouchBlock(self.pictureArray, indexPath.row);
      }
}



//只要滚动就会调用，根据滚动的位置设置pageControl
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
      int page = (int)(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5) % self.pictureArray.count;
      self.pageControl.currentPage = page;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
