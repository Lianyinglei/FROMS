//
//  FuleModel.h
//  dsdl
//
//  Created by 廉英雷 on 16/12/21.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FuleModel : NSObject

@property(nonatomic,copy) NSString *coalBid;

@property(nonatomic,copy) NSString *creatTime;

@property(nonatomic,copy) NSString *factoryBid;


//指标列表
//"allMoistureV1": "2",
//"allMoistureV2": "2",
//"baseAshV1": "2",
//"baseAshV2": "2",
//"baseLowFeverV1": "2",
//"baseLowFeverV2": "2",
//"createTime": "2017-01-16 12:00:00",
//"dryAshV1": "2",
//"dryAshV2": "2",
//"flyCarbonV1": "2",
//"flyCarbonV2": "2",
//"id": "2",
//"slagCarbonV1": "2",
//"slagCarbonV2": "2"

@property(nonatomic,copy) NSString *allMoistureV1;

@property(nonatomic,copy) NSString *allMoistureV2;

@property(nonatomic,copy) NSString *baseAshV1;

@property(nonatomic,copy) NSString *baseAshV2;

@property(nonatomic,copy) NSString *baseLowFeverV1;

@property(nonatomic,copy) NSString *baseLowFeverV2;

@property(nonatomic,copy) NSString *dryAshV1;

@property(nonatomic,copy) NSString *dryAshV2;

@property(nonatomic,copy) NSString *flyCarbonV1;

@property(nonatomic,copy) NSString *flyCarbonV2;

@property(nonatomic,copy) NSString *slagCarbonV1;

@property(nonatomic,copy) NSString *slagCarbonV2;


@end
