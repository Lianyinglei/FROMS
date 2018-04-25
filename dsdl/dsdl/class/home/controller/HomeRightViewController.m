//
//  HomeRightViewController.m
//  dsdl
//
//  Created by 廉英雷 on 16/11/29.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import "HomeRightViewController.h"
#import "SJLineChart.h"
#import "HomeLeftHeadView.h"

#import "HomeRightModel.h"
#import "MJExtension.h"

@interface HomeRightViewController ()

@property (nonatomic, weak) HomeLeftHeadView *rView;

@property (nonatomic, weak) HomeLeftHeadView *fView;

/**
 *  日利润一二号机组和计划值得数组
 */
@property (nonatomic, strong) NSMutableArray *dayOneUnitArray;

@property (nonatomic, strong) NSMutableArray *dayTwoUnitArray;

@property (nonatomic, strong) NSMutableArray *dayPlanArray;

@property (nonatomic, strong) NSMutableArray *dayPlanArray2;


@property (nonatomic, strong) NSMutableArray *monthOneUnitArray;

@property (nonatomic, strong) NSMutableArray *monthTwoUnitArray;

@property (nonatomic,strong) NSMutableArray *monthPlanArray;

@property (nonatomic, strong) NSMutableArray *monthPlanArray2;

@property (nonatomic, weak) SJLineChart *lineChart1;

@property (nonatomic, weak) SJLineChart *lineChart2;


@end


@implementation HomeRightViewController

- (void)viewWillAppear:(BOOL)animated{
      [super viewWillAppear:animated];
      self.tabBarController.tabBar.hidden = YES;
}

- (NSMutableArray *)dayOneUnitArray{
      if (!_dayOneUnitArray) {
            _dayOneUnitArray = [NSMutableArray array];
      }
      
      return _dayOneUnitArray;
}

- (NSMutableArray *)dayTwoUnitArray{

      if (!_dayTwoUnitArray) {
            _dayTwoUnitArray = [NSMutableArray array];
      }
      
     
      return _dayTwoUnitArray;
}

- (NSMutableArray *)dayPlanArray{

      if (!_dayPlanArray) {
            _dayPlanArray = [NSMutableArray array];
      }
      
      return _dayPlanArray;
}

- (NSMutableArray *)dayPlanArray2{

      if (!_dayPlanArray2) {
            _dayPlanArray2 = [NSMutableArray array];
      }
      
      return _dayPlanArray2;
}

- (NSMutableArray *)monthPlanArray{

      if (!_monthPlanArray) {
            _monthPlanArray = [NSMutableArray array];
      }
      
      return _monthPlanArray;
}

- (NSMutableArray *)monthPlanArray2{

      if (!_monthPlanArray2) {
            _monthPlanArray2 = [NSMutableArray array];
      }

      return _monthPlanArray2;
}

- (NSMutableArray *)monthOneUnitArray{

      if (!_monthOneUnitArray) {
            _monthOneUnitArray = [NSMutableArray array];
      }
      
      return _monthOneUnitArray;
}

- (NSMutableArray *)monthTwoUnitArray{

      if (!_monthTwoUnitArray) {
            _monthTwoUnitArray = [NSMutableArray array];
      }
      
      return _monthTwoUnitArray;
}


- (void)chageDate:(NSString *)dateStr{

     // NSString *dateStr = @"2017-02-11";
      NSDateFormatter  *formatter1 = [[NSDateFormatter alloc] init];
      [formatter1 setDateFormat:@"yyyy-MM-dd"];
      
      NSDate *date1 = [formatter1 dateFromString:dateStr];
      
      // Get Current Year
      
      NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
      [formatter setDateFormat:@"dd"];
      
      NSString *currentyearString = [NSString stringWithFormat:@"%@",
                                     [formatter stringFromDate:date1]];
      
      NSLog(@"截取的日期----%@",currentyearString);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
      //截取日期
     // [self chageDate];
      [self creatView];
      
//       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(touchEnd) name:@"touchEnd" object:nil];
//       NSLog(@"-------增加了通知--------");
      
      if (!isTest) {
            
            //是否有网络
            if (![Tools isNetWork]) {
                  
                  
                  
                  NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask , YES)lastObject];
                  path = [path stringByAppendingPathComponent:@"getProfits.data"];
                  
                  NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
                  if (dict) {
                        
                        [self successRequest:dict withSender:@"getProfits"];
                        
                  }
            }
             [self getData];
      }
     
}

- (void)getData{

      [self.httpRequest getURL:appServer withUrl:@"profits/getProfits" withParam:nil httpHeader:[Tools HttpHeader] receiveTarget:@"getProfits"];
//      [self.httpRequest getURL:[appServer stringByAppendingString:@"profits/getProfits"] withParam:nil httpHeader:[Tools HttpHeader] receiveTarget:@"getProfits"];
}

