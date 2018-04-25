//
//  FuleViewController.m
//  dsdl
//
//  Created by 廉英雷 on 16/11/17.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import "FuleViewController.h"
#import "ProfitContentView.h"
#import "FuleContentHeadView.h"

#import "JHColumnChart.h"
#import "LineView.h"
#import "JHLineChart.h"
#import "SJLineChart.h"
#import "FuleModel.h"
#import "MJExtension.h"
#import "FuleContentModel.h"
#import "CoalContentView.h"

@interface FuleViewController ()

@property (nonatomic, strong) UIScrollView *scrolView;


@property (nonatomic, strong) NSMutableArray *chartArray;

@property (nonatomic, weak) ProfitContentView *profitView1;

@property (nonatomic, weak) ProfitContentView *profitView2;

@property (nonatomic, weak) SJLineChart *lineChart;

@property (nonatomic, weak) JHColumnChart *columView;

@property (nonatomic, weak) CoalContentView *coalView;
@end

@implementation FuleViewController

- (void)viewWillAppear:(BOOL)animated{
      [super viewWillAppear:animated];
      self.tabBarController.tabBar.hidden = YES;
}

- (NSMutableArray *)chartArray{

      if (!_chartArray) {
            _chartArray = [NSMutableArray array];
      }
      return _chartArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
      self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];

      [self creatView];

      if (!isTest) {
             [self getData];
      }
    
      
}

- (void)getData{
      
      //是否有网络
      if (![Tools isNetWork]) {
            
            
            NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask , YES)lastObject];
            path = [path stringByAppendingPathComponent:@"getFuel.data"];
            
            NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
            if (dict) {
                  
                  [self successRequest:dict withSender:@"getFuel"];
                  
            }
            
            NSString *path2 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask , YES)lastObject];
            path2 = [path2 stringByAppendingPathComponent:@"getBid.data"];
            NSDictionary *dict2 = [NSDictionary dictionaryWithContentsOfFile:path2];
            if (dict2) {
                  
                  [self successRequest:dict2 withSender:@"getBid"];
                  
            }
            
            NSString *path3 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask , YES)lastObject];
            path3 = [path3 stringByAppendingPathComponent:@"getFuelList.data"];
            NSDictionary *dict3 = [NSDictionary dictionaryWithContentsOfFile:path3];
            if (dict3) {
                  
                  [self successRequest:dict3 withSender:@"getFuelList"];
                  
            }

            
      }else{
      

      [self.httpRequest getURL:appServer withUrl:@"fuel/getFuel" withParam:nil httpHeader:[Tools HttpHeader] receiveTarget:@"getFuel"];
//      [self.httpRequest getURL:[appServer stringByAppendingString:@"/fuel/getFuel"] withParam:nil httpHeader:[Tools HttpHeader] receiveTarget:@"getFuel"];
      
      [self.httpRequest getURL:appServer withUrl:@"fuel/getBid" withParam:nil httpHeader:[Tools HttpHeader] receiveTarget:@"getBid"];
//      [self.httpRequest getURL:[appServer stringByAppendingString:@"fuel/getBid"] withParam:nil httpHeader:[Tools HttpHeader] receiveTarget:@"getBid"];
      
      //指标数据
      [self.httpRequest getURL:appServer withUrl:@"opcFuel/getFuel" withParam:nil httpHeader:[Tools HttpHeader] receiveTarget:@"getFuelList"];
//      [self.httpRequest getURL:[appServer stringByAppendingString:@"opcFuel/getFuel"] withParam:nil httpHeader:[Tools HttpHeader] receiveTarget:@"getFuelList"];
            
      }
}

