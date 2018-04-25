//
//  ImportantViewController.m
//  dsdl
//
//  Created by 廉英雷 on 16/12/26.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import "ImportantViewController.h"
#import "ProListView.h"
#import "ImportModel.h"
#import "MJExtension.h"
#import "CoalContentView.h"


@interface ImportantViewController ()

//重要参数
@property (nonatomic, strong) NSMutableArray *listData;

@property (nonatomic, weak) ProListView *proView;

@property (nonatomic, weak) CoalContentView *coalView;
@end

@implementation ImportantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
      [self creatView];
      
      if (!isTest) {
             [self getData];
      }
     
}

- (void)viewWillAppear:(BOOL)animated{

      [super viewWillAppear:animated];
      self.tabBarController.tabBar.hidden = YES;
}
- (void)customNavigationBar{
      [super customNavigationBar];
      
      UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
      lab.text = @"重要参数";
      lab.font = [UIFont systemFontOfSize:18];
      lab.textAlignment = NSTextAlignmentCenter;
      lab.textColor = [UIColor whiteColor];
      self.navigationItem.titleView = lab;
}


- (NSMutableArray *)listData{
      
      if (!_listData) {
            _listData = [NSMutableArray array];
      }
     
      return _listData;
} 
- (void)getData{

      //是否有网络
      if (![Tools isNetWork]) {
            
            
            
            NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask , YES)lastObject];
            path = [path stringByAppendingPathComponent:@"getParamNew.data"];
            
            NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
            if (dict) {
                  
                  [self successRequest:dict withSender:@"getParamNew"];
                  
            }
            
      }
      

      //重要参数
      [self.httpRequest getURL:appServer withUrl:@"param/getParamNew" withParam:nil httpHeader:[Tools HttpHeader] receiveTarget:@"getParamNew"];
//      [self.httpRequest getURL:[appServer stringByAppendingString:@"param/getParamNew"] withParam:nil httpHeader:[Tools HttpHeader] receiveTarget:@"getParamNew"];


}

- (void)errorRequest:(id)data withSender:(NSString *)sender{
      if ([sender isEqualToString:@"getParamNew"]) {
            NSDictionary *dict = (NSDictionary *)data;
            NSLog(@"-----%@",dict[@"message"]);
      }
}
- (void)successRequest:(id)data withSender:(NSString *)sender{

      if ([sender isEqualToString:@"getParamNew"]) {
            NSDictionary *dict = (NSDictionary *)data;
            
            if (![data isKindOfClass:[NSNull class]]) {
                  NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask , YES)lastObject];
                  path = [path stringByAppendingPathComponent:@"getParamNew.data"];
                  [dict writeToFile:path atomically:YES];
                  
                  ImportModel *model = [ImportModel mj_objectWithKeyValues:dict];
                  self.coalView.dataAry = @[@[@"1#机组",@"2#机组"],@[model.activePowerV1,model.activePowerV2],@[model.aeactivePowerV1,model.aeactivePowerV2],@[model.mainPressureV1,model.mainPressureV2],@[model.mainTemperatureV1,model.mainTemperatureV2],@[model.againTemperatureV1,model.againTemperatureV2],@[model.drumWaterV1,model.drumWaterV2],@[model.deaeratorWaterV1,model.deaeratorWaterV2],@[model.condensateGasV1,model.condensateGasV2],@[model.feedwaterTemperatureV1,model.feedwaterTemperatureV2],@[model.vacuoV1,model.vacuoV2],@[model.negativePressureV1,model.negativePressureV2],@[model.totalFuelV1,model.totalFuelV2],@[model.totalAirV1,model.totalAirV2],@[model.heatConsumptionV1,model.heatConsumptionV2],@[model.smokeTemperatureV1,model.smokeTemperatureV2],@[model.codoV1,model.codoV2],@[model.boilerHeatEfficiencyV1,model.boilerHeatEfficiencyV2],@[model.turbineHeatRateV1,model.turbineHeatRateV2]];
            }else{
            
                   self.coalView.dataAry = @[@[@"1#机组",@"2#机组"],@[@"-",@"-"],@[@"-",@"-"],@[@"-",@"-"],@[@"-",@"-"],@[@"-",@"-"],@[@"-",@"-"],@[@"-",@"-"],@[@"-",@"-"],@[@"-",@"-"],@[@"-",@"-"],@[@"-",@"-"],@[@"-",@"-"],@[@"-",@"-"],@[@"-",@"-"],@[@"-",@"-"],@[@"-",@"-"],@[@"-",@"-"],@[@"-",@"-"]];
            
            }
            
            
          
            
