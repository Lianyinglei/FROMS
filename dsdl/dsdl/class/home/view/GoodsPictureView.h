//
//  GoodsPictureView.h
//  XianJinBao
//
//  Created by 廉英雷 on 16/3/17.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^GoodsPictureTouchBlock) (NSArray *picArray, NSInteger selectPicIndex);

@protocol GoodsPictureViewDelegate <NSObject>
@optional
- (void)goodsChangeBuy;

@end
@interface GoodsPictureView : UIView
/** 商品图片数组 */
@property(nonatomic, strong) NSArray * pictureArray;

/** 点击头部商品图片 */
@property(nonatomic, copy) GoodsPictureTouchBlock picTouchBlock;

@property(nonatomic,weak) id <GoodsPictureViewDelegate>delegate;




@end
