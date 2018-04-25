//
//  PhotoContenView.h
//  dsdl
//
//  Created by 廉英雷 on 17/1/5.
//  Copyright © 2017年 廉英雷. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PhotoContentViewDelegate <NSObject>

@optional

- (void)deseleCollectionCell:(NSIndexPath *)indexPath;
@end


@interface PhotoContenView : UIView


@property (nonatomic,weak) id <PhotoContentViewDelegate>delegate;

@property (nonatomic, strong) NSArray *textAry;
@end
