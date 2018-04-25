//
//  UnitModel.h
//  dsdl
//
//  Created by 廉英雷 on 16/12/28.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UnitModel : NSObject

//-----------------------------------

//"airLeakageOneV1": "2",
//"airLeakageOneV2": "2",
//"airLeakageTwoV1": "2",
//"airLeakageTwoV2": "2",
//"boilerEfficiencyV1": "2",
//"boilerEfficiencyV2": "2",
//"boilerExhaustLossesV1": "2",
//"boilerExhaustLossesV2": "2",
//"boilerTemperatureV1": "2",
//"boilerTemperatureV2": "2",
//"createTime": "2017-01-16 12:00:00",
//"heatLossV1": "2",
//"heatLossV2": "2",
//"id": "2",
//"mainSteamFlowV1": "2",
//"mainSteamFlowV2": "2",

@property(nonatomic,copy) NSString *airLeakageOneV1;

@property(nonatomic,copy) NSString *airLeakageOneV2;

@property(nonatomic,copy) NSString *airLeakageTwoV1;

@property(nonatomic,copy) NSString *airLeakageTwoV2;

@property(nonatomic,copy) NSString *boilerEfficiencyV1;

@property(nonatomic,copy) NSString *boilerEfficiencyV2;

@property(nonatomic,copy) NSString *boilerExhaustLossesV1;

@property(nonatomic,copy) NSString *boilerExhaustLossesV2;

@property(nonatomic,copy) NSString *boilerTemperatureV1;

@property(nonatomic,copy) NSString *boilerTemperatureV2;

@property(nonatomic,copy) NSString *heatLossV1;

@property(nonatomic,copy) NSString *heatLossV2;

@property(nonatomic,copy) NSString *mainSteamFlowV1;

@property(nonatomic,copy) NSString *mainSteamFlowV2;

@property(nonatomic,copy) NSString *physicalHeatLossV1;

@property(nonatomic,copy) NSString *physicalHeatLossV2;

@property(nonatomic,copy) NSString *preheaterAirOneV1;

@property(nonatomic,copy) NSString *preheaterAirOneV2;

@property(nonatomic,copy) NSString *preheaterAirTwoV1;

@property(nonatomic,copy) NSString *preheaterAirTwoV2;

@property(nonatomic,copy) NSString *preheaterEfficiencyOneV1;

@property(nonatomic,copy) NSString *preheaterEfficiencyOneV2;

@property(nonatomic,copy) NSString *preheaterEfficiencyTwoV1;

@property(nonatomic,copy) NSString *preheaterEfficiencyTwoV2;

@property(nonatomic,copy) NSString *preheaterInletOxygenV1;

@property(nonatomic,copy) NSString *preheaterInletOxygenV2;

@property(nonatomic,copy) NSString *preheaterOutletOxygenV1;

@property(nonatomic,copy) NSString *preheaterOutletOxygenV2;

@property(nonatomic,copy) NSString *preheaterPoorOneV1;

@property(nonatomic,copy) NSString *preheaterPoorOneV2;

@property(nonatomic,copy) NSString *preheaterPoorTwoV1;

@property(nonatomic,copy) NSString *preheaterPoorTwoV2;

@property(nonatomic,copy) NSString *solidSmolderingV1;

@property(nonatomic,copy) NSString *solidSmolderingV2;






//汽机参数

//"": "2",
//"mainEnthalpyV2": "2",
//"": "2",
//"mainPressureV2": "2",
//"": "2",
//"mainTemperatureV2": "2",
//"": "2",
//"mainTrafficV2": "2",
//"": "2",
//"reheatEnthalpyV2": "2",
//"": "2",
//"reheatPressureV2": "2",
//"": "2",
//"reheatTemperatureV2": "2",
//"": "2",
//"reheatTrafficV2": "2",
//"": "2",
//"waterEnthalpyV2": "2",
//"": "2",
//"waterPressureV2": "2",
//"": "2",
//"waterTemperatureV2": "2",
//"": "2",
//"waterTrafficV2": "2"


