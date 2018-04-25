//
//  KeyViewController.m
//  dsdl
//
//  Created by 廉英雷 on 16/11/14.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

//关键指标
#import "KeyViewController.h"
#import "KeyLeftView.h"
#import "KeyRightView.h"
#import "KeyRightView.h"
#import "ZFProgressView.h"
#import "ProfitContentView.h"
#import "NSString+Extension.h"
#import "JHColumnChart.h"
#import "keyFooterView.h"
#import "SJLineChart.h"
#import "KeyModel.h"
#import "MJExtension.h"
#import "KeyDayModel.h"


@interface KeyViewController ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic,weak) UIPageControl *page;

@property (nonatomic, strong) NSMutableArray *monthDataArray;

//@property (nonatomic, strong) NSMutableArray *planGeneraArray;
//
//@property (nonatomic, strong) NSMutableArray *planSupplyArray;


@property (nonatomic, weak)  ProfitContentView *profitView;

@property (nonatomic, weak) ZFProgressView *progressView1;

@property (nonatomic, weak) ZFProgressView *progressView2;

@property (nonatomic, weak) ZFProgressView *progressView3;

@property (nonatomic, weak) JHColumnChart *chartView;

@property (nonatomic, weak) SJLineChart *lineChart2;

@property (nonatomic, weak) keyFooterView *keyFootView1;

//@property (nonatomic, weak) keyFooterView *keyFootView2;

@property (nonatomic, weak) keyFooterView *keyFootView3;


@end

@implementation KeyViewController

//- (NSMutableArray *)planGeneraArray{
//
//      if (!_planGeneraArray) {
//            _planGeneraArray  = [NSMutableArray array];
//      }
//      
//      return _planGeneraArray;
//}
//
//- (NSMutableArray *)planSupplyArray{
//
//      if (!_planSupplyArray ) {
//            _planSupplyArray = [NSMutableArray array];
//      }
//      
//      return _planSupplyArray;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
      self.view.backgroundColor = [UIColor whiteColor];
      [self customNavigationBar];
      [self creatContentView];
      if (!isTest) {
            
            //是否有网络
            if (![Tools isNetWork]) {
                  
                  
                  
                  NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask , YES)lastObject];
                  path = [path stringByAppendingPathComponent:@"getIndicatorsDay.data"];
                  
                  NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
                  if (dict) {
                        
                        [self successRequest:dict withSender:@"getIndicatorsDay"];
                        
                  }
                  //
                  NSString *path2 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask , YES)lastObject];
                  
                  [path2 stringByAppendingPathComponent:@"getIndicatorsMonth.data"];
                  NSDictionary *dict2 = [NSDictionary dictionaryWithContentsOfFile:path2];
                  if (dict2) {
                        [self successRequest:dict2 withSender:@"getIndicatorsMonth"];
                  }
                  
            }else{
            
                   [self getData];
            }

            
      }
     
    }


- (NSMutableArray *)monthDataArray{

      if (!_monthDataArray) {
            _monthDataArray = [NSMutableArray array];
      }
      return _monthDataArray;
}
- (void)viewWillAppear:(BOOL)animated{
      [super viewWillAppear:animated];
      self.tabBarController.tabBar.hidden = YES;
      
}

- (void)getData{

   //   __weak typeof(self)weakself = self;

             [self.httpRequest getURL:appServer withUrl:@"indicators/getIndicatorsDay" withParam:nil httpHeader:[Tools HttpHeader] receiveTarget:@"getIndicatorsDay"];
           
              [self.httpRequest getURL:appServer withUrl:@"indicators/getIndicatorsMonth" withParam:nil  httpHeader:[Tools HttpHeader] receiveTarget:@"getIndicatorsMonth"];
      
      
//       [self.httpRequest getURL:appServer withUrl:@"indicators/getIndicatorsMonth" withParam:nil httpHeader:[Tools HttpHeader] receiveTarget:@"getIndicatorsMonth"];
      
//      [self.httpRequest getURL:[appServer stringByAppendingString:@"indicators/getIndicatorsDay"] withParam:nil httpHeader:[Tools HttpHeader] receiveTarget:@"getIndicatorsDay"];
      
     
//      [self.httpRequest getURL:[appServer stringByAppendingString:@"indicators/getIndicatorsMonth"] withParam:nil httpHeader:[Tools HttpHeader] receiveTarget:@"getIndicatorsMonth"];
      
}

- (void)http2{
      
 

}

- (void)errorRequest:(id)data withSender:(NSString *)sender{

      if ([sender isEqualToString:@"getIndicatorsDay"]) {
      
            NSLog(@"-----%@",data[@"message"]);
            CGFloat p = 0.00;
            [self.progressView1 setProgress:p Animated:YES];
           
            [self.progressView3 setProgress:p Animated:YES];
            self.chartView.valueArr = @[@[@0,@0],@[@0,@0],@[@0,@0],@[@0,@0],
                                        @[@0,@0],@[@0,@0],];
            
            
            [self.chartView showAnimation];
             [self.chartView showAnimation];
            
         
            
           
            
      }

}

- (void)netFailedWithError:(NSError *)error{

      NSLog(@"=--%@",[error localizedDescription]);
      
     }