- (void)successRequest:(id)data withSender:(NSString *)sender{

      if ([sender isEqualToString:@"getProfits"]) {
            NSDictionary *dict = (NSDictionary *)data;
            
       NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask , YES)lastObject];
            
            path = [path stringByAppendingPathComponent:@"getProfits.data"];
            
            [dict writeToFile:path atomically:YES];
          //  NSArray *days = dict[@"days"];
            
            NSMutableArray *xArray = [NSMutableArray array];
            
            NSString *str;
            for (NSString *dateStr in dict[@"dateTimeX"]) {
                  str = [dateStr stringByAppendingString:@"日"];
                  [xArray addObject:str];
            }
            
            
            self.lineChart1.xMarkArray = xArray;
            NSMutableArray *ary = [HomeRightModel mj_objectArrayWithKeyValuesArray:dict[@"days"]];
            
            for (HomeRightModel *model in ary) {
                  
                  NSString *planProfits = [NSString stringWithFormat:@"%f", [model.planProfitsV1 floatValue]/10000.0];
                  
                  NSString *planProFitV2 = [NSString stringWithFormat:@"%f",[model.planProfitsV2 floatValue]/10000.0];
                   NSString *profitV1 = [NSString stringWithFormat:@"%f", [model.profitsV1 floatValue]/10000.0];
                  
                   NSString *profitV2 = [NSString stringWithFormat:@"%f", [model.profitsV2 floatValue]/10000.0];
                  
                  [self.dayPlanArray addObject:planProfits];
                  [self.dayPlanArray2 addObject:planProFitV2];
                  
                  [self.dayOneUnitArray addObject:profitV1];
                  [self.dayTwoUnitArray addObject:profitV2];
            }
            
           // self.dayOneUnitArray = @[@"-35",@"0",@"0",@"-20",@"30",@"60",@"90"].copy;
            self.lineChart1.valueArray1 = self.dayOneUnitArray;
            self.lineChart1.valueArray2 = self.dayTwoUnitArray;
            self.lineChart1.valueArray3 = self.dayPlanArray;
            
            
            CGFloat maxHeigt = 0.0;
            CGFloat mixFloat = 0.0 ;
            
            
            for (NSString * max in self.dayOneUnitArray) {
                  CGFloat maxFloat = [max floatValue];
                  
                  if (maxFloat <mixFloat) {
                        mixFloat = maxFloat;
                  }
                  
                  if (maxFloat >maxHeigt) {
                        maxHeigt = maxFloat;
                  }
            }

            
            for (NSString * max in self.dayTwoUnitArray) {
                  CGFloat maxFloat = [max floatValue];
                  
                  if (maxFloat <mixFloat) {
                        mixFloat = maxFloat;
                  }
                  
                  if (maxFloat >maxHeigt) {
                        maxHeigt = maxFloat;
                  }
            }

            
            for (NSString * max in self.dayPlanArray) {
                  CGFloat maxFloat = [max floatValue];
                
                  
                  if (maxFloat >maxHeigt) {
                        maxHeigt = maxFloat;
                  }
//                  if (maxFloat <mixFloat) {
//                        mixFloat = maxFloat;
//                  }
            }
            
            maxHeigt = maxHeigt +5;
            
            if (mixFloat <0) {
               CGFloat marige =   (maxHeigt - mixFloat)*0.2;
                  NSMutableArray *yArray = [NSMutableArray array];
                  
                  CGFloat obc = marige;
                  for (int i = 0; i<6; i++) {
                        
                        obc =mixFloat +marige*i;
                        [yArray addObject:[NSString stringWithFormat:@"%2.f",obc]];
                  }
                 
                  self.lineChart1.yMarkTitles = yArray;
                  
            }else{
                 
                  NSInteger one = (NSInteger)maxHeigt/5;
                  self.lineChart1.yMarkTitles = @[@"0",[NSString stringWithFormat:@"%ld",(long)one],[NSString stringWithFormat:@"%ld",(long)one*2],[NSString stringWithFormat:@"%ld",(long)one*3],[NSString stringWithFormat:@"%ld",(long)one*4],[NSString stringWithFormat:@"%ld",(long)one *5]];
            
            }
            self.lineChart1.mixValue = mixFloat;
            self.lineChart1.maxValue = maxHeigt;
            
              [self.lineChart1 mapping];
            
            
