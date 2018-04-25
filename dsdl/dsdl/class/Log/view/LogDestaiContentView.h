//
//  LogDestaiContentView.h
//  dsdl
//
//  Created by 廉英雷 on 16/12/7.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LogModel;

@interface LogDestaiContentView : UIView

@property (nonatomic, strong) NSMutableArray *dateFrameAry;

@property (nonatomic, strong) NSMutableArray *leftDataAry;

@property (nonatomic, strong) NSMutableArray *headArray;

@property (nonatomic, strong) LogModel *logModel;

@end