- (void)successRequest:(id)data withSender:(NSString *)sender{

      if ([sender isEqualToString:@"getIndicatorsDay"]) {
            
            NSDictionary *dict = (NSDictionary *)data;
            
            if ([dict isKindOfClass:[NSNull class]]) {
                  
                  
            }else{
             NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask , YES)lastObject];
            path = [path stringByAppendingPathComponent:@"getIndicatorsDay.data"];
            
          
            
            [dict writeToFile:path atomically:YES];
            
            
            
            KeyDayModel *dayModel = [KeyDayModel mj_objectWithKeyValues:dict];
            
            
//             self.profitView.dataAry = @[@([dayModel.powerGenerationV1 floatValue] +[dayModel.powerGenerationV2 floatValue]),@([dayModel.powerSupplyV1 floatValue] +[dayModel.powerSupplyV2 floatValue]),@([dayModel.electricityV1 floatValue] + [dayModel.electricityV2 floatValue])];
            
//            CGFloat dayNum = [dayModel.powerGenerationV1 floatValue] +[dayModel.powerGenerationV2 floatValue];
//            CGFloat monthNum = [dayModel.powerSupplyV1 floatValue] +[dayModel.powerSupplyV2 floatValue];
          //  CGFloat electNum = [dayModel.electricityV1 floatValue] + [dayModel.electricityV2 floatValue];
            self.profitView.dataAry = @[dayModel.powerGenerationV1,dayModel.powerGenerationV2,[dayModel.electricityV1 stringByAppendingString:@"%"],[dayModel.electricityV2 stringByAppendingString:@"%"]];
            
            CGFloat p1 = ([dayModel.powerGenerationV1 floatValue])/([dayModel.powerGenerationV1 floatValue]+[dayModel.powerGenerationV2 floatValue]);
            
//            CGFloat p2 = ([dayModel.powerSupplyV1 floatValue] +[dayModel.powerSupplyV2 floatValue]) /([dayModel.supplyPlanV1 floatValue]+ [dayModel.supplyPlanV2 floatValue]);
            
            CGFloat p3 = ([dayModel.electricityV1 floatValue])/([dayModel.electricityV1 floatValue] +[dayModel.electricityV2 floatValue]);
            
            [self.progressView1 setProgress:p1 Animated:YES];
           // [self.progressView2 setProgress:p2 Animated:YES];
            [self.progressView3 setProgress:p3 Animated:YES];
            
           
            
//            NSArray *dataAry = @[@[dayModel.powerGenerationV1 ,dayModel.generationPlanV1],@[dayModel.powerSupplyV1,dayModel.supplyPlanV1],@[dayModel.electricityV1,dayModel.electricityPlanV1],@[dayModel.powerGenerationV2,dayModel.generationPlanV2],@[dayModel.powerSupplyV2,dayModel.supplyPlanV2],@[dayModel.electricityV2,dayModel.electricityPlanV2]];
            
            NSArray *dataAry = @[@[dayModel.powerGenerationV1 ,dayModel.powerGenerationV2],@[dayModel.powerSupplyV1,dayModel.powerSupplyV2],@[dayModel.electricityV1,@"0"],@[dayModel.powerGenerationV2,dayModel.generationPlanV2],@[dayModel.powerSupplyV2,dayModel.supplyPlanV2],@[dayModel.electricityV2,@"0"]];
            
            dataAry = @[@[@"0.00",@"0.00"],@[dayModel.powerGenerationV1,dayModel.electricityV1],@[@"0.00",@"0.00"],@[dayModel.powerGenerationV2,dayModel.electricityV2],@[@"0.00",@"0.00"]];
            self.chartView.valueArr = dataAry;
            
            [self.chartView showAnimation];
//
      }
      
      }
      
      if ([sender isEqualToString:@"getIndicatorsMonth"]) {
            
           
            NSArray *ary = (NSArray *)data;
            
            if ([ary isKindOfClass:[NSNull class]]) {
                  
            }else{
            
            NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask , YES)lastObject];
            path = [path stringByAppendingPathComponent:@"getIndicatorsMonth.data"];
            
            
            NSLog(@"地址----%@",path);
            
            [ary writeToFile:path atomically:YES];
            self.monthDataArray = [KeyModel mj_objectArrayWithKeyValuesArray:ary];
           
            
                  NSMutableArray *array1 = [NSMutableArray array];
                //  NSMutableArray *array2 = [NSMutableArray array];
                 // NSMutableArray *array3 = [NSMutableArray array];
            CGFloat powerNum  = 0;
