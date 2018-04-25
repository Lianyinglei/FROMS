//
//  ColModel.h
//  dsdl
//
//  Created by 廉英雷 on 16/12/28.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ColModel : NSObject

//            "createTime": "2016-12-19 12:00:00",
//            "electricityV1": "2",厂用电率1号机组
//            "electricityV2": "2",厂用电率2号机组
//            "factoryElectricityV1": "2", 厂用电率1号机组
//            "factoryElectricityV2": "2",厂用电率2号机组
//            "heatingFactoryV1": "2",供热厂用电1号机组
//            "heatingFactoryV2": "2",供热厂用电2号机组
//            "id": "2",
//            "machineSideV1": "2",机侧厂用电%1号机组
//            "machineSideV2": "2",机侧厂用电%2号机组
//            "mdiFactoryV1": "2",环保厂用电1号机组
//            "mdiFactoryV2": "2",环保厂用电2号机组
//            "powerElectricityV1": "2",发电煤耗1号机组
//            "powerElectricityV2": "2",发电煤耗2号机组
//            "sideFactoryV1": "2",炉侧厂用电1号机组
//            "sideFactoryV2": "2",炉侧厂用电2号机组
//            "supplyElectricityV1": "2",供电煤耗1号机组
//"supplyElectricityV2": "2"  供电煤耗2号机组
//
@property(nonatomic,copy) NSString *electricityV1;

@property(nonatomic,copy) NSString *electricityV2;

@property(nonatomic,copy) NSString *factoryElectricityV1;

@property(nonatomic,copy) NSString *factoryElectricityV2;

@property(nonatomic,copy) NSString *heatingFactoryV1;

@property(nonatomic,copy) NSString *heatingFactoryV2;

@property(nonatomic,copy) NSString *id;

@property(nonatomic,copy) NSString *machineSideV1;

@property(nonatomic,copy) NSString *machineSideV2;

@property(nonatomic,copy) NSString *mdiFactoryV1;

@property(nonatomic,copy) NSString *mdiFactoryV2;

@property(nonatomic,copy) NSString *powerElectricityV1;

@property(nonatomic,copy) NSString *powerElectricityV2;

@property(nonatomic,copy) NSString *sideFactoryV1;

@property(nonatomic,copy) NSString *sideFactoryV2;

@property(nonatomic,copy) NSString *supplyElectricityV1;

@property(nonatomic,copy) NSString *supplyElectricityV2;


//auxiliaryPowerV1
//auxiliaryPowerV2
//"blowerAV1": "1",
//"blowerAV2": "1",
//"blowerBV1": "1",
//"blowerBV2": "1",
//"coalMillV1": "1",
//"coalMillV2": "1",
//"createTime": "2017-01-16 12:00:00",
//"desulfurizationV1": "1",
//"desulfurizationV2": "1",
//"id": "1",
//"inducedAV1": "1",
//"inducedAV2": "1",
//"inducedBV1": "1",
//"inducedBV2": "1",
//"oneFanAV1": "1",
//"oneFanAV2": "1",
//"oneFanBV1": "1",
//"oneFanBV2": "1"

@property(nonatomic,copy) NSString *auxiliaryPowerV1;

@property(nonatomic,copy) NSString *auxiliaryPowerV2;

@property(nonatomic,copy) NSString *blowerAV1;

@property(nonatomic,copy) NSString *blowerAV2;

@property(nonatomic,copy) NSString *blowerBV1;

@property(nonatomic,copy) NSString *blowerBV2;

@property(nonatomic,copy) NSString *coalMillV1;

@property(nonatomic,copy) NSString *coalMillV2;

@property(nonatomic,copy) NSString *desulfurizationV1;

@property(nonatomic,copy) NSString *desulfurizationV2;

@property(nonatomic,copy) NSString *inducedAV1;

@property(nonatomic,copy) NSString *inducedAV2;

@property(nonatomic,copy) NSString *inducedBV1;

@property(nonatomic,copy) NSString *inducedBV2;

@property(nonatomic,copy) NSString *oneFanAV1;

@property(nonatomic,copy) NSString *oneFanAV2;

@property(nonatomic,copy) NSString *oneFanBV1;

@property(nonatomic,copy) NSString *oneFanBV2;


@end
