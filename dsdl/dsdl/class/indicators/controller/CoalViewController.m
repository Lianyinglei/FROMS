//
//  CoalViewController.m
//  dsdl
//
//  Created by 廉英雷 on 16/11/16.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import "CoalViewController.h"
#import "YXRadarView.h"
#import "YXRadarIndictorView.h"
#import "CoalLineView.h"
#import "CoalContentView.h"
#import "ColModel.h"
#import "MJExtension.h"
@interface CoalViewController ()<YXRadarViewDelegate, YXRadarViewDateSource>

@property (nonatomic, weak) UIView *headView;
@property (nonatomic, weak) YXRadarView *radarView;
@property (nonatomic, strong) NSMutableArray *pointsArray;

@property (nonatomic, strong) NSArray *dataAry;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, weak) CALayer *layer;

@property (nonatomic, weak) UIView *raView;



@property (nonatomic, weak) CoalContentView *coalView;

@property (nonatomic, weak) CoalLineView *rightView;
@end

@implementation CoalViewController

- (NSMutableArray *)pointsArray
{
      if (!_pointsArray) {
            _pointsArray = [NSMutableArray array];
            
                }
      return _pointsArray;
}

- (NSArray *)dataAry{

      if (!_dataAry) {
            
          //  _dataAry = @[@"30",@"50",@"60",@"80",@"40.5",@"60"];
      }
      return _dataAry;
}
- (void)viewWillAppear:(BOOL)animated{

      [super viewWillAppear:animated];
      self.tabBarController.tabBar.hidden = YES;
      
}

- (void)viewWillDisappear:(BOOL)animated{

      [super viewWillDisappear:animated];
      
}
- (void)viewDidLoad {
      [super viewDidLoad];
      self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
     
      // Do any additional setup after loading the view, typically from a nib.
      [self setupRadarView];
      [self creatheadRightView];
      if (!isTest) {
            
            //是否有网络
            if (![Tools isNetWork]) {
                  
                  
                  
                  NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask , YES)lastObject];
                  path = [path stringByAppendingPathComponent:@"getConsumption.data"];
                  
                  NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
                  if (dict) {
                        
                        [self successRequest:dict withSender:@"getConsumption"];
                        
                  }
                  //
                  NSString *path2 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask , YES)lastObject];
                  [path2 stringByAppendingPathComponent:@"getPowerConsumption.data"];
                  NSDictionary *dict2 = [NSDictionary dictionaryWithContentsOfFile:path2];
                  if (dict2) {
                        [self successRequest:dict2 withSender:@"getPowerConsumption"];
                  }
                  
            }else{
            
                   [self getdata];
            }

            
      }
    
}

- (void)getdata{
      
    
     
      
             [self.httpRequest getURL:appServer  withUrl:@"power/getPowerConsumption" withParam:nil httpHeader:[Tools HttpHeader] receiveTarget:@"getPowerConsumption"];
      
      [self.httpRequest getURL:appServer withUrl:@"consumption/getConsumption" withParam:nil httpHeader:[Tools HttpHeader] receiveTarget:@"getConsumption"];
      
//      [self.httpRequest getURL:[appServer stringByAppendingString:@"consumption/getConsumption"] withParam:nil httpHeader:[Tools HttpHeader] receiveTarget:@"getConsumption"];

     
//      [self.httpRequest getURL:[appServer stringByAppendingString:@"power/getPowerConsumption"] withParam:nil httpHeader:[Tools HttpHeader] receiveTarget:@"getPowerConsumption"];
}