//            //日利润显示上边的数据
//            
//            CGFloat powerNum1  = 0;
//            CGFloat powerNum2 = 0;
//            CGFloat power1 = 0;
//            
//            CGFloat powerPlan1 = 0;
//            CGFloat powerPlan2 = 0;
//            CGFloat power2 = 0;
//            
//            
//          powerNum1 = [self.dayOneUnitArray[0] floatValue];
//            powerPlan1 = [self.dayPlanArray.firstObject floatValue];
//            
//             power1 = powerNum1 - powerPlan1;
//            
//            self.rView.oneLab.text = self.dayOneUnitArray.firstObject;
//            
//            if (power1 >0) {
//                  self.rView.oneDevLab.text = [NSString stringWithFormat:@"+%2.f",power1];
//                  self.rView.oneDevLab.textColor = kUIColorFromRGB(0xff0000);
//            }else{
//            
//                  self.rView.oneDevLab.text = [NSString stringWithFormat:@"%2.f",power1];
//                  self.rView.oneDevLab.textColor = kUIColorFromRGB(0x0ead6b);
//            }
//           
//            self.rView.twoLab.text = self.dayTwoUnitArray.lastObject;
//            
//            powerNum2 = [self.dayTwoUnitArray.firstObject floatValue];
//            
//            powerPlan2 = [self.dayPlanArray.lastObject floatValue];
//            power2 = powerNum2 - powerPlan2;
//            
//            if (power2 > 0) {
//                  self.rView.twoDevLab.text = [NSString stringWithFormat:@"+%2.f",power2];
//                  self.rView.twoDevLab.textColor = kUIColorFromRGB(0xff0000);
//            }else{
//            
//                  self.rView.twoDevLab.text = [NSString stringWithFormat:@"%2.f",power2];
//                  self.rView.twoDevLab.textColor = kUIColorFromRGB(0x0ead6b);
//                  
//            }
//

            

            NSMutableArray *monthAry = [HomeRightModel mj_objectArrayWithKeyValuesArray:dict[@"months"]];
            
            //数组倒序
//            monthAry = (NSMutableArray *)[[monthAry reverseObjectEnumerator]allObjects];
            
            //填数据
            
            HomeRightModel *model = monthAry.lastObject;
            
            NSString *timeStr = model.createTime;
            NSString *month = [timeStr substringWithRange:NSMakeRange(8, 2)];
            int  date = [month intValue];
            
            for (int i = 0 ;i<date;i++) {
                  
                  HomeRightModel *model1 = monthAry[i];
                  NSString *timeStr1 = model1.createTime;
                  NSString *month1 = [timeStr1 substringWithRange:NSMakeRange(8, 2)];
                  int date1 = [month1 intValue];
                  if (date1 == i+1) {
                        
                        //                        [array1 insertObject:@"0" atIndex:i+1];
                        //                        [array2 insertObject:@"0" atIndex:i+1];
                  }else{
                        
                        HomeRightModel *model2 = [[HomeRightModel alloc] init];
                        model2.profitsV1 = @"0";
                        model2.profitsV2 = @"0";
                        model2.planProfitsV1 = model.planProfitsV1;
                        model2.planProfitsV2 = model.planProfitsV2;
                        [monthAry insertObject:model2 atIndex:i];
                  }
            }
            

            [self.monthOneUnitArray removeAllObjects];
            [self.monthTwoUnitArray removeAllObjects];
            [self.monthPlanArray removeAllObjects];
            [self.monthPlanArray2 removeAllObjects];
            for (HomeRightModel *model in monthAry) {
                  
                   NSString *profitV1 = [NSString stringWithFormat:@"%f", [model.profitsV1 floatValue]/10000.0];
                   NSString *profitV2 = [NSString stringWithFormat:@"%f", [model.profitsV2 floatValue]/10000.0];
                   NSString *planProfitsV1 = [NSString stringWithFormat:@"%f", [model.planProfitsV1 floatValue]/10000.0];
                   NSString *planProfitsV2 = [NSString stringWithFormat:@"%f", [model.planProfitsV2 floatValue]/10000.0];
                  
                  [self.monthOneUnitArray addObject:profitV1];
                  [self.monthTwoUnitArray addObject:profitV2];
                  
                  [self.monthPlanArray addObject:planProfitsV1];
                  [self.monthPlanArray2 addObject:planProfitsV2];
            }
            
            //进行累加
            
            NSMutableArray *monthArray1 = [NSMutableArray array];
            NSMutableArray *monthArray2 = [NSMutableArray array];
            
            
            for (int i = 0; i<self.monthOneUnitArray.count; i++) {
                  
                  CGFloat num = 0;
                  for (int j = 0; j<=i; j++) {
                        
                        num +=[self.monthOneUnitArray[j] floatValue];
                        
                        
                  }
                  [monthArray1 addObject:[NSString stringWithFormat:@"%f",num]];
            }
            
            for (int i = 0; i<self.monthTwoUnitArray.count; i++) {
                  
                  CGFloat num = 0;
                  for (int j = 0; j<=i; j++) {
                        
                        num +=[self.monthTwoUnitArray[j] floatValue];
                        
                  }
                  [monthArray2 addObject:[NSString stringWithFormat:@"%f",num]];
            }

