//
//  LogDestailLeftModel.h
//  dsdl
//
//  Created by 廉英雷 on 16/12/9.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LogDestailModel;
@interface LogDestailLeftModel : NSObject

@property (nonatomic, strong) LogDestailModel *logDestailModel;

//编号
@property (nonatomic, assign) CGRect numLabF;

@property (nonatomic, assign) CGRect numLabRF;


//描述内容
@property (nonatomic, assign) CGRect describLabF;
@property (nonatomic, assign) CGRect describLabRF;

@property (nonatomic, assign) CGFloat cellHight;

@property (nonatomic, assign) CGRect colorViewF;
@end