//            CGFloat supplyNum = 0;
//          
//            
//            CGFloat powerPlan = 0;
//            CGFloat supplyPlan = 0;
           // CGFloat  electPlan = 0;
            
            KeyModel *model = self.monthDataArray.lastObject;
            
            NSString *timeStr = model.createTime;
            NSString *month = [timeStr substringWithRange:NSMakeRange(8, 2)];
            int  date = [month intValue];
            
            for (int i = 0 ;i<date;i++) {
                  
                  KeyModel *model1 = self.monthDataArray[i];
                  NSString *timeStr1 = model1.createTime;
                  NSString *month1 = [timeStr1 substringWithRange:NSMakeRange(8, 2)];
                  int date1 = [month1 intValue];
                  if (date1 == i+1) {
                        
                        
//                        [array1 insertObject:@"0" atIndex:i+1];
//                        [array2 insertObject:@"0" atIndex:i+1];
                  }else{
                  
                        KeyModel *model2 = [[KeyModel alloc] init];
                        model2.powerGeneration = @"0";
//                        model2.powerSupply = @"0";
//                        model2.generationPlan = model.generationPlan;
//                        model2.supplyPlan = model.supplyPlan;
                        [self.monthDataArray insertObject:model2 atIndex:i];
                  }
            }
            

            
            
                  for (KeyModel *model in self.monthDataArray) {
                        
                        [array1 addObject:model.powerGeneration];
                      //  [array2 addObject:model.powerSupply];
                       // [array3 addObject:model.electricity];
                        
//                        [self.planGeneraArray addObject:model.generationPlan];
//                        [self.planSupplyArray addObject:model.supplyPlan];
                        
//                        powerNum += [model.powerGeneration floatValue];
//                       
//                        supplyNum += [model.powerSupply floatValue];
//                           electNUm += [model.electricity floatValue];
//                        
//                         powerPlan = [model.generationPlan floatValue];
//                        supplyPlan = [model.supplyPlan floatValue];
                      
                      // electPlan = [model.electricityPlan floatValue];
                        
                  }
            
            
            
           
            NSMutableArray *monthArray1 = [NSMutableArray array];
           // NSMutableArray *monthArray2 = [NSMutableArray array];
            
           
            for (int i = 0; i<array1.count; i++) {
                  
                   CGFloat num = 0;
                  for (int j = 0; j<=i; j++) {
                        
                         num +=[array1[j] floatValue];
                       
                        
                  }
                   [monthArray1 addObject:[NSString stringWithFormat:@"%f",num]];
            }
            
//            for (int i = 0; i<array2.count; i++) {
//                  
//                  CGFloat num = 0;
//                  for (int j = 0; j<=i; j++) {
//                        
//                        num +=[array2[j] floatValue];
//                        
//                        
//                  }
//                  [monthArray2 addObject:[NSString stringWithFormat:@"%f",num]];
//            }

           
            self.lineChart2.valueArray1 = monthArray1;
            
            CGFloat maxNum = 0;
            for (NSString *numStr in monthArray1) {
                  
                  CGFloat num = [numStr floatValue];
                  
                  
                  if (num >maxNum) {
                        
                        maxNum = num;
                  }
            }
            
            self.lineChart2.maxValue = maxNum;
           // self.lineChart2.valueArray2 = monthArray2;
          //  self.lineChart2.valueArray3 = array3;
            
            
            if ( monthArray1.count>0 ) {
                  
              //    KeyModel *model = self.monthDataArray.firstObject;
                  
//                  powerNum = [model.powerGeneration floatValue];
                  powerNum = [monthArray1.lastObject floatValue];
                  
//                  supplyNum = [model.powerSupply floatValue];
//                  supplyNum = [monthArray2.lastObject floatValue];
//                  
//                  powerPlan = [model.generationPlan floatValue];
//                  
//                  supplyPlan = [model.supplyPlan floatValue];
            }

            
             // self.lineChart2.lineArray = @[@(powerPlan)];
            
            self.keyFootView1.numLab.text = [NSString stringWithFormat:@"%.2f",powerNum];
                  
                  [self.lineChart2 mapping];
                  
                  
                  
            }
//            CGFloat powerP =  powerPlan -powerNum;
//            
//            if (powerP >0) {
//                  
//                  self.keyFootView1.devLab.text = [NSString stringWithFormat:@"+%.2f",powerP];
//                  self.keyFootView1.devLab.textColor = kUIColorFromRGB(0xff0000);
//                  
//            }else {
//            
//                  self.keyFootView1.devLab.text = [NSString stringWithFormat:@"%.2f",powerP];
//                   self.keyFootView1.devLab.textColor = kUIColorFromRGB(0x0ead6b);
//            }
//            
            
            
//            self.keyFootView2.numLab.text = [NSString stringWithFormat:@"%.2f",supplyNum];
//            
//            CGFloat supplyP =  supplyPlan - supplyNum;
//            
//            if (supplyP >0) {
//                  self.keyFootView2.devLab.text = [NSString stringWithFormat:@"+%.2f",supplyP];
//                  self.keyFootView2.devLab.textColor = kUIColorFromRGB(0xff0000);
//            }else {
//                  
//                  self.keyFootView2.devLab.text = [NSString stringWithFormat:@"%.2f",supplyP];
//                  self.keyFootView2.devLab.textColor = kUIColorFromRGB(0x0ead6b);
//            }

            
            
//            self.keyFootView3.numLab.text = [NSString stringWithFormat:@"%2.f",electNUm];
//            
//            CGFloat electP = electPlan - electNUm;
//            
//            if (electP >0) {
//                  self.keyFootView3.devLab.text = [NSString stringWithFormat:@"+%2.f",electP];
//                  self.keyFootView3.devLab.textColor = kUIColorFromRGB(0xff0000);;
//            }else {
//                  
//                  self.keyFootView3.devLab.text = [NSString stringWithFormat:@"%2.f",electP];
//                  self.keyFootView3.devLab.textColor = kUIColorFromRGB(0x0ead6b);
//            }
            