//                        [monthArray1 addObject:@"100"];
//                        [monthArray2 addObject:@"0"];
            self.monthOneUnitArray = monthArray1;
            self.monthTwoUnitArray = monthArray2;
            
      self.lineChart2.valueArray2 = monthArray2;
          self.lineChart2.valueArray1 = monthArray1;
         
         //   self.monthOneUnitArray = @[@"-100",@"-1000",@"-500",@"2000"].copy;
      
//            self.lineChart2.valueArray3 = self.monthPlanArray;
            
            if (self.monthPlanArray.count >0) {
                
                 // HomeRightModel *model = monthAry[0];
      self.lineChart2.lineArray = @[self.monthPlanArray[0]];
//                  self.lineChart2.lineArray = @[@"40"];
                  
                  CGFloat  maxMonth = 0.0;
                  CGFloat samll = 0.0;
                  
                  for (NSString *mix in self.monthOneUnitArray) {
                        CGFloat num = [mix floatValue];
                        if (samll >num) {
                              samll = num;
                        }
                        
                        if (num >maxMonth) {
                              maxMonth = num;
                              
                        }

                  }
                  
                  for (NSString *mix in self.monthTwoUnitArray) {
                        CGFloat num = [mix floatValue];
                        if (samll >num) {
                              samll = num;
                        }
                        
                        if (num >maxMonth) {
                              maxMonth = num;
                        }

                  }
                  
                  for (NSString * max in self.monthPlanArray) {
                        
                        CGFloat maxFloat = [max floatValue];
                        if (maxFloat >maxMonth) {
                              maxMonth = maxFloat;
                        }
                  }
                  
                  maxMonth = maxMonth+50;
                  if (samll <0) {
                        CGFloat marige =   (maxMonth - samll)*0.2;
                        NSMutableArray *yArray = [NSMutableArray array];
                        
                        CGFloat obc = marige;
                        for (int i = 0; i<6; i++) {
                              
                              obc =samll +marige*i;
                              [yArray addObject:[NSString stringWithFormat:@"%2.f",obc]];
                        }
                        
                        self.lineChart2.yMarkTitles = yArray;
                        
                  }else{
                  
                        NSInteger month = (NSInteger)maxMonth/5;
                        self.lineChart2.yMarkTitles = @[@"0",[NSString stringWithFormat:@"%ld",(long)month],[NSString stringWithFormat:@"%ld",(long)month*2],[NSString stringWithFormat:@"%ld",(long)month*3],[NSString stringWithFormat:@"%ld",(long)month*4],[NSString stringWithFormat:@"%ld",(long)month *5]];
                  
                  }
                  
                  
                  self.lineChart2.maxValue = maxMonth;
                  self.lineChart2.mixValue = samll;
                 
            }
          
            
            [self.lineChart2 mapping];
            [self touchEnd];
            
            
            
                  }
}
//- (void)dealloc{
//      
//      
//      [[NSNotificationCenter  defaultCenter] removeObserver:self name:@"touchEnd" object:nil];
//      
//      NSLog(@"dealloc-------移除了通知--------");
//}

