//
//  ProViewController.m
//  dsdl
//
//  Created by 廉英雷 on 16/11/17.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import "ProViewController.h"
#import "JHColumnChart.h"
#import "ProListView.h"
#import "ProModel.h"
#import "MJExtension.h"


@interface ProViewController ()


@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, weak) JHColumnChart *columnChart;

@property (nonatomic, weak) ProListView *proView;
@end

@implementation ProViewController

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
//      UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _width, 600)];
//      [self.view addSubview:imgView];
//      imgView.image = [UIImage imageNamed:@"pro.png"];
      self.navigationItem.title = @"环保指标";
      
      [self creatHeadView];
      
      
      if (!isTest) {
            [self getData];

      }
      
}

- (void)getData{
      
      //是否有网络
      if (![Tools isNetWork]) {
            
            
            
            NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask , YES)lastObject];
            path = [path stringByAppendingPathComponent:@"getEnviron.data"];
            
            NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
            if (dict) {
                  
                  [self successRequest:dict withSender:@"getEnviron"];
                  
            }
            
      }else{
            
             [self.httpRequest getURL:appServer withUrl:@"environ/getEnviron" withParam:nil httpHeader:[Tools HttpHeader] receiveTarget:@"getEnviron"];
      
      }
      
     
     

//      [self.httpRequest getURL:[appServer stringByAppendingString:@"environ/getEnviron"] withParam:nil httpHeader:[Tools HttpHeader] receiveTarget:@"getEnviron"];
}

- (void)successRequest:(id)data withSender:(NSString *)sender{

      if ([sender isEqualToString:@"getEnviron"]) {
            NSArray *dictAry = (NSArray *)data;
            
            if (dictAry.count == 0 ) {
                 
                  self.columnChart.lineRedAry = @[@"35",@"50",@"10"];
                  self.columnChart.valueArr = @[
                                      @[@6.1,@28.1],
                                      @[@45.1,@41.8],
                                      @[@4.6,@3.5]];
                  
                  [self.columnChart showAnimation];
                  
                  self.proView.dataAry = @[@[@"6.1",@"35",@"21.8",@"35"],@[@"45.1",@"50",@"41.8",@"50"],@[@"4.6",@"10",@"3.5",@"10"],@[@"99.9",@"-",@"99.2",@"-"],@[@"92.3",@"-",@"80.6",@"-"]];
            }else{
            
             NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask , YES)lastObject];
            path = [path stringByAppendingPathComponent:@"getEnviron.data"];
            [dictAry writeToFile:path atomically:YES];
            
            [self.dataArray removeAllObjects];
            self.dataArray = [ProModel mj_objectArrayWithKeyValuesArray:dictAry];
            ProModel *proModel1 = [[ProModel alloc] init];
            ProModel *proModel2 = [[ProModel alloc] init];
            for (ProModel *proModel in self.dataArray) {
                 
                  if ([proModel.unitSet isEqualToString:@"0"]) {
                        
                        proModel1 = proModel;
                       
                  }
                  
                  if ([proModel.unitSet isEqualToString:@"1"]) {
                        
                        proModel2 = proModel;
                      
                  }

            }
            if (self.dataArray.count==1) {
                  
                  proModel2 = [[ProModel alloc] init];
                  proModel2.desulfurizationNitrate = @"2";
                  proModel2.desulfurizationSulfur = @"2";
                  proModel2.nitrateCeiling = @"1";
                  proModel2.nox = @"2";
                  proModel2.noxCeiling = @"3";
                  proModel2.somkeDust = @"1";
                  proModel2.somkeDustCeiling = @"1";
                  proModel2.sox = @"1";
                  proModel2.soxCeiling = @"1";
                  proModel2.sulfurCeiling = @"1";
            }
            
            NSArray *ary = @[proModel1.soxCeiling,proModel1.noxCeiling,proModel1.somkeDustCeiling];
            
            self.columnChart.lineRedAry = ary;
                  
            //      column.valueArr = @[
            //                          @[@11.25,@18.14],
            //                          @[@35.16,@34.22],
            //                          @[@8.0,@4.3]];
            
            self.columnChart.valueArr = @[@[proModel1.sox,proModel2.sox],@[proModel1.nox,proModel2.nox],@[proModel1.somkeDust,proModel2.somkeDust]];
            [self.columnChart showAnimation];
            
//            {
//                  "createTime": "2016-12-19 12:00:00",
//                  "desulfurizationNitrate": "2",脱硝效率值
//                  "desulfurizationSulfur": "2",脱硫效率值
//                  "id": "2",
//                  "nitrateCeiling": "2", 脱硝上限值
//                  "nox": "2", NOx值
//                  "noxCeiling": "2", NOx上限值
//                  "somkeDust": "2", 烟尘值
//                  "somkeDustCeiling": "2",烟尘上限值
//                  "sox": "2",       SOx值
//                  "soxCeiling": "2", SOx上限值
//                  "sulfurCeiling": "2", 脱硫上限值
//                  "unitSet": "1" 机组
//            },
            
            //      NSArray *proArray = @[@[self.dataDict1[@"sox"],self.dataDict1[@""],self.dataDict2[@""],self.dataDict2[@""]],@[self.dataDict1[@""],self.dataDict1[@""],self.dataDict2[@""],self.dataDict2[@""]],@[self.dataDict1[@""],self.dataDict1[@""],self.dataDict2[@""],self.dataDict2[@""]],@[self.dataDict1[@""],self.dataDict1[@""],self.dataDict2[@""],self.dataDict2[@""]],@[self.dataDict1[@""],self.dataDict1[@""],self.dataDict2[@""],self.dataDict2[@""]]];
            self.proView.dataAry = @[@[proModel1.sox,proModel1.soxCeiling,proModel2.sox,proModel2.soxCeiling],@[proModel1.nox,proModel1.noxCeiling,proModel2.nox,proModel2.noxCeiling],@[proModel1.somkeDust,proModel1.somkeDustCeiling,proModel2.somkeDust,proModel2.somkeDustCeiling],@[proModel1.desulfurizationSulfur,proModel1.sulfurCeiling,proModel2.desulfurizationSulfur,proModel2.sulfurCeiling],@[proModel1.desulfurizationNitrate,proModel1.nitrateCeiling,proModel2.desulfurizationNitrate,proModel2.nitrateCeiling]];
            }
      }
}
- (void)customNavigationBar{

      [super customNavigationBar];
      UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
      lab.text = @"环保指标";
      lab.font = [UIFont systemFontOfSize:18];
      lab.textAlignment = NSTextAlignmentCenter;
      lab.textColor = [UIColor whiteColor];
      self.navigationItem.titleView = lab;
}

