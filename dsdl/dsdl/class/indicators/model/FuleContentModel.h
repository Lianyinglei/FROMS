//
//  FuleContentModel.h
//  dsdl
//
//  Created by 廉英雷 on 16/12/29.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FuleContentModel : NSObject
//            "chargingCompared": "2", 入炉同比
//            "chargingPrice": "2",入炉价格
//            "chargingSequential": "2",入炉环比
//            "createTime": "2016-12-19 12:00:00",
//            "factoryCombined": "2",入厂合计
//            "factoryCompared": "2",入厂同比
//            "factoryEngineering": "2",入厂工程煤
//            "factoryHighSulfur": "2",入厂中高硫煤
//            "factoryLowSulfur": "2",入厂低硫煤
//            "factoryPrice": "2", 入厂价格
//            "factorySequential": "2",入厂环比
//            "furnaceCombined": "2", 入炉合计
//            "furnaceEngineering": "2",入炉工程煤
//            "furnaceHighSulfur": "2",入炉中高硫煤
//            "furnaceLowSulfur": "2",入炉低硫煤
//            "id": "2",
//            "warehouseCombined": "2",入仓合计
//            "warehouseEngineering": "2",入仓工程煤
//            "warehouseHighSulfur": "2",入仓中高硫煤
//            "warehouseLowSulfur": "2" 入仓低硫煤

@property(nonatomic,copy) NSString *chargingCompared;

@property(nonatomic,copy) NSString *chargingPrice;

@property(nonatomic,copy) NSString *chargingSequential;

@property(nonatomic,copy) NSString *factoryCombined;

@property(nonatomic,copy) NSString *factoryCompared;

@property(nonatomic,copy) NSString *factoryEngineering;


@property(nonatomic,copy) NSString *factoryHighSulfur;

@property(nonatomic,copy) NSString *factoryLowSulfur;

@property(nonatomic,copy) NSString *factoryPrice;

@property(nonatomic,copy) NSString *factorySequential;


@property(nonatomic,copy) NSString *furnaceCombined;

@property(nonatomic,copy) NSString *furnaceEngineering;

@property(nonatomic,copy) NSString *furnaceHighSulfur;

@property(nonatomic,copy) NSString *furnaceLowSulfur;

@property(nonatomic,copy) NSString *warehouseCombined;

@property(nonatomic,copy) NSString *warehouseHighSulfur;

@property(nonatomic,copy) NSString *warehouseLowSulfur;

@property(nonatomic,copy) NSString *warehouseEngineering;


@end