- (void)touchEnd{
      
      if (!isTest) {
            if (self.dayOneUnitArray.count>0 && self.dayTwoUnitArray.count>0) {
                  
            
            CGFloat oneNum = [self.dayOneUnitArray.lastObject floatValue];
            CGFloat twoNum = [self.dayTwoUnitArray.lastObject floatValue];
            CGFloat playNum = [self.dayPlanArray.lastObject floatValue];
                  
                  
            CGFloat devNum = oneNum -playNum;
           // self.rView.oneLab.text = [Tools getNumberTwo: self.dayOneUnitArray.lastObject];
                  
                 // self.rView.oneLab.text = [NSString stringWithFormat:@"%.2f",[self.dayOneUnitArray.lastObject floatValue]];
                  self.rView.oneLab.text = [Tools getNumberTwo:self.dayOneUnitArray.lastObject];
            if (devNum>=0) {
                 // self.rView.oneDevLab.text = [NSString stringWithFormat:@"+%.2f",devNum];
                  self.rView.oneDevLab.text = [Tools getNumberTwo:[NSString stringWithFormat:@"+%f",devNum]];
                  self.rView.oneDevLab.textColor = kUIColorFromRGB(0xff0000);
            }else{
                  self.rView.oneDevLab.text = [NSString stringWithFormat:@"%.2f",devNum];
                    self.rView.oneDevLab.text = [Tools getNumberTwo:[NSString stringWithFormat:@"%f",devNum]];
                  self.rView.oneDevLab.textColor = kUIColorFromRGB(0x05985d);
                  
            }
            
            CGFloat devNum2 =twoNum- [self.dayPlanArray2.lastObject floatValue];
            self.rView.twoLab.text = [Tools getNumberTwo: self.dayTwoUnitArray.lastObject];
                  
                  //self.rView.twoLab.text = [NSString stringWithFormat:@"%.2f",[self.dayTwoUnitArray.lastObject floatValue]];
                  self.rView.twoLab.text = [Tools getNumberTwo:self.dayTwoUnitArray.lastObject];
            if (devNum2>=0) {
                  //self.rView.twoDevLab.text = [NSString stringWithFormat:@"+%.2f",devNum2];
                  self.rView.twoDevLab.text = [Tools getNumberTwo:[NSString stringWithFormat:@"+%f",devNum2]];
                  self.rView.twoDevLab.textColor = kUIColorFromRGB(0xff0000);
            }else{
               //   self.rView.twoDevLab.text = [NSString stringWithFormat:@"%.2f",devNum2];
                  self.rView.twoDevLab.text = [Tools getNumberTwo:[NSString stringWithFormat:@"%f",devNum2]];
                  self.rView.twoDevLab.textColor = kUIColorFromRGB(0x05985d);
                  
            }
            }
            
            if (self.monthOneUnitArray.count>0 && self.monthTwoUnitArray.count>0) {
      
            CGFloat oneNum4 = [self.monthOneUnitArray.lastObject floatValue];
            CGFloat twoNum4 = [self.monthTwoUnitArray.lastObject floatValue];
            
            CGFloat devNum4 = oneNum4 -  [self.monthPlanArray.firstObject floatValue];
           // self.fView.oneLab.text =  [NSString stringWithFormat:@"%.2f" ,[self.monthOneUnitArray.lastObject floatValue]];
                  self.fView.oneLab.text = [Tools getNumberTwo:self.monthOneUnitArray.lastObject];
            
            if (devNum4>=0) {
                 // self.fView.oneDevLab.text = [NSString stringWithFormat:@"+%.2f",devNum4];
                  self.fView.oneDevLab.text = [Tools getNumberTwo:[NSString stringWithFormat:@"+%f",devNum4]];
                  self.fView.oneDevLab.textColor = kUIColorFromRGB(0xff0000);
            }else{
                 // self.fView.oneDevLab.text = [NSString stringWithFormat:@"%.2f",devNum4];
                  self.fView.oneDevLab.text = [Tools getNumberTwo:[NSString stringWithFormat:@"%f",devNum4]];
                  self.fView.oneDevLab.textColor = kUIColorFromRGB(0x05985d);
                  
            }
            
            CGFloat devNum5 =twoNum4 - [self.monthPlanArray2.firstObject floatValue];
           // self.fView.twoLab.text = [NSString stringWithFormat:@"%.2f" ,[self.monthTwoUnitArray.lastObject floatValue]];
                  self.fView.twoLab.text = [Tools getNumberTwo:self.monthTwoUnitArray.lastObject];
            if (devNum5>=0) {
                //  self.fView.twoDevLab.text = [NSString stringWithFormat:@"+%.2f",devNum5];
                  self.fView.twoDevLab.text = [Tools getNumberTwo:[NSString stringWithFormat:@"+%f",devNum5]];
                  self.fView.twoDevLab.textColor = kUIColorFromRGB(0xff0000);
            }else{
                  self.fView.twoDevLab.text = [NSString stringWithFormat:@"%.2f",devNum5];
                  self.fView.twoDevLab.text = [Tools getNumberTwo:[NSString stringWithFormat:@"%f",devNum5]];
                  self.fView.twoDevLab.textColor = kUIColorFromRGB(0x05985d);
                  
            }
            
            }

      }else{
      
                  self.fView.oneLab.text = @"2300";
                  self.fView.oneDevLab.text = @"+50";
            
            
                  self.fView.twoLab.text = @"2170";
                  self.fView.twoDevLab.text = @"-74";
            
            
                  self.rView.oneLab.text = @"70.24";
                  self.rView.oneDevLab.text = @"-4.76";
            self.rView.oneDevLab.textColor = kUIColorFromRGB(0x05985d);
                  
                  self.rView.twoLab.text = @"66.46";
                  self.rView.twoDevLab.text = @"-9.54";
            
      }
     
     

      
      
      
     


}