- (void)errorRequest:(id)data withSender:(NSString *)sender{

      if ([sender isEqualToString:@"getConsumption"]) {
          
      }
}
- (void)successRequest:(id)data withSender:(NSString *)sender{

      if ([sender isEqualToString:@"getConsumption"]) {
            
            NSDictionary *dict = (NSDictionary *)data;
            
           
                  
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
            
            if ([dict isKindOfClass:[NSNull class]]) {
                  
            
            dict = @{@"supplyElectricityV1":@"50",@"supplyElectricityV2":@"60",@"powerElectricityV1":@"40",@"powerElectricityV2":@"50",@"electricityV1":@"80",@"electricityV2":@"80",@"factoryElectricityV1":@"100",@"factoryElectricityV2":@"200",@"heatingFactoryV1":@"100",@"heatingFactoryV2":@"200",@"machineSideV1":@"100",@"machineSideV2":@"200",@"sideFactoryV1":@"100",@"sideFactoryV2":@"200",@"supplyElectricityV1":@"100",@"supplyElectricityV2":@"100",@"mdiFactoryV1":@"100",@"mdiFactoryV2":@"200"};

            }
            
            NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask , YES)lastObject];
            path = [path stringByAppendingPathComponent:@"getConsumption.data"];
            [dict writeToFile:path atomically:YES];
            ColModel *colModel = [ColModel mj_objectWithKeyValues:dict];
            
            
            //             NSArray *ary = @[self.dataDict[@"supplyElectricityV1"],self.dataDict[@"supplyElectricityV2"],self.dataDict[@"powerElectricityV1"],self.dataDict[@"powerElectricityV2"],self.dataDict[@"factoryElectricityV1"],self.dataDict[@"factoryElectricityV2"]];
            
            
            self.rightView.dataAry = @[@[@"1#机组",@"2#机组"],@[colModel.supplyElectricityV1,colModel.supplyElectricityV2],@[colModel.powerElectricityV1,colModel.powerElectricityV2],@[colModel.electricityV1,colModel.electricityV2]];
            
            //     self.pointsArray = @[colModel.supplyElectricityV1,colModel.powerElectricityV1,colModel.electricityV1,colModel.supplyElectricityV2,colModel.powerElectricityV2,colModel.electricityV2].copy;
//            self.dataAry = @[colModel.supplyElectricityV1,colModel.powerElectricityV1,colModel.electricityV1,colModel.supplyElectricityV2,colModel.powerElectricityV2,colModel.electricityV2].copy;
            
             self.dataAry = @[colModel.supplyElectricityV1,colModel.powerElectricityV1,colModel.electricityV1,colModel.electricityV2,colModel.powerElectricityV2,colModel.supplyElectricityV2].copy;
           
            
            
            // 目标点位置
            [self randomPoints];
            [self.radarView scan];
            [self startUpdatingRadar];
            
            
            
      }
      
      
      if ([sender isEqualToString:@"getPowerConsumption"]) {
            
            
            if ([data isKindOfClass:[NSNull class]]) {
                  
                  self.coalView.dataAry =@[@[@"1#机组",@"2#号机组"],@[@"8.3",@"9.6"],@[@"2.24",@"2.13"],@[@"16.3",@"16.7"],@[@"3.00",@"2.01"],@[@"12.3",@"11.7"],@[@"9.62",@"9.24"],@[@"9.11",@"8.77"],@[@"7.21",@"6.99"],@[@"9.66",@"9.27"]];

            }else{
            
                  NSDictionary *dict = (NSDictionary *)data;
                  
                  NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask , YES)lastObject];
                  path = [path stringByAppendingPathComponent:@"getPowerConsumption.data"];
                  [dict writeToFile:path atomically:YES];
                  
            ColModel *colModel = [ColModel mj_objectWithKeyValues:data];
             self.coalView.dataAry = @[@[@"1#机组",@"2#机组"],@[colModel.blowerAV1,colModel.blowerAV2],@[colModel.blowerBV1,colModel.blowerBV2],@[colModel.inducedAV1,colModel.inducedAV2],@[colModel.inducedBV1,colModel.inducedBV2],@[colModel.oneFanAV1,colModel.oneFanAV2],@[colModel.oneFanBV1,colModel.oneFanBV2],@[colModel.coalMillV1,colModel.coalMillV2],@[colModel.desulfurizationV1,colModel.desulfurizationV2],@[colModel.auxiliaryPowerV1,colModel.auxiliaryPowerV2]];
            }
      }
}

- (void)customNavigationBar{
      [super customNavigationBar];
      UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
      lab.text = @"能耗指标";
      lab.font = [UIFont systemFontOfSize:18];
      lab.textAlignment = NSTextAlignmentCenter;
      lab.textColor = [UIColor whiteColor];
      self.navigationItem.titleView = lab;


}
- (void)creatheadRightView{
      
      
      CoalLineView *rightView = [[CoalLineView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.raView.frame)+5, 0, _width - self.raView.width -5, self.headView.height)];
      
  //煤耗指标的
