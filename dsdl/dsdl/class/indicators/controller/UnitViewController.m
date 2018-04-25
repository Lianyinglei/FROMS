//
//  UnitViewController.m
//  dsdl
//
//  Created by 廉英雷 on 16/11/17.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import "UnitViewController.h"
#import "CoalContentView.h"
#import "UnitModel.h"
#import "MJExtension.h"
#import "UnitContentView.h"


@interface UnitViewController ()



@property (nonatomic, weak) CoalContentView *cocalView1;

@property (nonatomic, weak) CoalContentView *cocalView2;

@property (nonatomic, weak)  UnitContentView *contentView;

@property (nonatomic, strong) NSMutableArray *dataArray;


@end

@implementation UnitViewController


- (NSMutableArray *)dataArray{

      if (!_dataArray) {
            _dataArray = [NSMutableArray array];
      }
      
      return _dataArray;
}
- (void)viewWillAppear:(BOOL)animated{

      [super viewWillAppear:animated];
      self.tabBarController.tabBar.hidden = YES;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
      self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
     // [self creatContentView];
      [self creatView];
      if (!isTest) {
             [self getData];
      }
     
}

- (void)creatView{

      UnitContentView *contentView = [[UnitContentView alloc] initWithFrame:CGRectMake(0, 0, _width, _height-20)];
      [self.view addSubview:contentView];
      
      self.contentView = contentView;
      
      contentView.textAry = @[@[@"锅炉指标",@"主蒸汽流量\n(t/h)",@"锅炉效率\n(%)",@"锅炉排烟损失\n(%)",@"固体未完全燃\n烧损失(%)",@"散热损失\n(%)",@"灰渣物理热损\n失(%)",@"空预器入口烟气氧量(%)",@"空预器出口烟气氧量(%)",@"锅炉排烟温度\n(℃)",@"1#空预器烟气侧差压(kPa)",@"2#空预器烟气侧差压(%)",@"1#空预器烟气侧效率(%)",@"2#空预器烟气侧效率(%)",@"1#空预器X比\n(%)",@"2#空预器X比\n(%)",@"1#空预器漏风率\n(%)",@"2#空预器漏风率\n(%)",],@[@"汽机指标",@"汽机主汽压力\n(MPa)",@"汽机主汽流量\n(t/h)",@"汽机主汽比焓\n(KJ/Kg)",@"汽机主汽温度\n(℃)",@"汽机再热蒸汽\n压力(MPa)",@"汽机再热蒸汽\n流量(t/h)",@"汽机再热蒸汽\n比焓(KJ/Kg)",@"汽机再热蒸汽\n温度(℃)",@"给水压力(\nMPa)",@"给水流量\n(t/h)",@"给水比焓\n(KJ/Kg)",@"给水温度\n(℃)"]];
      
      if (isTest) {
            contentView.dataAry = @[@[@[@"1#机组",@"2#机组"],@[@"577.67",@"579.11"],@[@"86.73",@"81.72"],@[@"10.88",@"11.21"],@[@"1.10",@"3.66"],@[@"0.81",@"0.69"],@[@"0.49",@"0.48"],@[@"2.99",@"2.78"],@[@"3.72",@"3.66"],@[@"139.95",@"139.66"],@[@"0.99",@"0.85"],@[@"1.15",@"1.32"],@[@"60.57",@"60.59"],@[@"60.04",@"60.59"],@[@"60.04",@"60.22"],@[@"62.07",@"63.00"],@[@"1.50",@"1.52"],@[@"1.50",@"1.51"]],@[@[@"1#机组",@"2#机组"],@[@"123.5",@"121.8"],@[@"144",@"134"],@[@"174.7",@"178.2"],@[@"52.7",@"53.6"],@[@"89.6",@"91.7"],@[@"123.8",@"121.5"],@[@"144.6",@"134.8"],@[@"174.7",@"178.2"],@[@"152.7",@"153.6"],@[@"229.6",@"171.8"],@[@"249.6",@"189.7"],@[@"129.6",@"171.8"]]];
      }
      


}

- (void)getData{
      
      
      //是否有网络
      if (![Tools isNetWork]) {
            
            
            
            NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask , YES)lastObject];
            path = [path stringByAppendingPathComponent:@"getBoiler.data"];
            
            NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
            if (dict) {
                  
                  [self successRequest:dict withSender:@"getBoiler"];
                  
            }
            
      }

       NSString *path2 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask , YES)lastObject];
      path2 = [path2 stringByAppendingPathComponent:@"getTurbine.data"];
      NSDictionary *dict2 = [NSDictionary dictionaryWithContentsOfFile:path2];
      if (dict2) {
            
            [self successRequest:dict2 withSender:@"getTurbine"];
            
      }else{
      
            //锅炉指标
            [self.httpRequest getURL:appServer withUrl:@"boiler/getBoiler" withParam:nil httpHeader:[Tools HttpHeader] receiveTarget:@"getBoiler"];
      }

      
     