- (void)successRequest:(id)data withSender:(NSString *)sender{

      if ([sender isEqualToString:@"getFuel"]) {
            NSDictionary *dict = (NSDictionary *)data;
            
            
            if ([data isKindOfClass:[NSNull class]]) {
                  self.profitView1.dataAry = @[@"-",@"-",@"-"];
                  
                  self.profitView2.dataAry = @[@"-",@"-",@"-"];
                 
                  
//                  self.columView.valueArr = @[
//                                      @[@1100,@302,@800,@1500],
//                                      @[@900,@200,@300,@1400],
//                                      @[@600,@400,@700,@1700]];
                  self.columView.valueArr = @[
                                              @[@0,@0,@0,@0],
                                              @[@0,@0,@0,@0],
                                              @[@0,@0,@0,@0]];;
                  [self.columView showAnimation];

            }else{
            
                  NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask , YES)lastObject];
                  path = [path stringByAppendingPathComponent:@"getFuel.data"];
                  
                  [dict writeToFile:path atomically:YES];
                  FuleContentModel *fuleModel = [FuleContentModel mj_objectWithKeyValues:dict];
                  
                  NSArray *ary1 = @[fuleModel.factoryPrice,fuleModel.factoryCompared,fuleModel.factorySequential];
                  NSArray *ary2 = @[fuleModel.chargingPrice,fuleModel.chargingCompared,fuleModel.chargingSequential];
                  
                  self.profitView1.dataAry = ary1;
                  self.profitView2.dataAry = ary2;
                  
                  
                  NSArray *columAry = @[@[fuleModel.factoryLowSulfur,fuleModel.factoryHighSulfur,fuleModel.factoryEngineering,fuleModel.factoryCombined],@[fuleModel.warehouseLowSulfur,fuleModel.warehouseHighSulfur,fuleModel.warehouseEngineering,fuleModel.warehouseCombined],@[fuleModel.furnaceLowSulfur,fuleModel.furnaceHighSulfur,fuleModel.furnaceEngineering,fuleModel.furnaceCombined]];
                  
                  self.columView.valueArr = columAry;
                  
                  [self.columView showAnimation];
            }
           
            
      }
      if ([sender isEqualToString:@"getBid"]) {
            
            NSDictionary *dict = (NSDictionary *)data;
            
            if ([dict isKindOfClass:[NSNull class]]) {
                  
                  
                  
            }else{
            NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask , YES)lastObject];
            path = [path stringByAppendingPathComponent:@"getBid.data"];
            [dict writeToFile:path atomically:YES];
            
            
            NSArray *dataAry = dict[@"bids"];

            [self.chartArray removeAllObjects];
            self.chartArray = [FuleModel mj_objectArrayWithKeyValuesArray:dataAry];
            
            NSMutableArray *valueArray1 = [NSMutableArray array];
            NSMutableArray *valueArray2 = [NSMutableArray array];
           
            
            for (FuleModel *fuleModel in self.chartArray) {
                  
                  [valueArray1 addObject:fuleModel.factoryBid];
                  [valueArray2 addObject:fuleModel.coalBid];
                 
            }
            
            NSMutableArray *xArray = [NSMutableArray array];
            NSString *dateStr;
            for (NSString *str in dict[@"dateTime"]) {
                  dateStr = [str stringByAppendingString:@"日"];
                  [xArray addObject:dateStr];
            }
            //x轴上的title
             self.lineChart.xMarkArray = xArray;
            
            self.lineChart.valueArray1 = valueArray2;
            self.lineChart.valueArray2 = valueArray1;
                  
            }
            [self.lineChart mapping];
            
            
      }
      
      if ([sender isEqualToString:@"getFuelList"]) {
             NSDictionary *dict = (NSDictionary *)data;
            
            if (![data isKindOfClass:[NSNull class]]) {
                  NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask , YES)lastObject];
                  path = [path stringByAppendingPathComponent:@"getFuelList.data"];
                  [dict writeToFile:path atomically:YES];
                  
                  FuleModel *fuleModel = [FuleModel mj_objectWithKeyValues:data];
                  self.coalView.dataAry = @[@[@"1#机组",@"2#机组"],@[fuleModel.dryAshV1,fuleModel.dryAshV2],@[fuleModel.baseLowFeverV1,fuleModel.baseLowFeverV2],@[fuleModel.allMoistureV1,fuleModel.allMoistureV2],@[fuleModel.baseAshV1,fuleModel.baseAshV2],@[fuleModel.flyCarbonV1,fuleModel.flyCarbonV2],@[fuleModel.slagCarbonV1,fuleModel.slagCarbonV2]];
            }
           
          
           
      }
}