//            __weak typeof(self)welfSelf = self;
//            self.lineChart2.lineChartBlock = ^(NSArray *dataAry,NSInteger indexP){
//            
//                  NSLog(@"-----点击了------");
//                  NSString *str = dataAry[0];
//                  NSInteger index = [str integerValue];
//                  
//                  CGFloat powerNum1  = 0;
//                  CGFloat supplyNum1 = 0;
//                //  CGFloat electNUm1 = 0;
//                  
//                  CGFloat powerPlan1 = 0;
//                  CGFloat supplyPlan1 = 0;
//                //  CGFloat  electPlan1 = 0;
//                  
//                  for (int i = 0; i<index; i++) {
//                        
//                        KeyModel *model = welfSelf.monthDataArray[i];
//                        
//                        powerNum1 += [model.powerGeneration floatValue];
//                        
//                        supplyNum1 += [model.powerSupply floatValue];
//                      //  electNUm1 += [model.electricity floatValue];
//                        
//                        powerPlan1 = [model.generationPlan floatValue];
//                        supplyPlan1 = [model.supplyPlan floatValue];
//                        
//                       // electPlan1 = [model.electricityPlan floatValue];
//                  }
//                  
//                  
//                  CGFloat powerP1 =  powerPlan1 -powerNum1;
//                  
//                  if (powerP1 >0) {
//                        self.keyFootView1.devLab.text = [NSString stringWithFormat:@"+%2.f",powerP1];
//                        self.keyFootView1.devLab.textColor = kUIColorFromRGB(0xff0000);;
//                  }else {
//                        
//                        self.keyFootView1.devLab.text = [NSString stringWithFormat:@"%2.f",powerP1];
//                        self.keyFootView1.devLab.textColor = kUIColorFromRGB(0x0ead6b);
//                  }
//                   self.keyFootView1.numLab.text = [NSString stringWithFormat:@"%2.f",powerNum1];
//                  
//                  
//                  self.keyFootView2.numLab.text = [NSString stringWithFormat:@"%2.f",supplyNum1];
//                  
//                  CGFloat supplyP1 =  supplyPlan1 - supplyNum1;
//                  
//                  if (supplyP1 >0) {
//                        self.keyFootView2.devLab.text = [NSString stringWithFormat:@"+%2.f",supplyP1];
//                        self.keyFootView2.devLab.textColor = kUIColorFromRGB(0xff0000);
//                  }else {
//                        
//                        self.keyFootView2.devLab.text = [NSString stringWithFormat:@"%2.f",supplyP1];
//                        self.keyFootView2.devLab.textColor = kUIColorFromRGB(0x0ead6b);
//                  }
//            
//                  
////                  self.keyFootView3.numLab.text = [NSString stringWithFormat:@"%2.f",electNUm1];
////                  
////                  CGFloat electP1 = electPlan1 - electNUm1;
////                  
////                  if (electP1 >0) {
////                        self.keyFootView3.devLab.text = [NSString stringWithFormat:@"+%2.f",electP1];
////                        self.keyFootView3.devLab.textColor = kUIColorFromRGB(0xff0000);;
////                  }else {
////                        
////                        self.keyFootView3.devLab.text = [NSString stringWithFormat:@"%2.f",electP1];
////                        self.keyFootView3.devLab.textColor = kUIColorFromRGB(0x0ead6b);
////                  }
//
//                 
//                  
//                   NSLog(@"-----点击了------%@",str);
//                  
//            };
            
            
            
           
            
      }

}
- (void)customNavigationBar{
      [super customNavigationBar];
      
      UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
      lab.text = @"关键指标";
      lab.font = [UIFont systemFontOfSize:18];
      lab.textAlignment = NSTextAlignmentCenter;
      lab.textColor = [UIColor whiteColor];
      self.navigationItem.titleView = lab;
      self.view.backgroundColor = [UIColor colorWithWhite:0.96 alpha:1.0];

}
- (void)creatContentView{

      UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _width, _height)];
      
      scrollView.contentSize = CGSizeMake(0, 950);
      [self.view addSubview:scrollView];
      self.scrollView  = scrollView;
      self.scrollView.showsHorizontalScrollIndicator = NO;
      //self.scrollView.pagingEnabled = YES;
      self.scrollView.delegate = self;
      self.scrollView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0];
     // self.scrollView.userInteractionEnabled = YES;
      [self creatRoundView];

//      UIPageControl *page = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scrollView.frame) , _width, 20)];
//      // page.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
//      page.backgroundColor = [UIColor whiteColor];
//      [self.view addSubview:page];
//      self.page = page;
//      self.page.numberOfPages = 2;
//      // self.page.currentPage = 0;
//      page.pageIndicatorTintColor = kUIColorFromRGB(0xe5e5e5);
//      page.currentPageIndicatorTintColor = kUIColorFromRGB(0x11afea);
//      KeyLeftView *leftView = [[KeyLeftView alloc] initWithFrame:CGRectMake(0, 0, _width, _height)];
//      [self.scrollView addSubview:leftView];
//      
//      KeyRightView *rightView = [[KeyRightView alloc] initWithFrame:CGRectMake(_width, 0, _width, _height)];
//      [self.scrollView addSubview:rightView];


}