//      [self.httpRequest getURL:appServer withUrl:@"boiler/getBoiler" withParam:nil httpHeader:[Tools HttpHeader] receiveTarget:@"getBoiler"];
//      [self.httpRequest getURL:[appServer stringByAppendingString:@"boiler/getBoiler"] withParam:nil httpHeader:[Tools HttpHeader] receiveTarget:@"getBoiler"];

      
}

- (void)successRequest:(id)data withSender:(NSString *)sender{

      if ([sender isEqualToString:@"getTurbine"]) {
            
            if (![data isKindOfClass:[NSNull class]]) {
                  NSDictionary *dict = (NSDictionary *)data;
                  
                  NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask , YES)lastObject];
                  path =[path stringByAppendingPathComponent:@"getTurbine.data"];
                  UnitModel *unitModel = [UnitModel mj_objectWithKeyValues:dict];
                  
                  //  coalView2.dataAry = @[@[@"1#机组",@"2#机组"],@[@"23",@"21"],@[@"44",@"34"],@[@"66",@"56"],@[@"76",@"65"],@[@"74",@"73"]];
                  
                  NSArray *ary2 = @[@[@"1#机组",@"2#机组"],@[unitModel.mainPressureV1,unitModel.mainPressureV2],@[unitModel.mainTrafficV1,unitModel.mainTrafficV2],@[unitModel.mainEnthalpyV1,unitModel.mainEnthalpyV2],@[unitModel.mainTemperatureV1,unitModel.mainTemperatureV2],@[unitModel.reheatPressureV1,unitModel.reheatPressureV2],@[unitModel.reheatTrafficV1,unitModel.reheatTrafficV2],@[unitModel.reheatEnthalpyV1,unitModel.reheatEnthalpyV2],@[unitModel.reheatTemperatureV1,unitModel.reheatTemperatureV2],@[unitModel.waterPressureV1,unitModel.waterPressureV2],@[unitModel.waterTrafficV1,unitModel.waterTrafficV2],@[unitModel.waterEnthalpyV1,unitModel.waterEnthalpyV2],@[unitModel.waterTemperatureV1,unitModel.waterTemperatureV2]];
                  [self.dataArray addObject:ary2];
                  
                  self.contentView.dataAry = self.dataArray;
            }else{
            
                  NSArray *ary2 = @[@[@"1#机组",@"2#机组"],@[@"0.00",@"0.00"],@[@"0.00",@"0.00"],@[@"0.00",@"0.00"],@[@"0.00",@"0.00"],@[@"0.00",@"0.00"],@[@"0.00",@"0.00"],@[@"0.00",@"0.00"],@[@"0.00",@"0.00"],@[@"0.00",@"0.00"],@[@"0.00",@"0.00"],@[@"0.00",@"0.00"],@[@"0.00",@"0.00"]];
                  [self.dataArray addObject:ary2];
                  
                  self.contentView.dataAry = self.dataArray;
            }
           

            
      }
      if ([sender isEqualToString:@"getBoiler"]) {
            NSDictionary *dict = (NSDictionary *)data;
            
            
            if ([dict isKindOfClass:[NSNull class]]) {
                  
                  self.contentView.dataAry = @[@[@[@"1#机组",@"2#机组"],@[@"577.67",@"579.11"],@[@"86.73",@"81.72"],@[@"10.88",@"11.21"],@[@"1.10",@"3.66"],@[@"0.81",@"0.69"],@[@"0.49",@"0.48"],@[@"2.99",@"2.78"],@[@"3.72",@"3.66"],@[@"139.95",@"139.66"],@[@"0.99",@"0.85"],@[@"1.15",@"1.32"],@[@"60.57",@"60.59"],@[@"60.04",@"60.59"],@[@"60.04",@"60.22"],@[@"62.07",@"63.00"],@[@"1.50",@"1.52"],@[@"1.50",@"1.51"]],@[@[@"1#机组",@"2#机组"],@[@"123.5",@"121.8"],@[@"144",@"134"],@[@"174.7",@"178.2"],@[@"52.7",@"53.6"],@[@"89.6",@"91.7"],@[@"123.8",@"121.5"],@[@"144.6",@"134.8"],@[@"174.7",@"178.2"],@[@"152.7",@"153.6"],@[@"229.6",@"171.8"],@[@"249.6",@"189.7"],@[@"129.6",@"171.8"]]];
                  
            }else{
            
                  NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask , YES)lastObject];
                  path = [path stringByAppendingPathComponent:@"getBoiler.data"];
                  [dict writeToFile:path atomically:YES];
            [self.dataArray removeAllObjects];
            UnitModel *unitModel2 = [UnitModel mj_objectWithKeyValues:dict];
            
            NSArray *ary1 = @[@[@"1#机组",@"2#机组"],@[unitModel2.mainSteamFlowV1,unitModel2.mainSteamFlowV2],@[unitModel2.boilerEfficiencyV1,unitModel2.boilerEfficiencyV2],@[unitModel2.boilerExhaustLossesV1,unitModel2.boilerExhaustLossesV2],@[unitModel2.solidSmolderingV1,unitModel2.solidSmolderingV2],@[unitModel2.heatLossV1,unitModel2.heatLossV2],@[unitModel2.physicalHeatLossV1,unitModel2.physicalHeatLossV2],@[unitModel2.preheaterInletOxygenV1,unitModel2.preheaterInletOxygenV2],@[unitModel2.preheaterOutletOxygenV1,unitModel2.preheaterOutletOxygenV2],@[unitModel2.boilerTemperatureV1,unitModel2.boilerTemperatureV2],@[unitModel2.preheaterPoorOneV1,unitModel2.preheaterPoorOneV2],@[unitModel2.preheaterPoorTwoV1,unitModel2.preheaterPoorTwoV2],@[unitModel2.preheaterEfficiencyOneV1,unitModel2.preheaterEfficiencyOneV2],@[unitModel2.preheaterEfficiencyTwoV1,unitModel2.preheaterEfficiencyTwoV2],@[unitModel2.preheaterAirOneV1,unitModel2.preheaterAirOneV2],@[unitModel2.preheaterAirTwoV1,unitModel2.preheaterAirTwoV2],@[unitModel2.airLeakageOneV1,unitModel2.airLeakageOneV2],@[unitModel2.airLeakageTwoV1,unitModel2.airLeakageTwoV2]];
            
            [self.dataArray addObject:ary1];
            
            
                   
            //汽机指标
            [self.httpRequest getURL:appServer withUrl:@"turbine/getTurbine" withParam:nil httpHeader:[Tools HttpHeader] receiveTarget:@"getTurbine"];