- (void)creatHeadView{
      self.view.backgroundColor = [UIColor whiteColor];
      UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _width, 50)];
      [self.view addSubview:headView];
      headView.backgroundColor = [UIColor whiteColor];
      
      for (int i = 0; i<2; i++) {
            
            UIView *colorView = [[UIView alloc] initWithFrame:CGRectMake(headView.width -100, 10*(i+1)+15*i, 10, 10)];
            
            [headView addSubview:colorView];
            
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(colorView.frame)+3, colorView.y-8, 80, 25)];
            lab.textAlignment = NSTextAlignmentLeft;
            lab.font = [UIFont systemFontOfSize:13];
            if (i ==0) {
                  colorView.backgroundColor = kUIColorFromRGB(0x00a5d3);
                  lab.text = @"1#机组";
            }if (i == 1) {
                  colorView.backgroundColor = kUIColorFromRGB(0xfd9602);
                  lab.text = @"2#机组";
            }
            [headView addSubview:lab];
      }

      
      /*        创建对象         */
      JHColumnChart *column = [[JHColumnChart alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(headView.frame), _width, _height*0.5- 110)];
      
      self.columnChart = column;
      
      /*        创建数据源数组 每个数组即为一个模块数据 例如第一个数组可以表示某个班级的不同科目的平均成绩 下一个数组表示另外一个班级的不同科目的平均成绩         */
      
     
      