- (void)creatView{
      
      self.scrolView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
      [self.view addSubview:self.scrolView];
      self.scrolView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
      self.scrolView.contentSize = CGSizeMake(0, 1080);
      self.scrolView.showsHorizontalScrollIndicator = NO;
      
      CGFloat hight = 360;
      if (_width == IPHONE6PW) {
           hight = 360;
            
      }
      
      if (_width == IPHONE6W) {
           hight = 320;
           
      }
      if (_width == IPHONE5W) {
            hight = 290;
      }
      
      CoalContentView *contentView1 = [[CoalContentView alloc] initWithFrame:CGRectMake(0, 0, _width, hight)];
      
            self.coalView = contentView1;
      
           [self.scrolView addSubview:contentView1];
      

      UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(contentView1.frame)+10, _width, 150)];
      [self.scrolView addSubview:headView];
      headView.backgroundColor = [UIColor whiteColor];
      
      //日利润view
      ProfitContentView *profitView1 = [[ProfitContentView alloc] initWithFrame:CGRectMake(0, 10, (headView.width -20)*0.5, headView.height -20)];
      [headView addSubview:profitView1];
      profitView1.isFule = YES;
      self.profitView1 = profitView1;
      profitView1.backgroundColor = kUIColorFromRGB(0x00b4ef);
      
//      NSArray *proArray1 = @[self.dataDict[@"factoryPrice"],self.dataDict[@"factoryCompared"],self.dataDict[@"factorySequential"]];
     
      profitView1.profitAry = @[@"价格",@"同比",@"环比"];
      profitView1.headStr = @"昨日入厂煤标单";
      profitView1.isFule = YES;
     
      ProfitContentView *profitView2 = [[ProfitContentView alloc] initWithFrame:CGRectMake( CGRectGetMaxX(profitView1.frame)+20, 10, (headView.width -20)*0.5, headView.height -20)];
      [headView addSubview:profitView2];
      self.profitView2 = profitView2;
      profitView2.backgroundColor = themeColor;
      
//      NSArray *proArray2 = @[self.dataDict[@"chargingPrice"],self.dataDict[@"chargingCompared"],self.dataDict[@"chargingSequential"]];
//      profitView2.dataAry = proArray2;
  
      profitView2.profitAry = @[@"价格",@"同比",@"环比"];
      profitView2.headStr = @"昨日入炉煤标单";
      profitView2.isFule = YES;
      
      if (isTest) {
            profitView1.dataAry = @[@"239.6",@"82.33%",@"128.6%"];
            
                profitView2.dataAry = @[@"239.6",@"0.00%",@"128.6%"];
      }
      
      
      UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headView.frame)+10, _width, 260)];
      [self.scrolView addSubview:contentView];
      contentView.backgroundColor = [UIColor whiteColor];
      
      FuleContentHeadView *contentHead = [[NSBundle mainBundle] loadNibNamed:@"FuleContentHeadView" owner:self options:nil].lastObject;
      if (_width == IPHONE5W) {
              contentHead.frame = CGRectMake(10, 0, contentView.width -10, 35);
      }else{
      
            contentHead.frame = CGRectMake(20, 0, contentView.width -40, 35);
      }
      
      
      [contentView addSubview:contentHead];
 
      
      
      /*        创建对象         */
      JHColumnChart *column = [[JHColumnChart alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(contentHead.frame), contentView.width-40, contentView.height - contentHead.height-20)];
      
      self.columView = column;
      /*        创建数据源数组 每个数组即为一个模块数据 例如第一个数组可以表示某个班级的不同科目的平均成绩 下一个数组表示另外一个班级的不同科目的平均成绩         */
      
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
      
      
//      NSArray *columnArray = @[@[self.dataDict[@"factoryLowSulfur"],self.dataDict[@"factoryHighSulfur"],self.dataDict[@"factoryEngineering"],self.dataDict[@"factoryCombined"]],@[self.dataDict[@"warehouseLowSulfur"],self.dataDict[@"warehouseHighSulfur"],self.dataDict[@"warehouseEngineering"],self.dataDict[@"warehouseCombined"]],@[self.dataDict[@"furnaceLowSulfur"],self.dataDict[@"furnaceHighSulfur"],self.dataDict[@"furnaceEngineering"],self.dataDict[@"furnaceCombined"]]];
//      
//      column.valueArr = columnArray;
//      
//      

      
      /*       该点 表示原点距左下角的距离         */
      
      column.originSize = CGPointMake(30, 20);
      
      /*        第一个柱状图距原点的距离         */
      column.drawFromOriginX = 30;
      /*        柱状图的宽度         */
      column.columnWidth = 25;
      /*        X、Y轴字体颜色         */
      column.drawTextColorForX_Y = [UIColor blackColor];
      /*        X、Y轴线条颜色         */
      column.colorForXYLine = [UIColor blackColor];
      
      /*        每个模块的颜色数组 例如A班级的语文成绩颜色为红色 数学成绩颜色为绿色         */
      column.columnBGcolorsArr = @[kUIColorFromRGB(0xfd9602),kUIColorFromRGB(0xff562f),kUIColorFromRGB(0x02b4ef),themeColor];
      /*        模块的提示语         */
      column.xShowInfoText = @[@"入厂煤",@"入仓煤",@"入炉煤"];
      column.bgVewBackgoundColor = [UIColor whiteColor];
      column.typeSpace = 10;
     // column.isKey = YES;
      /*        开始动画         */
    //  [column showAnimation];
      [contentView addSubview:column];
      if (isTest) {
           
                  column.valueArr = @[
                                      @[@1100,@302,@800,@1500],
                                      @[@900,@200,@300,@1400],
                                      @[@600,@400,@700,@1700]];
            [column showAnimation];
      }
     
      
      UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(contentView.frame)+10, _width, 280)];
      [self.scrolView addSubview:footerView];
      footerView.backgroundColor = [UIColor whiteColor];
     
      UIView *colorViewS = [[UIView alloc] initWithFrame:CGRectMake(0, 0, footerView.width, 40)];
      [footerView addSubview:colorViewS];
      for (int i = 0; i<2; i++) {
            
            UIView *colorView = [[UIView alloc] initWithFrame:CGRectMake(footerView.width -100, 10*(i+1)+10*i, 10, 10)];
            
            [colorViewS addSubview:colorView];
            
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(colorView.frame)+3, colorView.y-6, 80, 20)];
            lab.textAlignment = NSTextAlignmentLeft;
            lab.font = [UIFont systemFontOfSize:13];
            if (i ==0) {
                  colorView.backgroundColor = kUIColorFromRGB(0xFD9602);
                  lab.text = @"入厂标单";
                  
            }if (i == 1) {
                  
                  colorView.backgroundColor = kUIColorFromRGB(0x02b4ef);
                  lab.text = @"入煤标单";
            }
            
            [colorViewS addSubview:lab];
      }
      

      SJLineChart *lineChart = [[SJLineChart alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(colorViewS.frame), footerView.width,footerView.height -colorViewS.height-20)];
      self.lineChart = lineChart;
      // 设置折线图属性
      
      lineChart.lineChartBlock = ^(NSArray *ary,NSInteger index){
      
           // NSLog(@"%@",[]);
      };
