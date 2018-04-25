//
//  ImportModel.h
//  dsdl
//
//  Created by 廉英雷 on 16/12/29.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImportModel : NSObject

//"": "2",
//"activePowerV2": "2",
//"": "2",
//"aeactivePowerV2": "2",
//"": "2",
//"againTemperatureV2": "2",
//"": "2",
//"boilerHeatEfficiencyV2": "2",
//"": "2",
//"codoV2": "2",
//"": "2",
//"condensateGasV2": "2",
//"createTime": "2017-01-16 12:00:00",
//"": "2",
//"deaeratorWaterV2": "2",
//"": "2",
//"drumWaterV2": "2",
//"": "2",
//"feedwaterTemperatureV2": "2",
//"": "2",
//"heatConsumptionV2": "2",
//"id": "2",
//"": "2",
//"mainPressureV2": "2",


@property(nonatomic,copy) NSString *activePowerV1;

@property(nonatomic,copy) NSString *activePowerV2;

@property(nonatomic,copy) NSString *aeactivePowerV1;

@property(nonatomic,copy) NSString *aeactivePowerV2;

@property(nonatomic,copy) NSString *againTemperatureV1;

@property(nonatomic,copy) NSString *againTemperatureV2;

@property(nonatomic,copy) NSString *boilerHeatEfficiencyV1;

@property(nonatomic,copy) NSString *boilerHeatEfficiencyV2;

@property(nonatomic,copy) NSString *codoV1;

@property(nonatomic,copy) NSString *codoV2;

@property(nonatomic,copy) NSString *condensateGasV1;

@property(nonatomic,copy) NSString *condensateGasV2;

@property(nonatomic,copy) NSString *deaeratorWaterV1;

@property(nonatomic,copy) NSString *deaeratorWaterV2;

@property(nonatomic,copy) NSString *drumWaterV1;


@property(nonatomic,copy) NSString *drumWaterV2;

@property(nonatomic,copy) NSString *feedwaterTemperatureV1;

@property(nonatomic,copy) NSString *feedwaterTemperatureV2;

@property(nonatomic,copy) NSString *heatConsumptionV1;

@property(nonatomic,copy) NSString *heatConsumptionV2;

@property(nonatomic,copy) NSString *mainPressureV1;

@property(nonatomic,copy) NSString *mainPressureV2;

@property(nonatomic,copy) NSString *mainTemperatureV1;

@property(nonatomic,copy) NSString *mainTemperatureV2;

@property(nonatomic,copy) NSString *negativePressureV1;

@property(nonatomic,copy) NSString *negativePressureV2;

@property(nonatomic,copy) NSString *smokeTemperatureV1;

@property(nonatomic,copy) NSString *smokeTemperatureV2;

@property(nonatomic,copy) NSString *totalAirV1;

@property(nonatomic,copy) NSString *totalAirV2;

@property(nonatomic,copy) NSString *totalFuelV1;

@property(nonatomic,copy) NSString *totalFuelV2;

@property(nonatomic,copy) NSString *turbineHeatRateV1;

@property(nonatomic,copy) NSString *turbineHeatRateV2;

@property(nonatomic,copy) NSString *vacuoV1;

@property(nonatomic,copy) NSString *vacuoV2;





//            "parameters": [],
//再热温度
//            "againTemperature": "3",
//锅炉热效率
//            "boilerHeatEfficiency": "3",
//氧量
//            "codo": "3",
//            "createTime": "2016-12-15 13:00:00",
//给水温度
//            "feedwaterTemperature": "3",
//            "id": "1",
//主气压力
//            "mainPressure": "3",
// 主气温度
//            "mainTemperature": "120",
//功率
//            "power": "3",
//排烟温度
//            "smokeTemperature": "3",
//汽机热耗
//            "turbineHeatRate": "3",
//            "unitSet": "1",
//真空
//            "vacuo": "3"

//            "parametersAvg": []

//@property(nonatomic,copy) NSString *againTemperature;
//
//@property(nonatomic,copy) NSString *boilerHeatEfficiency;
//
//@property(nonatomic,copy) NSString *codo;
//
//@property(nonatomic,copy) NSString *feedwaterTemperature;
//
//@property(nonatomic,copy) NSString *mainPressure;
//
//@property(nonatomic,copy) NSString *mainTemperature;
//
//@property(nonatomic,copy) NSString *power;
//
//@property(nonatomic,copy) NSString *smokeTemperature;
//
//@property(nonatomic,copy) NSString *turbineHeatRate;
//
//@property(nonatomic,copy) NSString *unitSet;
//
//@property(nonatomic,copy) NSString *vacuo;

@end