//      NSArray  *ary = @[@[self.dataDict1[@"sox"],self.dataDict2[@"sox"]],@[self.dataDict1[@"nox"],self.dataDict2[@"nox"]],@[self.dataDict1[@"somkeDust"],self.dataDict2[@"somkeDust"]]];
//      column.valueArr = ary;
      

      /*       该点 表示原点距左下角的距离         */
      column.originSize = CGPointMake(20, 30);
      
      /*        第一个柱状图距原点的距离         */
      column.drawFromOriginX = 40;
      /*        柱状图的宽度         */
      column.columnWidth = 30;
      /*        X、Y轴字体颜色         */
      column.drawTextColorForX_Y = [UIColor blackColor];
      /*        X、Y轴线条颜色         */
      column.colorForXYLine = [UIColor blackColor];
      
      /*        每个模块的颜色数组 例如A班级的语文成绩颜色为红色 数学成绩颜色为绿色         */
      column.columnBGcolorsArr = @[kUIColorFromRGB(0x00a5d3),kUIColorFromRGB(0xfd9602)];
      /*        模块的提示语         */
      column.xShowInfoText = @[@"SOx",@"NOx",@"烟尘浓度"];
      column.bgVewBackgoundColor = [UIColor whiteColor];
      column.isPro = YES;
      column.typeSpace = 30;
      
     
     //      NSArray *lineArray = @[self.dataDict1[@"soxCeiling"],self.dataDict1[@"noxCeiling"],self.dataDict1[@"somkeDustCeiling"]];
//      
//      column.lineRedAry = lineArray;
      
     // column.lineRedAry = @[@"34",@"33",@"35"];
      
      /*        开始动画         */
    //  [column showAnimation];
      [self.view addSubview:column];
      
      UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(column.frame), _width, 10)];
      [self.view addSubview:lineView];
      lineView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    
      ProListView *proView = [[ProListView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lineView.frame), _width, _height - column.height)];
      
      self.proView= proView;
      //                  "createTime": "2016-12-19 12:00:00",
      //                  "desulfurizationNitrate": "2",脱硝效率值
      //                  "desulfurizationSulfur": "2",脱硫效率值
      //                  "id": "2",
      //                  "nitrateCeiling": "2", 脱硝上限值
      //                  "nox": "2", NOx值
      //                  "noxCeiling": "2", NOx上限值
      //                  "somkeDust": "2", 烟尘值
      //                  "somkeDustCeiling": "2",烟尘上限值
      //                  "sox": "2",       SOx值
      //                  "soxCeiling": "2", SOx上限值
      //                  "sulfurCeiling": "2", 脱硫上限值
      //                  "unitSet": "1" 机组

//      NSArray *proArray = @[@[self.dataDict1[@"sox"],self.dataDict1[@""],self.dataDict2[@""],self.dataDict2[@""]],@[self.dataDict1[@""],self.dataDict1[@""],self.dataDict2[@""],self.dataDict2[@""]],@[self.dataDict1[@""],self.dataDict1[@""],self.dataDict2[@""],self.dataDict2[@""]],@[self.dataDict1[@""],self.dataDict1[@""],self.dataDict2[@""],self.dataDict2[@""]],@[self.dataDict1[@""],self.dataDict1[@""],self.dataDict2[@""],self.dataDict2[@""]]];
      proView.textAry = @[@"SOx\n(mg/Nm3)",@"NOx\n(mg/Nm3)",@"烟尘\n(mg/Nm3)",@"脱硫效率\n(%)",@"脱硝效率\n(%)"];
     // proView.dataAry = self.dataArray;
      //proView.dataAry = @[@{@"":@""}];
      [self.view addSubview:proView];
      
      if (isTest) {
            
            column.lineRedAry = @[@"35",@"50",@"10"];
            column.valueArr = @[
                                @[@6.1,@28.1],
                                @[@45.1,@41.8],
                                @[@4.6,@3.5]];
            
            [column showAnimation];
            
            proView.dataAry = @[@[@"6.1",@"35",@"21.8",@"35"],@[@"45.1",@"50",@"41.8",@"50"],@[@"4.6",@"10",@"3.5",@"10"],@[@"99.9",@"-",@"99.2",@"-"],@[@"92.3",@"-",@"80.6",@"-"]];
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