- (void)creatRoundView{
      
      UIView *roundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _width, 210)];
      if (_width == IPHONE5W) {
            roundView.height = 150;
      }
      [self.scrollView addSubview:roundView];
      roundView.backgroundColor = [UIColor whiteColor];

      ZFProgressView *progress1 = [[ZFProgressView alloc] initWithFrame:CGRectMake(20, 20, roundView.height -40 , roundView.height-40)];
      [roundView addSubview:progress1];
     // self.gaugeView = progress1;
      progress1.backgroundColor = [UIColor clearColor];
      
      [progress1 setProgressStrokeColor:kUIColorFromRGB(0x1c957d)];
      [progress1 setBackgroundStrokeColor:kUIColorFromRGB(0xec6040)];
      progress1.lineWidth = 8.0;
      progress1.timeDuration = 1.0;
     // [progress1 setProgress:0.73 Animated:YES];
      self.progressView1 = progress1;
      
//      ZFProgressView *progress2 = [[ZFProgressView alloc] initWithFrame:CGRectMake(25, 25, roundView.height -50 , roundView.height-50)];
//      [roundView addSubview:progress2];
//      // self.gaugeView = progress1;
//      progress2.backgroundColor = [UIColor clearColor];
//      [progress2 setProgressStrokeColor:kUIColorFromRGB(0x00a5d3)];
//      [progress2 setBackgroundStrokeColor:kUIColorFromRGB(0xe6f7fe)];
//      progress2.lineWidth = 8.0;
//      progress2.timeDuration = 1.0;
//    //  [progress2 setProgress:0.68 Animated:YES];
//      self.progressView2 = progress2;
      
      ZFProgressView *progress3 = [[ZFProgressView alloc] initWithFrame:CGRectMake(40, 40, roundView.height -80 , roundView.height-80)];
      [roundView addSubview:progress3];
      // self.gaugeView = progress1;
      progress3.backgroundColor = [UIColor clearColor];
     
      [progress3 setProgressStrokeColor: kUIColorFromRGB(0xf5960b)];
      [progress3 setBackgroundStrokeColor:kUIColorFromRGB(0x028fb4)];
      progress3.lineWidth = 8.0;
      progress3.timeDuration = 1.0;
     // [progress3 setProgress:0.48 Animated:YES];
      self.progressView3 = progress3;
      
      //日利润view
      ProfitContentView *profitView = [[ProfitContentView alloc] initWithFrame:CGRectMake( CGRectGetMaxX(progress1.frame)+10, progress1.y-10, _width -progress1.width-10, roundView.height-self.progressView1.y+10)];
      if (_width == IPHONE5W) {
            profitView.y = 0;
      }
      [roundView addSubview:profitView];
      self.profitView = profitView;
      profitView.backgroundColor = [UIColor whiteColor];
    
      profitView.profitAry = @[@"1#发电量",@"2#发电量",@"1#厂用电率",@"2#厂用电率"];
      profitView.headStr = @" 单位 (万千瓦时)";
      profitView.isPorfit = YES;
      
      
     
      //--------------柱线图-------
      
      UIView *contenView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(roundView.frame)+10, _width, 350)];
      [self.scrollView addSubview:contenView];
      contenView.backgroundColor = [UIColor whiteColor];
      
      UIView *contentHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, contenView.width, 110)];
      //contentHeadView.backgroundColor = [UIColor grayColor];
      [contenView addSubview:contentHeadView];
      
      
      
      UILabel *leftLab = [[UILabel alloc] initWithFrame:CGRectZero];
      leftLab.font = [UIFont systemFontOfSize:18];
      NSString *leftStr = @"日累计数值(万千瓦时)";
      
      CGSize leftStrSize = [leftStr sizeWithFont:[UIFont systemFontOfSize:18]];
      leftLab.frame = CGRectMake(20, 20, leftStrSize.width, leftStrSize.height);
      [contentHeadView addSubview:leftLab];
      leftLab.text = leftStr;
      leftLab.textColor = kUIColorFromRGB(0x33333);
      leftLab.textAlignment = NSTextAlignmentLeft;
      
      for (int i = 0; i<4; i++) {
            
            UIView *colorView = [[UIView alloc] initWithFrame:CGRectMake(contentHeadView.width -100, CGRectGetMaxY(leftLab.frame)+5*(i+1)+20*i-25, 10, 10)];
            
            [contentHeadView addSubview:colorView];
            
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(colorView.frame)+3, colorView.y-5, 80, 20)];
            lab.textAlignment = NSTextAlignmentLeft;
            lab.font = [UIFont systemFontOfSize:13];
            if (i ==0) {
                  colorView.backgroundColor = kUIColorFromRGB(0x0ead6b);
                  lab.text = @"1#发电量";
            }
            
            if (i == 1) {
                  colorView.backgroundColor = kUIColorFromRGB(0xff562f);
                  lab.text = @"2#发电量";
            }
            if (i == 2) {
                  colorView.backgroundColor = kUIColorFromRGB(0xfd9602);
                  lab.text = @"1#厂用电率";
            }if (i == 3) {
                  colorView.backgroundColor = kUIColorFromRGB(0x00a5d3);
                  lab.text = @"2#厂用电率";
            }
            
            [contentHeadView addSubview:lab];
      }
      
      
      /*        创建对象         */
      JHColumnChart *column = [[JHColumnChart alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(contentHeadView.frame), _width, contenView.height - contentHeadView.height)];
      self.chartView = column;
      
      /*        创建数据源数组 每个数组即为一个模块数据 例如第一个数组可以表示某个班级的不同科目的平均成绩 下一个数组表示另外一个班级的不同科目的平均成绩         */
     
           /*       该点 表示原点距左下角的距离         */
      column.originSize = CGPointMake(40, 40);
      
      /*        第一个柱状图距原点的距离   */
      
      column.drawFromOriginX = 20;
      /*        柱状图的宽度         */
      column.columnWidth = 25;
      if (_width == IPHONE6PW) {
             column.columnWidth = 30;
      }
      
      column.typeSpace = 10;
      /*        X、Y轴字体颜色         */
      column.drawTextColorForX_Y = [UIColor blackColor];
      /*        X、Y轴线条颜色         */
      column.colorForXYLine = [UIColor colorWithWhite:0.8 alpha:1.0];
      column.isKey = YES;
      
      /*        每个模块的颜色数组 例如A班级的语文成绩颜色为红色 数学成绩颜色为绿色         */
      
 
      
      column.columnBGcolorsArr = @[kUIColorFromRGB(0x0ead6b),kUIColorFromRGB(0xfd9602),kUIColorFromRGB(0xff562f),kUIColorFromRGB(0x00a5d3)];
      /*        模块的提示语         */
      column.xShowInfoText = @[@"1#机组",@"1#机组",@"1#机组",@"2#机组",@"2#机组"];
      column.bgVewBackgoundColor = [UIColor whiteColor];
      
      /*        开始动画         */
     // [column showAnimation];
      [contenView addSubview:column];

    
      
      /*
       *
       -------------底部的view--------
       *
       */
   
      UIView *contentFootView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(contenView.frame)+10, _width, 150)];
      contentFootView.userInteractionEnabled = YES;
      [self.scrollView addSubview:contentFootView];
      contentFootView.backgroundColor = [UIColor whiteColor];
      UILabel *footLeftLab = [[UILabel alloc] initWithFrame:CGRectZero];
      footLeftLab.font = [UIFont systemFontOfSize:18];
      NSString *footLeftStr = @"月累计数值(万千瓦时)";
      CGSize footLeftStrSize = [footLeftStr sizeWithFont:[UIFont systemFontOfSize:18]];
      footLeftLab.frame = CGRectMake(20, 20, footLeftStrSize.width, footLeftStrSize.height);
      [contentFootView addSubview:footLeftLab];
      footLeftLab.text = footLeftStr;
      footLeftLab.textColor = kUIColorFromRGB(0x33333);
      footLeftLab.textAlignment = NSTextAlignmentLeft;
      
      CGFloat hight = 40;
      for (int i = 0; i<1; i++) {
            keyFooterView *labView = [[NSBundle mainBundle] loadNibNamed:@"keyFooterView" owner:self options:nil].lastObject;
            [contentFootView addSubview:labView];
            labView.frame = CGRectMake(20, CGRectGetMaxY(footLeftLab.frame)+25+hight *i, contentFootView.width -40, hight);
            labView.userInteractionEnabled = YES;
            if (i==0) {
                
                  self.keyFootView1 = labView;
                  labView.colorView.backgroundColor = kUIColorFromRGB(0x0ead6b);
                  labView.leftLab.text = @"当月累计发电量";
                  labView.numLab.text = @"135.2";
//                  labView.devLab.text = @"-69.99";
//                  labView.devLab.textColor = kUIColorFromRGB(0x0ead6b);
            }if (i==1) {
                  labView.colorView.backgroundColor = kUIColorFromRGB(0x00a5d3);
//                  self.keyFootView2 = labView;
                  labView.leftLab.text = @"当月累计供电量";
                  labView.numLab.text = @"375.2";
                  labView.devLab.text = @"+99.99";
                  labView.devLab.textColor = kUIColorFromRGB(0xff0000);
                  
            }if (i==2) {
               
                  labView.colorView.backgroundColor = kUIColorFromRGB(0xfd9602);
                  self.keyFootView3 = labView;
                  labView.leftLab.text = @"当月累计厂用电";
                  labView.numLab.text = @"225.2";
                  labView.devLab.text = @"-49.99";
                  labView.devLab.textColor = kUIColorFromRGB(0x0ead6b);
            }
            
      }
      
      
    
      UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(contentFootView.frame)-50, _width, 280)];
      lineView.backgroundColor = [UIColor whiteColor];
      [self.scrollView addSubview:lineView];
      lineView.backgroundColor = [UIColor whiteColor];
      // 初始化折线图
      SJLineChart *lineChart2 = [[SJLineChart alloc] initWithFrame:CGRectMake(20, -10, contentFootView.width-50 ,lineView.height-20)];
      
      self.lineChart2 = lineChart2;
      