//      NSArray *ary = @[@[self.dataDict[@"supplyElectricityV1"],self.dataDict[@"supplyElectricityV2"]],@[self.dataDict[@"powerElectricityV1"],self.dataDict[@"powerElectricityV2"]],@[self.dataDict[@"factoryElectricityV1"],self.dataDict[@"factoryElectricityV2"]]];
      
   //   rightView.dataAry = @[@[@"223",@"213"],@[@"224",@"213"],@[@"16.3",@"16.7"]];
      
      self.rightView = rightView;
      
      [self.headView addSubview:rightView];
      
      CoalContentView *contentView = [[CoalContentView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headView.frame)+10, _width, _height - 10 -self.headView.height-74)];
      self.coalView = contentView;
     
      
      [self.view addSubview:contentView];
      
      
      
//      NSArray *dataAry = @[@[@"1#机组",@"2#号机组"],@[self.dataDict[@"factoryElectricityV1"],self.dataDict[@"factoryElectricityV2"]],@[self.dataDict[@"sideFactoryV1"],self.dataDict[@"sideFactoryV2"]],@[self.dataDict[@"machineSideV1"],self.dataDict[@"machineSideV2"]],@[self.dataDict[@"mdiFactoryV1"],self.dataDict[@"mdiFactoryV2"]],@[self.dataDict[@"heatingFactoryV1"],self.dataDict[@"heatingFactoryV2"]]];
      
      
      contentView.textAry = @[@"指标",@"送风机电耗率A \n(A)",@"送风机电耗率B\n(A)",@"引风机电耗率A\n(A)",@"引风机电耗率B\n(A)",@"一次风机电耗率A(A)",@"一次风机电耗率B(A)",@"磨煤机电耗率\n(A)",@"脱硫变电耗率\n(A)",@"供热厂用电A\n(A)"];
      if (isTest) {
            rightView.dataAry = @[@[@"1#机组",@"2#机组"],@[@"233.72",@"214.92"],@[@"215.64",@"193.67"],@[@"7.98",@"10.08"]];
            
                  contentView.dataAry =@[@[@"1#机组",@"2#号机组"],@[@"8.3",@"9.6"],@[@"2.24",@"2.13"],@[@"16.3",@"16.7"],@[@"3.00",@"2.01"],@[@"12.3",@"11.7"],@[@"9.62",@"9.24"],@[@"9.11",@"8.77"],@[@"7.21",@"6.99"],@[@"9.66",@"9.27"]];

      }


}
- (void)setupRadarView
{
      UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _width, 200)];
      [self.view addSubview:headView];
      
      headView.backgroundColor = [UIColor whiteColor];
      UIView *raView = [[UIView alloc] initWithFrame:CGRectMake(10, 25, 130, 130)];
      [headView addSubview:raView];
      raView.centerY = headView.centerY;
      raView.backgroundColor = [UIColor clearColor];
      self.raView = raView;
      self.headView = headView;
      YXRadarView *radarView = [[YXRadarView alloc] initWithFrame:self.raView.bounds];
      //radarView.frame = raView.bounds;
      radarView.dataSource = self;
      radarView.delegate = self;
      radarView.radius = radarView.width*0.5;
//      radarView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
      radarView.backgroundColor = [UIColor whiteColor];
      //radarView.labelText = @"正在搜索附件的目标";
          self.radarView = radarView;
      [raView addSubview:radarView];
      
      if (isTest) {
           
            self.dataAry = @[@"34",@"38",@"44",@"45",@"55",@"60"];
            // 目标点位置
            
            [self randomPoints];
            [self.radarView scan];
            [self startUpdatingRadar];
      }

      
     
}

#pragma mark - Custom Methods
- (void)startUpdatingRadar
{
      typeof(self) __weak weakSelf = self;
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.radarView.labelText = [NSString stringWithFormat:@"搜索已完成，共找到%lu个目标",(unsigned long)weakSelf.pointsArray.count];
            [weakSelf.radarView show];
      });
}


