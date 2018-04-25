//
//  LogContentView.h
//  dsdl
//
//  Created by 廉英雷 on 16/11/15.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LogContentViewDelegate <NSObject>

@optional

- (void)deseleLogCollectionCell:(NSIndexPath *)indexPath withId:(NSString *)logId;


@end

@interface LogContentView : UIView

@property (nonatomic, weak) id<LogContentViewDelegate>delegate;

@property (nonatomic, strong) NSMutableArray *dataAry;
@end