//      lineChart2.userInteractionEnabled = YES;
//      contentFootView.userInteractionEnabled=YES;
//      self.scrollView.userInteractionEnabled = YES;
     // lineChart2.backgroundColor = [UIColor grayColor];
      
      // 设置折线图属性
      
//      NSMutableArray *array1 = [NSMutableArray array];
//      NSMutableArray *array2 = [NSMutableArray array];
//      NSMutableArray *array3 = [NSMutableArray array];
//      for (KeyModel *model in self.monthDataArray) {
//            [array1 addObject:model.powerGeneration];
//            [array2 addObject:model.powerSupply];
//            [array3 addObject:model.electricity];
//      }

    //  lineChart2.title = @"2#月利润计划值"; // 折线图名称
      lineChart2.maxValue = 3000;  // 最大值
      lineChart2.yMarkTitles = @[@"0",@"500",@"1000",@"1500",@"2000",@"2500",@"3000"]; // Y轴刻度标签
      lineChart2.isCurve = NO;
      lineChart2.leftColor = kUIColorFromRGB(0xfd9602);
      
//      lineChart2.valueArray2 = @[@200,@700,@900,@1000,@1100,@1300,@1400,@1400,@1400,@1400,@1400,@1400,@1400,@1400,@1400,@1400,@1400,@1400,@1400,@1400,@1400,@1400,@1400,@1400,@1400];
//      lineChart2.valueArray3 = @[@400,@900,@1000,@1200,@1300,@1500,@1600,@1600,@1600,@1600,@1600,@1600,@1600,@1600,@1600,@1600,@1600,@1600,@1600,@1600,@1600,@1600,@1600,@1600,@1600];
      
     // lineChart2.valueArray1 = @[@600,@1100,@1300,@1500,@1600,@1700,@1800,@1800,@1800,@1800,@1800,@1800,@1800,@1800,@1800,@1800,@1800,@1800,@1800,@1800,@1800,@1800,@1800,@1800,@1800].mutableCopy;
      lineChart2.isKey = YES;
      
      [lineChart2 setXMarkTitlesAndValues:@[@{@"item":@"1日",@"count":@600},@{@"item":@"6日",@"count":@1100},@{@"item":@"11日",@"count":@1300},@{@"item":@"16日",@"count":@1500},@{@"item":@"21日",@"count":@1600},@{@"item":@"26日",@"count":@1700},@{@"item":@"31日",@"count":@1800}] titleKey:@"item" valueKey:@"count"]; // X轴刻度标签及相应的值
      
    
      // lineChart.xScaleMarkLEN = 60; // 可以不设，会根据视图的宽度自适应,设置后如果折线图的宽度大于视图宽度，折线图可以滑动
      
      //设置完数据等属性后绘图折线图
    //  [lineChart2 mapping];
      
      [lineView addSubview:lineChart2];