#pragma mark -----雷达图最大值设置-------
- (void)randomPoints
{
     
      CGFloat maxHight = 330 *1.2;
      
      CGFloat maxfa = 300 *1.2;
      
      CGFloat maxChang = 11*1.2;
      [self.pointsArray removeAllObjects];
     
       CGFloat x = 0.0, y = 0.0;
      for (int  i = 0; i < self.dataAry.count; i++) {
          
            
            NSString *str = self.dataAry[i];
            CGFloat xStr = [str floatValue];
            if (i == 0) {
                  
                  x = self.radarView.radius * (1- xStr/maxHight*sqrt(3)*0.5);
                  y =  self.radarView.radius *(1- xStr/maxHight*0.5);

            }if (i == 1) {
                  
                  x = self.radarView.radius;
                  y =  self.radarView.radius *(1- xStr/maxfa);
                  
               
            }if (i == 2) {
                  x = self.radarView.radius * (1+ xStr/maxChang*sqrt(3)*0.5);
                  y =  self.radarView.radius *(1- xStr/maxChang*0.5);
                  
                
            }if (i == 3) {
                  x = self.radarView.radius * (1- xStr/maxChang*sqrt(3)*0.5);
                  y =  self.radarView.radius *(1+ xStr/maxChang*0.5);
                  
                
            }if (i == 4) {
                  x = self.radarView.radius ;
                  y =  self.radarView.radius *(1+ xStr/maxfa);
                  
                 
            }if (i == 5) {
                  x = self.radarView.radius * (1+ xStr/maxHight*sqrt(3)*0.5);
                  y =  self.radarView.radius *(1+ xStr/maxHight*0.5);
                  
               
            }
            
            
            CGPoint point = CGPointMake(x, y);
            [self.pointsArray addObject:NSStringFromCGPoint(point)];
            
            
      }
     
//           for (int  i = 0; i < 6; i++) {
//            
//            
//            x = arc4random_uniform(self.radarView.height) - self.radarView.height *0.5;
//            y = arc4random_uniform(self.radarView.height) - self.radarView.height *0.5;
//            [self.pointsArray addObject:@[@(x),@(y)]];
//      }
}

- (void)flickAnimationForPoints
{
      static CGFloat opacityNum = 0;
      BOOL ascending = YES;
      if (ascending) {
            opacityNum += 0.1;
            if (opacityNum >= 1) {
                  ascending = NO;
            }
      }else{
            opacityNum -= 0.1;
            if (opacityNum <= 0.2) {
                  ascending = YES;
            }
      }
      NSLog(@"%@----",[NSThread currentThread]);
      self.layer.opacity = opacityNum;
      [self.layer setNeedsDisplay];
      NSLog(@"%@", self.layer);
}

#pragma mark - BYXRadarViewDataSource
- (NSInteger)numberOfSectionsInRadarView:(YXRadarView *)radarView
{
      return 6;
}

- (NSInteger)numberOfPointsInRadarView:(YXRadarView *)radarView
{
      return [self.pointsArray count];
}

#pragma mark ---扫描的颜色------
- (UIView *)radarView:(YXRadarView *)radarView viewForIndex:(NSUInteger)index
{
      UIView *pointView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
//      kUIColorFromRGB(0x0ead6b),kUIColorFromRGB(0x00a5d3),kUIColorFromRGB(0xfd9602)
      if (index == 0 || index == 5) {
            pointView.backgroundColor = kUIColorFromRGB(0x0ead6b);

      }
      if (index == 2|| index == 3) {
            pointView.backgroundColor = kUIColorFromRGB(0xfd9602);
      }
      if (index ==4|| index == 1) {
            pointView.backgroundColor = kUIColorFromRGB(0x00a5d3);
      }
      
      pointView.layer.cornerRadius = pointView.height *0.5;
      pointView.layer.masksToBounds = YES;
     
      
      return pointView;
}

- (CGPoint)radarView:(YXRadarView *)radarView positionForIndex:(NSUInteger)index
{
      
      CGPoint point = CGPointFromString([self.pointsArray objectAtIndex:index]);
     // NSArray *point = [self.pointsArray objectAtIndex:index];
      
     // return CGPointMake([point[0] floatValue], [point[1] floatValue]);
      return point;
}

#pragma mark - BYXRadarViewDelegate

- (void)radarView:(YXRadarView *)radarView didSelectItemAtIndex:(NSUInteger)index
{
      UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"didSelectItemAtiIndex:%lu",(unsigned long)index] message:[NSString stringWithFormat:@"%@",self.pointsArray[index]] preferredStyle:UIAlertControllerStyleAlert];
      UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
      
      [alertController addAction:alertAction];
      [self presentViewController:alertController animated:YES completion:nil];
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