- (void)customNavigationBar{

      [super customNavigationBar];
      self.view.backgroundColor = kUIColorFromRGB(0xd7dde4);
      UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
      lab.text = @"数字东胜";
      lab.font = [UIFont systemFontOfSize:17];
      lab.textAlignment = NSTextAlignmentCenter;
      lab.textColor = [UIColor whiteColor];
      self.navigationItem.titleView = lab;
}


- (void)creatView{
    

      UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _width, (_height-70)*0.5)];
      [self.view addSubview:headView];
      headView.backgroundColor = [UIColor whiteColor];
      
      HomeLeftHeadView *rView = [[NSBundle mainBundle] loadNibNamed:@"HomeLeftHeadView" owner:self options:nil].lastObject;;
      rView.frame = CGRectMake(0, 0, headView.width, 80);
      rView.backgroundColor = [UIColor whiteColor];
      rView.leftTitle.text = @"日利润(万元)";
      [headView addSubview:rView];
      self.rView = rView;
      
     
      
      // 初始化折线图
      SJLineChart *lineChart = [[SJLineChart alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(rView.frame), headView.width-60, headView.height - rView.height -5)];
      self.lineChart1 = lineChart;
      [lineChart setXMarkTitlesAndValues: @[@{@"key1":@"",@"value1":@""}]titleKey:@"key1" valueKey:@"value1"];
      
      __weak typeof(self)welfSelf = self;
      lineChart.lineChartBlock = ^(NSArray *strAry,NSInteger index){
            
            CGFloat oneNum = [strAry[0] floatValue];
            CGFloat twoNum = [strAry[1] floatValue];
            CGFloat planOneNum = [welfSelf.dayPlanArray[index] floatValue];
            CGFloat planTwoNum = [welfSelf.dayPlanArray2[index] floatValue];
            
            CGFloat devNum = oneNum- planOneNum;
          //  rView.oneLab.text = [NSString stringWithFormat:@"%.2f",[ strAry[0]floatValue]];
            rView.oneLab.text = [Tools getNumberTwo:strAry[0]];
            if (devNum>=0) {
                  //rView.oneDevLab.text = [NSString stringWithFormat:@"+%.2f",devNum];
                  rView.oneDevLab.text = [@"+" stringByAppendingString: [Tools getNumberTwo:[NSString stringWithFormat:@"%f",devNum]]];
                  rView.oneDevLab.textColor = kUIColorFromRGB(0xff0000);
            }else{
                 // rView.oneDevLab.text = [NSString stringWithFormat:@"%.2f",devNum];
                  rView.oneDevLab.text = [Tools getNumberTwo:[NSString stringWithFormat:@"%f",devNum]];
                  rView.oneDevLab.textColor = kUIColorFromRGB(0x05985d);
                  
            }
            
//            if (self.lineChart2.valueArray2.count >0) {
            
            
            CGFloat devNum2 = twoNum - planTwoNum;
           // rView.twoLab.text = [NSString stringWithFormat:@"%.2f", [strAry[1]floatValue ]];
            
            rView.twoLab.text = [Tools getNumberTwo:strAry[1]];
            if (devNum2>=0) {
                 // rView.twoDevLab.text = [NSString stringWithFormat:@"+%.2f",devNum2];
                  rView.twoDevLab.text = [@"+" stringByAppendingString: [Tools getNumberTwo:[NSString stringWithFormat:@"%f",devNum2]]];
                  rView.twoDevLab.textColor = kUIColorFromRGB(0xff0000);
                  
            }else{
                  //rView.twoDevLab.text = [NSString stringWithFormat:@"%.2f",devNum2];
                  rView.twoDevLab.text = [Tools getNumberTwo:[NSString stringWithFormat:@"%f",devNum2]];
                  rView.twoDevLab.textColor = kUIColorFromRGB(0x05985d);
                  
            }
            
            
            
            
      };
      
      
      // 设置折线图属性
      
      lineChart.title = @"计划日利润"; // 折线图名称
      lineChart.maxValue = 330000;   // 最大值
     // lineChart.yMarkTitles = @[@"0",@"20",@"40",@"60",@"80",@"100"]; // Y轴刻
      lineChart.leftColor = kUIColorFromRGB(0x05985d);
      
      lineChart.isHome = YES;
       [headView addSubview:lineChart];
      
       [lineChart setXMarkTitlesAndValues:@[@{@"item":@"1时",@"count":@60},@{@"item":@"5时",@"count":@31},@{@"item":@"9时",@"count":@50},@{@"item":@"13时",@"count":@67},@{@"item":@"17时",@"count":@66},@{@"item":@"21时",@"count":@60},@{@"item":@"24时",@"count":@12}] titleKey:@"item" valueKey:@"count"];
      
      if (isTest) {
            
                  lineChart.valueArray2 = @[@30,@20,@60,@30,@40,@50,@60,@49,@45,@67,@89,@78,@60,@80,@49,@45,@49,@45,@27,@29,@38,@40,@40,@29,@25,@38,@40,@40,@29,@25,];
                  lineChart.valueArray1 = @[@60,@80,@49,@45,@67,@89,@78,@60,@80,@49,@45,@67,@89,@78,@60,@80,@49,@45,@67,@89,@78,@60,@80,@49,@45,@78,@60,@80,@49,@45].mutableCopy;
                  lineChart.valueArray3 = @[@100,@100,@100,@100,@100,@100,@100,@100,@100,@100,@100,@100,@100,@100,@100,@100,@100,@100,@100,@100,@100,@100,@100,@100,@100,@100,@100,@100,@100,@100,@100,@100,@100];
            self.dayPlanArray =  @[@100,@100,@100,@100,@100,@100,@100,@100,@100,@100,@100,@100,@100,@100,@100,@100,@100,@100,@100,@100,@100,@100,@100,@100,@100,@100,@100,@100,@100,@100,@100,@100,@100].copy;
            
            self.dayPlanArray2 = self.dayPlanArray;
            //      lineChart.xMarkTitles = @[@"1日",@"2日",@"3日",@"4日",@"5日",@"6日",@"7日",@"8日",@"9日",@"10日",@"11日",@"12日",@"13日",@"14日",@"15日",@"16日",@"17日",@"18日",@"19日",@"20日",@"21日",@"22日",@"23日",@"24日",@"25日",@"26日",@"27日",@"28日",@"29日",@"30日",@"31日"].mutableCopy;
           
            lineChart.maxValue = 150;
            [lineChart mapping];
           
      }

       // X轴刻度标签及相应的值
      
      
      // lineChart.xScaleMarkLEN = 60; // 可以不设，会根据视图的宽度自适应,设置后如果折线图的宽度大于视图宽度，折线图可以滑动
      
      //设置完数据等属性后绘图折线图
    //  [lineChart mapping];
      
     
      
      
      
   //   --------------footerView-----------
  
  
      UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headView.frame)+5, _width, (_height -70)*0.5)];
      [self.view addSubview:footView];
      footView.backgroundColor = [UIColor whiteColor];
      
      HomeLeftHeadView *fView = [[NSBundle mainBundle] loadNibNamed:@"HomeLeftHeadView" owner:self options:nil].lastObject;;
      fView.frame = CGRectMake(0, 0, headView.width, 100);
      fView.backgroundColor = [UIColor whiteColor];
      [footView addSubview:fView];
      self.fView = fView;
      
      fView.leftTitle.text = @"月利润(万元)";
      
      
