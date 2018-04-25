//
//  IndicatorContentView.h
//  dsdl
//
//  Created by 廉英雷 on 16/11/11.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol IndicatorContentViewDelegate <NSObject>

@optional

- (void)deseleCollectionCell:(NSIndexPath *)indexPath;
@end

@interface IndicatorContentView : UIView
@property (nonatomic, strong) NSArray *textAry;

@property (nonatomic, strong) NSArray *imageAry;

@property (nonatomic, weak) id<IndicatorContentViewDelegate> delegate;

@property (nonatomic, assign) BOOL isHome;
@end