//            [self.httpRequest getURL:[appServer stringByAppendingString:@"turbine/getTurbine"] withParam:nil httpHeader:[Tools HttpHeader] receiveTarget:@"getTurbine"];
                  
            }
      }

}
- (void)customNavigationBar{
      
      [super customNavigationBar];
    
      UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
      lab.text = @"机组指标";
      lab.font = [UIFont systemFontOfSize:18];
      lab.textAlignment = NSTextAlignmentCenter;
      lab.textColor = [UIColor whiteColor];
      self.navigationItem.titleView = lab;

}

- (void)creatContentView{
      
      UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _width, 40)];
      [self.view addSubview:lab1];
      lab1.text = @"  机组性能指标";
      lab1.textAlignment = NSTextAlignmentLeft;

      CGFloat width = 220;
      if (_width == IPHONE5W) {
            width = 200;
      }if (_width == IPHONE6W) {
            width = 220;
      }if (_width == IPHONE6PW) {
            width = 250;
      }

      CoalContentView *coalView = [[CoalContentView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lab1.frame), _width, width)];
     
      
            [self.view addSubview:coalView];
      
      self.cocalView1 = coalView;
      

      
      
    //  coalView.dataAry = @[@[@"值",@"目标值"],@[@"23",@"21"],@[@"44",@"34"],@[@"66",@"56"],@[@"76",@"65"]];
      coalView.textAry = @[@"指标名称",@"发电耗煤\n(g/kwh)",@"供电煤耗\n(g/kwh)",@"汽机热耗\n(g/kwh)",@"锅炉效率\n(g/kwh)"];
      
      
      UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(coalView.frame), _width, 40)];
      [self.view addSubview:lab2];
      lab2.text = @"  机组稳定性指标";
      lab2.textAlignment = NSTextAlignmentLeft;
      CoalContentView *coalView2 = [[CoalContentView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lab2.frame), _width, (_height -CGRectGetMaxY(lab2.frame)))];
           [self.view addSubview:coalView2];
      
      self.cocalView2 = coalView2;
      coalView2.isKey = YES;
      
      
      
    //  coalView2.dataAry = @[@[@"1#机组",@"2#机组"],@[@"23",@"21"],@[@"44",@"34"],@[@"66",@"56"],@[@"76",@"65"],@[@"74",@"73"]];
      coalView2.textAry = @[@"稳定性指标",@"机组运行时间",@"机组运行小时",@"平均负荷(%)",@"负荷率",@"背压"];
      
      if (isTest) {
            coalView.dataAry = @[@[@"值",@"目标值"],@[@"229.6",@"171.8"],@[@"249.6",@"189.7"],@[@"66",@"56"],@[@"6139.6",@"4363.6"]];
              coalView2.dataAry = @[@[@"1#机组",@"2#机组"],@[@"23",@"21"],@[@"44",@"34"],@[@"174.7",@"178.2"],@[@"52.7",@"53.6"],@[@"9.6",@"9.7"]];
      }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
