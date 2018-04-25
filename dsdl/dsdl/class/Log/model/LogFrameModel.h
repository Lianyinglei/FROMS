//
//  LogFrameModel.h
//  dsdl
//
//  Created by 廉英雷 on 16/11/28.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LogDestailModel;
@interface LogFrameModel : NSObject

@property (nonatomic, strong) LogDestailModel *logDestailModel;

//编号
@property (nonatomic, assign) CGRect numLabF;

@property (nonatomic, assign) CGRect numLabRF;


//描述内容
@property (nonatomic, assign) CGRect describLabF;
@property (nonatomic, assign) CGRect describLabRF;

//执行
@property (nonatomic, assign) CGRect performF;
@property (nonatomic, assign) CGRect performRF;

//顺延
@property (nonatomic, assign) CGRect postLabF;
@property (nonatomic, assign) CGRect postLabRF;

//顺延原因
@property (nonatomic, assign) CGRect pWhyLabF;
@property (nonatomic, assign) CGRect pWhyLabRF;


@property (nonatomic, assign) CGRect colorViewF;

@property (nonatomic, assign) CGFloat cellHight;

@end