//       UIView *colorView = [[UIView alloc] initWithFrame:CGRectMake(30, fView.height - 15, 10, 10)];
//      [fView addSubview:colorView];
//      colorView.backgroundColor = kUIColorFromRGB(0x00a5d3);
      
//      UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(colorView.frame)+6, fView.height - 20, 150, 20)];
//      
//      lab.text = @"1#月利润计划值";
//      lab.font = [UIFont systemFontOfSize:13];
//      lab.textAlignment = NSTextAlignmentLeft;
//      lab.textColor = kUIColorFromRGB(0x333333);
//      [fView addSubview:lab];
      
      // 初始化折线图
      SJLineChart *lineChart2 = [[SJLineChart alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(rView.frame)+5, headView.width-60, footView.height - rView.height-5)];
      
      self.lineChart2 = lineChart2;
      
      [lineChart2 setXMarkTitlesAndValues: @[@{@"key1":@"",@"value1":@""}]titleKey:@"key1" valueKey:@"value1"];
      
      lineChart2.lineChartBlock = ^(NSArray *strAry,NSInteger index){
            
            CGFloat oneNum = [strAry[0] floatValue];
            CGFloat twoNum = [strAry[1] floatValue];
            CGFloat playOneNum = 0;
            CGFloat planTwoNum = 0;
            if (welfSelf.monthPlanArray.count > 0) {
                  playOneNum = [welfSelf.monthPlanArray[0] floatValue];
            }
            if (welfSelf.monthTwoUnitArray.count >0) {
                  planTwoNum = [welfSelf.monthPlanArray2[0] floatValue];
            }
            
            CGFloat devNum = oneNum - playOneNum ;
           // fView.oneLab.text =  [NSString stringWithFormat:@"%.2f",[strAry[0] floatValue]];
            fView.oneLab.text = [Tools getNumberTwo:strAry[0]];
            
            if (devNum>=0) {
                 // fView.oneDevLab.text = [NSString stringWithFormat:@"+%.2f",devNum];
                  fView.oneDevLab.text =[@"+" stringByAppendingString: [Tools getNumberTwo:[NSString stringWithFormat:@"%f",devNum]]];
                  fView.oneDevLab.textColor = kUIColorFromRGB(0xff0000);
            }else{
                  //fView.oneDevLab.text = [NSString stringWithFormat:@"%.2f",devNum];
                  fView.oneDevLab.text = [Tools getNumberTwo:[NSString stringWithFormat:@"%f",devNum]];
                  fView.oneDevLab.textColor = kUIColorFromRGB(0x05985d);
                  
            }
            
            CGFloat devNum2 =twoNum - planTwoNum;
           // fView.twoLab.text =  [NSString stringWithFormat:@"%.2f",[strAry[1] floatValue]];
            fView.twoLab.text = [Tools getNumberTwo:strAry[1]];
            if (devNum2>=0) {
                 // fView.twoDevLab.text = [NSString stringWithFormat:@"+%.2f",devNum2];
                  fView.twoDevLab.text = [ @"+" stringByAppendingString:[Tools getNumberTwo:[NSString stringWithFormat:@"+%f",devNum2]]];
                  fView.twoDevLab.textColor = kUIColorFromRGB(0xff0000);
            }else{
                  //fView.twoDevLab.text = [NSString stringWithFormat:@"%.2f",devNum2];
                  fView.twoDevLab.text = [Tools getNumberTwo:[NSString stringWithFormat:@"%f",devNum2]];
                  fView.twoDevLab.textColor = kUIColorFromRGB(0x05985d);
                  
            }
            
      };

      
      // 设置折线图属性
      lineChart2.title = @"月利润计划值"; // 折线图名称
      lineChart2.maxValue = 3000;   // 最大值
     // lineChart2.isHome = YES;
     
      lineChart2.isCurve = NO;

      lineChart2.leftColor = kUIColorFromRGB(0x05985d);
      lineChart2.isDotte = YES;
       [footView addSubview:lineChart2];
       [lineChart2 setXMarkTitlesAndValues:@[@{@"item":@"1日",@"count":@100},@{@"item":@"6日",@"count":@600},@{@"item":@"11日",@"count":@800},@{@"item":@"16日",@"count":@1000},@{@"item":@"21日",@"count":@1500},@{@"item":@"26日",@"count":@1800},@{@"item":@"31日",@"count":@2000}] titleKey:@"item" valueKey:@"count"];
      
      if (isTest) {
            
             lineChart2.yMarkTitles = @[@"0",@"500",@"1000",@"1500",@"2000",@"2500",@"3000"]; // Y轴刻度标签
                   lineChart2.valueArray1 = @[@20,@30,@40,@50,@60,@70,@80,@100,@200,@400,@500,@700,@800,@900,@1200,@1300,@1500,@1600,@1700,@1800,@1900,@2000,@2100].mutableCopy;
            
                  lineChart2.valueArray2 = @[@100,@110,@120,@130,@140,@160,@200,@300,@400,@600,@700,@900,@1100,@1300,@1500,@1600,@1800,@1900,@2200,@2300,@2400,@2500,@2600];
          //  lineChart2.valueArray3 = @[@2800,@2800,@2800,@2800,@2800,@2800,@2800,@2800,@2800,@2800,@2800,@2800,@2800,@2800,@2800,@2800,@2800,@2800,@2800,@2800,@2800,@2800,@3000],
            
            lineChart2.maxValue = 3000;
            lineChart2.lineArray = @[@"2900"];
         //   lineChart2.xMarkTitles = @[@"1日",@"2日",@"3日",@"4日",@"5日",@"6日",@"7日",@"8日",@"9日",@"10日",@"11日",@"12日",@"13日",@"14日",@"15日",@"16日",@"17日",@"18日",@"19日",@"20日",@"21日",@"22日",@"23日",@"24日",@"25日",@"26日",@"27日",@"28日",@"29日",@"30日",@"31日"];
            // X轴刻度标签及相应的值

            [lineChart2 mapping];
            [self touchEnd];
      }


//      [lineChart2 setXMarkTitlesAndValues:@[@{@"item":@"1日",@"count":@100},@{@"item":@"6日",@"count":@600},@{@"item":@"11日",@"count":@800},@{@"item":@"16日",@"count":@1000},@{@"item":@"21日",@"count":@1500},@{@"item":@"26日",@"count":@1800},@{@"item":@"31日",@"count":@2000}] titleKey:@"item" valueKey:@"count"]; // X轴刻度标签及相应的值
      
      
      // lineChart.xScaleMarkLEN = 60; // 可以不设，会根据视图的宽度自适应,设置后如果折线图的宽度大于视图宽度，折线图可以滑动
      
      //设置完数据等属性后绘图折线图
     // [lineChart2 mapping];
      
     
      
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