//      lineChart.title = @"表单  (元/吨)"; // 折线图名称
      lineChart.maxValue = 100;   // 最大值
      lineChart.yMarkTitles = @[@"0",@"20",@"40",@"60",@"80",@"100"]; // Y轴刻度标签
    //  lineChart.isCurve = YES;
      lineChart.leftColor = kUIColorFromRGB(0x05985d);
      
//      NSMutableArray *valueArray1 = [NSMutableArray array];
//        NSMutableArray *valueArray2 = [NSMutableArray array];
//      for (FuleModel *fuleModel in self.chartArray) {
//            [valueArray1 addObject:fuleModel.factoryBid];
//            [valueArray2 addObject:fuleModel.coalBid];
//      }
//      
      
      [lineChart setXMarkTitlesAndValues:@[@{@"item":@"1日",@"count":@60},@{@"item":@"6日",@"count":@31},@{@"item":@"11日",@"count":@50},@{@"item":@"16日",@"count":@67},@{@"item":@"21日",@"count":@66},@{@"item":@"26日",@"count":@60},@{@"item":@"31日",@"count":@12}] titleKey:@"item" valueKey:@"count"];
      

      // X轴刻度标签及相应的值
      // lineChart.xScaleMarkLEN = 60; // 可以不设，会根据视图的宽度自适应,设置后如果折线图的宽度大于视图宽度，折线图可以滑动
      
      //设置完数据等属性后绘图折线图
     // [lineChart mapping];
      
      [footerView addSubview:lineChart];
      if (isTest) {
            
            lineChart.valueArray2 = @[@30,@20,@60,@30,@40,@50,@60];
            lineChart.valueArray1 = @[@60,@31,@50,@67,@66,@60,@12].mutableCopy;
            [lineChart mapping];

      }
      
      
      NSString *str = @"标单 (元/吨)";
      UILabel * titleLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 12, lineChart.width, 20)];
      titleLab.font = [UIFont systemFontOfSize:14];
      titleLab.textAlignment = NSTextAlignmentLeft;
      titleLab.textColor = kUIColorFromRGB(0x333333);
      
      NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
      [attrStr addAttribute:NSForegroundColorAttributeName
                      value:kUIColorFromRGB(0x999999)
                      range:NSMakeRange(3, 5)];
      
      
      titleLab.attributedText = attrStr;
      
      // lab.font = [UIFont systemFontOfSize:17];
      titleLab.textAlignment = NSTextAlignmentLeft;
      [lineChart addSubview:titleLab];
      