//            //今日实时
//            NSArray *ary = dict[@"parameters"];
//            //昨日平均
//            NSArray *ary1 = dict[@"parametersAvg"];
//            NSMutableArray *array1 = [ImportModel mj_objectArrayWithKeyValuesArray:ary];
//            NSMutableArray *array2 = [ImportModel mj_objectArrayWithKeyValuesArray:ary1];
//            
//            ImportModel *paraModel1;
//            ImportModel *paraModel2;
//            for (ImportModel *imporModel in array1) {
//                  
//                  if ([imporModel.unitSet isEqualToString:@"1"]) {
//                        paraModel1 = imporModel;
//                  }
//                  if ([imporModel.unitSet isEqualToString:@"2"]) {
//                        paraModel2 = imporModel;
//                  }
//            }
//            
//            ImportModel *paraAvgModel1;
//            ImportModel *paraAvgModel2;
//            for (ImportModel *imporModel in array2) {
//                  
//                  if ([imporModel.unitSet isEqualToString:@"1"]) {
//                        paraAvgModel1 = imporModel;
//                  }
//                  if ([imporModel.unitSet isEqualToString:@"2"]) {
//                        paraAvgModel2 = imporModel;
//                  }
//            }
//            
//            
//
//            NSArray *dataArray = @[@[paraModel1.power,paraAvgModel1.power,paraModel2.power,paraAvgModel2.power],@[paraModel1.mainPressure,paraAvgModel1.mainPressure,paraModel2.mainPressure,paraAvgModel2.mainPressure],@[paraModel1.mainPressure,paraAvgModel1.mainTemperature,paraModel2.mainTemperature,paraAvgModel2.mainTemperature],@[paraModel1.againTemperature,paraAvgModel1.againTemperature,paraModel2.againTemperature,paraAvgModel2.againTemperature],@[paraModel1.feedwaterTemperature,paraAvgModel1.feedwaterTemperature,paraModel2.feedwaterTemperature,paraAvgModel2.feedwaterTemperature],@[paraModel1.vacuo,paraAvgModel1.vacuo,paraModel2.vacuo,paraAvgModel2.vacuo],@[paraModel1.smokeTemperature,paraAvgModel1.smokeTemperature,paraModel2.smokeTemperature,paraAvgModel2.smokeTemperature],@[paraModel1.codo,paraAvgModel1.codo,paraModel2.codo,paraAvgModel2.codo],@[paraModel1.boilerHeatEfficiency,paraAvgModel1.boilerHeatEfficiency,paraModel2.boilerHeatEfficiency,paraAvgModel2.boilerHeatEfficiency],@[paraModel1.turbineHeatRate,paraAvgModel1.turbineHeatRate,paraModel2.turbineHeatRate,paraAvgModel2.turbineHeatRate]];
//            self.proView.dataAry = dataArray;
            
     }
}

- (void)creatView{

      
      CoalContentView *contentView = [[CoalContentView alloc] initWithFrame:CGRectMake(0, 0, _width, _height-20)];
      self.coalView = contentView;
      [self.view addSubview:contentView];
      
      contentView.textAry = @[@"指标",@"有功功率\n(WM)",@"无功功率\n(WM)",@"主汽压力\n(MPa)",@"主汽温度\n(℃)",@"再热温度\n(℃)",@"汽包水位\n(mm)",@"除氧器水位\n(mm)",@"凝气排气水位\n(mm)",@"给水温度\n(℃)",@"真空\n(KPa)",@"炉膛负压\n(Pa)",@"总燃料量\n(t/h)",@"总风量\n(km3/h)",@"热耗量\n(Kj/h)",@"排烟温度\n(℃)",@"氧量\n(%)",@"锅炉热效率\n(%)",@"汽机热耗\n(kj/kwh)"];
      
      ProListView *proView = [[ProListView alloc] initWithFrame:CGRectMake(0, 0, _width, _height-20)];
      proView.isImport = YES;
      
      proView.textAry = @[@"有功功率",@"无功功率",@"主汽压力",@"主汽温度",@"再热温度",@"汽包水位",@"除氧器水位",@"凝气排气装置水位",@"给水温度",@"真空",@"炉膛负压",@" 总燃料量",@"总风量",@"热耗量",@"排烟温度",@"氧量",@"锅炉热效率",@"汽机热耗"];
           //proView.dataAry = @[@{@"":@""}];
      
      self.proView = proView;
     // [self.view addSubview:proView];
      if (isTest) {
            
            self.coalView.dataAry = @[@[@"1#机组",@"2#机组"],@[@"165.52",@"166.33"],@[@"-16.87",@"-15.54"],@[@"13.86",@"13.80"],@[@"511.11",@"541.41"],@[@"539.12",@"541.1"],@[@"-9.40",@"-8.2"],@[@"0.0",@"0.0"],@[@"2365.00",@"2365.11"],@[@"139.50",@"141.10"],@[@"5.56",@"6.62"],@[@"-91.57",@"-93.52"],@[@"115.6",@"116.35"],@[@"840.17",@"846.41"],@[@"10.23",@"10.23"],@[@"135.81",@"134.80"],@[@"3.40",@"3.50"],@[@"95.50",@"94.60"],@[@"6544.80",@"6577.00"]];
            
            proView.dataAry = @[@[@"86.4",@"90",@"87.4",@"91"],@[@"13.9",@"13",@"13.8",@"13 "],@[@"545.5",@"550",@"541.1",@"549"],@[@"539.6",@"540",@"541.1",@"550"],@[@"139.5",@"140",@"140.1",@"142"],@[@"10.23",@"11.1",@"10.23",@"11.2"],@[@"135.81",@"136.0",@"134.8",@"135"],@[@"3.4",@"4",@"3.5",@"3.8"],@[@"95.5",@"96",@"94.6",@"95"],@[@"6544.8",@"6600",@"6577",@"6700"],@[@"86.4",@"90",@"87.4",@"91"],@[@"13.9",@"13",@"13.8",@"13 "],@[@"545.5",@"550",@"541.1",@"549"],@[@"539.6",@"540",@"541.1",@"550"],@[@"139.5",@"140",@"140.1",@"142"],@[@"10.23",@"11.1",@"10.23",@"11.2"],@[@"135.81",@"136.0",@"134.8",@"135"],@[@"3.4",@"4",@"3.5",@"3.8"]];
            
      }

}
- (void)didReceiveMemoryWarning {
      
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