@property(nonatomic,copy) NSString *mainEnthalpyV1;

@property(nonatomic,copy) NSString *mainEnthalpyV2;

@property(nonatomic,copy) NSString *mainPressureV1;

@property(nonatomic,copy) NSString *mainPressureV2;

@property(nonatomic,copy) NSString *mainTemperatureV1;

@property(nonatomic,copy) NSString *mainTemperatureV2;

@property(nonatomic,copy) NSString *mainTrafficV1;

@property(nonatomic,copy) NSString *mainTrafficV2;

@property(nonatomic,copy) NSString *reheatEnthalpyV1;

@property(nonatomic,copy) NSString *reheatEnthalpyV2;

@property(nonatomic,copy) NSString *reheatPressureV1;

@property(nonatomic,copy) NSString *reheatPressureV2;

@property(nonatomic,copy) NSString *reheatTemperatureV1;

@property(nonatomic,copy) NSString *reheatTemperatureV2;

@property(nonatomic,copy) NSString *reheatTrafficV1;

@property(nonatomic,copy) NSString *reheatTrafficV2;

@property(nonatomic,copy) NSString *waterEnthalpyV1;

@property(nonatomic,copy) NSString *waterEnthalpyV2;

@property(nonatomic,copy) NSString *waterPressureV1;

@property(nonatomic,copy) NSString *waterPressureV2;

@property(nonatomic,copy) NSString *waterTemperatureV1;

@property(nonatomic,copy) NSString *waterTemperatureV2;

@property(nonatomic,copy) NSString *waterTrafficV1;

@property(nonatomic,copy) NSString *waterTrafficV2;







//            "avgLoadV1": "1",平均负荷1号机组
//            "avgLoadV2": "1",平均负荷2号机组
//            "backPressureV1": "1",背压1号机组
//            "backPressureV2": "1",背压2号机组
//            "createTime": "2016-12-19",
//            "id": "1",
//            "loadRateV1": "1",负荷率1号机组
//            "loadRateV2": "1",负荷率2号机组
//            "runHoursV1": "1",机组运行小时1号机组
//            "runHoursV2": "1",机组运行小时2号机组
//            "runTimeV1": "1",机组运行时间1号机组
//            "runTimeV2": "1"机组运行时间2号机组

//@property(nonatomic,copy) NSString *avgLoadV1;
//
//@property(nonatomic,copy) NSString *avgLoadV2;
//
//@property(nonatomic,copy) NSString *backPressureV1;
//
//@property(nonatomic,copy) NSString *backPressureV2;
//
//@property(nonatomic,copy) NSString *createTime;
//
//@property(nonatomic,copy) NSString *loadRateV1;
//
//@property(nonatomic,copy) NSString *loadRateV2;
//
//@property(nonatomic,copy) NSString *runHoursV1;
//
//@property(nonatomic,copy) NSString *runHoursV2;
//
//@property(nonatomic,copy) NSString *runTimeV1;
//
//@property(nonatomic,copy) NSString *runTimeV2;


//      "boilerEfficiency": "1",锅炉热效率目标值
//      "createTime": "2016-12-19 00:00:00",
//      "efficiencyValue": "1",锅炉热效率值
//      "generationValue": "1",发电煤耗值
//      "id": "1",
//      "powerGeneration": "1",发电煤耗目标值
//      "powerSupply": "1",供电煤耗目标值
//      "supplyValue": "1",供电热耗值
//      "turbine": "1",汽机热耗目标值
//      "turbineValue": "1" 汽机热耗值

//@property(nonatomic,copy) NSString *boilerEfficiency;
//
//@property(nonatomic,copy) NSString *efficiencyValue;
//
//@property(nonatomic,copy) NSString *generationValue;
//
//@property(nonatomic,copy) NSString *powerGeneration;
//
//@property(nonatomic,copy) NSString *powerSupply;
//
//@property(nonatomic,copy) NSString *supplyValue;
//
//@property(nonatomic,copy) NSString *turbine;
//
//@property(nonatomic,copy) NSString *turbineValue;
//



@end