//      [lineChart2 mapping];
      
       __weak typeof(self)welfSelf = self;
      
      lineChart2.lineChartBlock = ^(NSArray *ary,NSInteger indexP){
      
            NSLog(@"-----点击了------");
            NSString *str = ary[0];
            NSInteger index = [str integerValue];
            
            
            CGFloat powerNum1  = 0;
          //  CGFloat supplyNum1 = 0;
            
            //   powerNum1 = [welfSelf.lineChart2.valueArray1[index] floatValue];
            
        
                  
                  NSString *numStr = welfSelf.lineChart2.valueArray1[index];
                  
                  CGFloat  power = [numStr floatValue];
                  powerNum1 = power;
      
            
//            CGFloat planPowe = [welfSelf.planGeneraArray[index] floatValue];
            
          
            
            
//            CGFloat powerP1 =  planPowe -powerNum1;
//            
//            if (powerP1 >0) {
//                  self.keyFootView1.devLab.text = [NSString stringWithFormat:@"+%2.f",powerP1];
//                  self.keyFootView1.devLab.textColor = kUIColorFromRGB(0xff0000);;
//            }else {
//                  
//                  self.keyFootView1.devLab.text = [NSString stringWithFormat:@"%2.f",powerP1];
//                  self.keyFootView1.devLab.textColor = kUIColorFromRGB(0x0ead6b);
//            }
            
            self.keyFootView1.numLab.text = [NSString stringWithFormat:@"%2.f",powerNum1];
            
            
            
            
            //  supplyNum1 = [welfSelf.lineChart2.valueArray2[index] floatValue];
            
            
                  
//                  NSString *numStr2 = welfSelf.lineChart2.valueArray2[index];
//                  //for (NSString *numStr in welfSelf.lineChart2.valueArray2)
//                  
//                  CGFloat supply = [numStr2 floatValue];
//                  
//                  supplyNum1 = supply;
//            
//            
//            self.keyFootView2.numLab.text = [NSString stringWithFormat:@"%2.f",supplyNum1];
//            CGFloat planSuply = [welfSelf.planSupplyArray[index] floatValue];
//            
//            CGFloat supplyP1 =  planSuply - supplyNum1;
//            
//            
//            if (supplyP1 >0) {
//                  self.keyFootView2.devLab.text = [NSString stringWithFormat:@"+%.2f",supplyP1];
//                  self.keyFootView2.devLab.textColor = kUIColorFromRGB(0xff0000);;
//            }else {
//                  
//                  self.keyFootView2.devLab.text = [NSString stringWithFormat:@"%.2f",supplyP1];
//                  self.keyFootView2.devLab.textColor = kUIColorFromRGB(0x0ead6b);
//            }
//            
            
            
            
            
            NSLog(@"-----点击了------%@",str);
            
      };
      
      
      
      if (isTest) {
            [progress1 setProgress:0.88 Animated:YES];
//            [progress2 setProgress:0.68 Animated:YES];
            [progress3 setProgress:0.48 Animated:YES];
            profitView.dataAry = @[@"36.6",@"37",@"33.33",@"4.7"];
            
            
            
            self.chartView.valueArr = @[@[@0.00,@0.00],@[@26.4,@45.0],@[@0.00,@0.00],@[@36.4,@45.0],@[@0.00,@0.00]];
            
            [self.chartView showAnimation];
            
            
             lineChart2.valueArray1 = @[@600,@1100,@1300,@1500,@1600,@1700,@1800,@1800,@1800,@1800,@1800,@1800,@1800,@1800,@1800,@1800,@1800,@1800,@1800,@1800,@1800,@1800,@1800,@1800,@2500].mutableCopy;
//                  lineChart2.valueArray2 = @[@200,@700,@900,@1000,@1100,@1300,@1400,@1400,@1400,@1400,@1400,@1400,@1400,@1400,@1400,@1400,@1400,@1400,@1400,@1400,@1400,@1400,@1400,@1400,@2200];
//                  lineChart2.valueArray3 = @[@400,@900,@1000,@1200,@1300,@1500,@1600,@1600,@1600,@1600,@1600,@1600,@1600,@1600,@1600,@1600,@1600,@1600,@1600,@1600,@1600,@1600,@1600,@1600,@1600];
            
            
            
           // lineChart2.lineArray = @[@"2800"];
            
            self.lineChart2.lineChartBlock = ^(NSArray *dataAry,NSInteger indexP){
                  
                  NSLog(@"-----点击了------");
                  NSString *str = dataAry[0];
                  NSInteger index = [str integerValue];
                  
                  CGFloat powerNum1  = 0;
                  //CGFloat supplyNum1 = 0;
                  
               //   powerNum1 = [welfSelf.lineChart2.valueArray1[index] floatValue];
                  
                  for (int i = 0; i< index; i++) {
                        
                        NSString *numStr = welfSelf.lineChart2.valueArray1[i];
                 
                        CGFloat  power = [numStr floatValue];
                        powerNum1 += power;
                  }
                  
                  
                //  CGFloat planPowe = [welfSelf.planGeneraArray[index] floatValue];
//                  CGFloat planPowe = 1000;
//                  
//                  CGFloat powerP1 =  planPowe -powerNum1;
//                  
//                  if (powerP1 >0) {
//                        self.keyFootView1.devLab.text = [NSString stringWithFormat:@"+%.2f",powerP1];
//                        self.keyFootView1.devLab.textColor = kUIColorFromRGB(0xff0000);;
//                  }else {
//                        
//                        self.keyFootView1.devLab.text = [NSString stringWithFormat:@"%.2f",powerP1];
//                        self.keyFootView1.devLab.textColor = kUIColorFromRGB(0x0ead6b);
//                  }
//                  
                  
                  self.keyFootView1.numLab.text = [NSString stringWithFormat:@"%.2f",powerNum1];
                  
                  
                //  self.keyFootView2.numLab.text = [NSString stringWithFormat:@"%.2f",supplyNum1];
                  
                //  supplyNum1 = [welfSelf.lineChart2.valueArray2[index] floatValue];
                  
//                  for (int i = 0; i<index; i++) {
//                        
//                        NSString *numStr = welfSelf.lineChart2.valueArray2[i];
//                  //for (NSString *numStr in welfSelf.lineChart2.valueArray2)
//                        
//                        CGFloat supply = [numStr floatValue];
//                        
//                        supplyNum1 += supply;
//                  }
               //   CGFloat planSuply = [welfSelf.planSupplyArray[index] floatValue];
                  
                //  CGFloat supplyP1 =  planSuply - supplyNum1;
                  
                  
//                  if (supplyP1 >0) {
//                        self.keyFootView2.devLab.text = [NSString stringWithFormat:@"+%.2f",supplyP1];
//                        self.keyFootView2.devLab.textColor = kUIColorFromRGB(0xff0000);;
//                  }else {
//                        
//                        self.keyFootView2.devLab.text = [NSString stringWithFormat:@"%.2f",supplyP1];
//                        self.keyFootView2.devLab.textColor = kUIColorFromRGB(0x0ead6b);
//                  }
//                  
                  
                  
                  //                  self.keyFootView3.numLab.text = [NSString stringWithFormat:@"%2.f",electNUm1];
                  //
                  //                  CGFloat electP1 = electPlan1 - electNUm1;
                  //
                  //                  if (electP1 >0) {
                  //                        self.keyFootView3.devLab.text = [NSString stringWithFormat:@"+%2.f",electP1];
                  //                        self.keyFootView3.devLab.textColor = kUIColorFromRGB(0xff0000);;
                  //                  }else {
                  //
                  //                        self.keyFootView3.devLab.text = [NSString stringWithFormat:@"%2.f",electP1];
                  //                        self.keyFootView3.devLab.textColor = kUIColorFromRGB(0x0ead6b);
                  //                  }
                  
                  
                  
                  
                  NSLog(@"-----点击了------%@",str);
                  
            };
            
            

            
            
            [lineChart2 mapping];
            
      }



}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
      CGFloat s = self.scrollView.frame.size.width;
      // NSLog(@"------%zd",s);
      if (scrollView.contentOffset.x >_width) {
            
      }
      int page = (scrollView.contentOffset.x +0.5*s )/s;
      
      self.page.currentPage = page;
      
      
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