//      /*        创建表对象         */
//      JHLineChart *lineChart = [[JHLineChart alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(colorViewS.frame)+5, footerView.width,footerView.height -colorViewS.height-70) andLineChartType:JHChartLineValueNotForEveryX];
//      
//      
//      /* X轴的刻度值 可以传入NSString或NSNumber类型  并且数据结构随折线图类型变化而变化 详情看文档或其他象限X轴数据源示例*/
//      lineChart.xLineDataArr = @[@"0日",@"1日",@"2日",@3,@4,@5,@6,@7,@8,@9,@10,@11,@12];
//      /* 折线图的不同类型  按照象限划分 不同象限对应不同X轴刻度数据源和不同的值数据源 */
//      lineChart.lineChartQuadrantType = JHLineChartQuadrantTypeFirstQuardrant;
//      /* 数据源 */
//      lineChart.valueArr = @[@[@"1",@"12",@"1",@6,@4,@9,@6,@7],@[@"3",@"1",@"2",@16,@2,@3,@5,@10]];
//      /* 值折线的折线颜色 默认暗黑色*/
//      lineChart.valueLineColorArr =@[ kUIColorFromRGB(0xfd9602), kUIColorFromRGB(0x02b4ef)];
//      /* 值点的颜色 默认橘黄色*/
//      lineChart.pointColorArr = @[kUIColorFromRGB(0xfd9602),kUIColorFromRGB(0x02b4ef)];
//      /* X和Y轴的颜色 默认暗黑色 */
//      lineChart.xAndYLineColor = [UIColor blackColor];
//      /* XY轴的刻度颜色 m */
//      lineChart.xAndYNumberColor = [UIColor blackColor];
//      /* 坐标点的虚线颜色 */
//      lineChart.positionLineColorArr = @[[UIColor lightGrayColor],[UIColor lightGrayColor]];
//      /*        设置是否填充内容 默认为否         */
//      lineChart.contentFill = NO;
//      /*        设置为曲线路径         */
//      lineChart.pathCurve = NO;
//    //  lineChart.yLineDataArr = @[@0,@50,@100,@150,@200,@250];
//      
//      /*        设置填充颜色数组         */
//      lineChart.contentFillColorArr = @[[UIColor colorWithRed:0.500 green:0.000 blue:0.500 alpha:0.468],[UIColor colorWithRed:0.500 green:0.214 blue:0.098 alpha:0.468]];
//      lineChart.backgroundColor = [UIColor whiteColor];
//      
//      [footerView addSubview:lineChart];
//      /*        开始动画         */
//      [lineChart showAnimation];
    
      
      
      
      contentView1.textAry = @[@"指标",@"干燥无灰基挥发分(%)",@"收到基低位发热量(Kcar/Kg)",@"收到基全水分(%)",@"收到基灰分(%)",@"飞灰含碳量(%)",@"炉渣含碳量(%)"];
      if (isTest) {
           
            
            contentView1.dataAry =@[@[@"1#机组",@"2#机组"],@[@"38.00",@"39.00"],@[@"3865.0",@"3845.0"],@[@"26.00",@"25.00"],@[@"17.11",@"16.99"],@[@"0.60",@"0.59"],@[@"0.89",@"0.87"]];
            
      }


}

- (void)customNavigationBar{
      [super customNavigationBar];

      UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
      lab.text = @"燃料指标";
      lab.font = [UIFont systemFontOfSize:18];
      lab.textAlignment = NSTextAlignmentCenter;
      lab.textColor = [UIColor whiteColor];
      self.navigationItem.titleView = lab;
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
