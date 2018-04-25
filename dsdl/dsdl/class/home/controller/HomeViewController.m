//
//  HomeViewController.m
//  dsdl
//
//  Created by 廉英雷 on 16/11/2.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import "HomeViewController.h"
#import "WMGaugeView.h"
//#import "XCMultiSortTableView.h"
#import "ProfitContentView.h"
#import "ProfitHeadView.h"
//#import "JHLineChart.h"
//#import "LineView.h"
#import "ListView.h"
#import "ZFProgressView.h"
#import "HomeRightViewController.h"
#import "HKPieChartView.h"
#import "HomeRigthView.h"
#import "HomeHeadView.h"
#import "IndicatorContentView.h"
#import "KeyViewController.h"
#import "CoalViewController.h"
#import "UnitViewController.h"
#import "ProViewController.h"
#import "MyselfViewController.h"
#import "FuleViewController.h"
#import "KYWaterWaveView.h"
#import "ImportantViewController.h"
#import "CKAlertViewController.h"
#import "HomeModel.h"
#import "MJExtension.h"
#import "YLSatatusTool.h"

#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
@interface HomeViewController ()<UIScrollViewDelegate,IndicatorContentViewDelegate>

//@property (nonatomic, weak) ProfitHeadView *headView;
@property (nonatomic, weak) HomeHeadView *headView;

@property (nonatomic, weak) UIView *scrollView;

@property (nonatomic, weak) UIScrollView *scrollView1;

@property (nonatomic, weak) UIPageControl *page;

@property (nonatomic, weak) HKPieChartView *gaugeView;

@property (nonatomic, strong) WMGaugeView *gaugeView2;

@property (nonatomic,strong) NSArray *profitAry;

//利润的数据源
@property (nonatomic, strong) NSMutableArray *roundData;

@property (nonatomic, strong) NSMutableArray *firstData;

@property (nonatomic, weak)  ProfitContentView *profitView;

@property (nonatomic, strong) NSTimer *timer;


@end

@implementation HomeViewController


- (NSMutableArray *)roundData{

if (!_roundData) {
      _roundData = [NSMutableArray array];
}

return _roundData;
}

- (NSMutableArray *)firstData{

if (!_firstData) {
      _firstData = [NSMutableArray array];
}
// [_firstData removeAllObjects];
return _firstData;
}

//面消失，进入后台不显示该页面，关闭定时器
-(void)viewDidDisappear:(BOOL)animated
{
      [super viewDidDisappear:animated];
      //关闭定时器
      [self.timer setFireDate:[NSDate distantFuture]];
}
- (void)viewWillAppear:(BOOL)animated{
      
[super viewWillAppear:animated];
self.tabBarController.tabBar.hidden = NO;
[self.timer setFireDate:[NSDate distantPast]];

if (isTest) {
      if (_gaugeView) {
             [self.gaugeView updatePercent:91.1 animation:YES];
             self.gaugeView.roundStr = @"136.67";
      }
     
}


}

- (void)viewWillDisappear:(BOOL)animated{

[super viewWillDisappear:animated];
[self.timer setFireDate:[NSDate distantFuture]];
      
}

- (void)viewDidLoad
{
      
[super viewDidLoad];
self.view.backgroundColor =  [UIColor colorWithWhite:0.95 alpha:1.0];
      

[self creatHeaderView];

[self creatViewList];
      

   
      
     // NSString *ip = [[Tools shareTools] getIPAddress];
    //  NSString *name = [Tools getNetWorkStates];
   //   NSLog(@"ip----%@---  name--%@",name);

if (!isTest) {
      
      self.timer = [NSTimer timerWithTimeInterval:180.0 target:self selector:@selector(getData) userInfo:nil repeats:YES];
      // [self.timer fire];
      [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
      
      //是否有网络
      if (![Tools isNetWork]) {
           
            
      
             NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask , YES)lastObject];
            path = [path stringByAppendingPathComponent:@"getUnitHome.data"];
            
            NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
            if (dict) {
                  
            [self successRequest:dict withSender:@"getUnitHome"];
                  
            }
//
             NSString *path2 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask , YES)lastObject];
            [path2 stringByAppendingPathComponent:@"getProfitDay.data"];
            NSDictionary *dict2 = [NSDictionary dictionaryWithContentsOfFile:path2];
            if (dict2) {
                  [self successRequest:dict2 withSender:@"getProfitDay"];
            }
           
       }
      //386869096
      [self getData];
      [self getVersion];
      
     
}
 

      
}


- (void)getVersion{
      
      [self.httpRequest getURL:appServer withUrl:@"api/softUpdate/ios/getLatestVersion" withParam:nil httpHeader:[Tools HttpHeader] receiveTarget:@"getLatestVersion"];

// [self.httpRequest getURL:[appServer stringByAppendingString:@"api/softUpdate/ios/getLatestVersion"] withParam:nil httpHeader:[Tools HttpHeader] receiveTarget:@"getLatestVersion"];

}

- (void)getData{
      
      
      
      
                  
                  [self.httpRequest getURL:appServer withUrl:@"unit/getUnitHome" withParam:nil httpHeader:[Tools HttpHeader] receiveTarget:@"getUnitHome"];

      
                  
                   [self.httpRequest getURL:appServer withUrl:@"profits/getProfitsDay" withParam:nil httpHeader:[Tools HttpHeader] receiveTarget:@"getProfitDay"];     
      


//机组情况
     
      
//[self.httpRequest getURL:[appServer stringByAppendingString:@"unit/getUnitHome"] withParam:nil httpHeader:[Tools HttpHeader] receiveTarget:@"getUnitHome"];

     // [self performSelector:@selector(http2) withObject:nil];
//利润数据
     
// [self.httpRequest getURL:[appServer stringByAppendingString:@"profits/getProfitsDay"] withParam:nil httpHeader:[Tools HttpHeader] receiveTarget:@"getProfitDay"];

//      //重要参数
//      [self.httpRequest postURL:[appServer stringByAppendingString:@"parameter/getParameter"] withParam:nil httpHeader:[Tools HttpHeader] receiveTarget:@"getParameter"];

}

- (void)http2{

      
}

- (void)dealloc{

 [self.timer invalidate];
  self.timer = nil;
  NSLog(@"%@ dealloc", NSStringFromClass([self class]));
 }

- (void)successRequest:(id)data withSender:(NSString *)sender{

if ([sender isEqualToString:@"getUnitHome"]) {
     
       
      [self.firstData removeAllObjects];
      if ([data isKindOfClass:[NSNull class]]) {
            
      data = @{@"loadV1":@"-",@"loadV2":@"-",@"loadRateV1":@"-",@"loadRateV2":@"-",@"agcV1":@"-",@"agcV2":@"-",@"heatingLoadV1":@"-",@"heatingLoadV2":@"-"};

      }
      NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask , YES)lastObject];
      path = [path stringByAppendingPathComponent:@"getUnitHome.data"];
      [data writeToFile:path atomically:YES];
      
      
      HomeModel *model = [HomeModel mj_objectWithKeyValues:data];
      
      NSMutableArray *dataArray = [NSMutableArray array];
            [dataArray addObject:model.loadV1];
            [dataArray addObject:[NSString stringWithFormat:@"%f",[model.loadRateV1 floatValue]*100]];
            [dataArray addObject:model.agcV1];
            [dataArray addObject:model.heatingLoadV1];
            [self.firstData addObject:dataArray];

    NSMutableArray *dataArray2 = [NSMutableArray array];
                  
      [dataArray2 addObject:model.loadV2];
      [dataArray2 addObject:[NSString stringWithFormat:@"%f", [model.loadRateV2 floatValue]*100]];
      [dataArray2 addObject:model.agcV2];
      [dataArray2 addObject:model.heatingLoadV2];
      [self.firstData addObject:dataArray2];
      
      self.headView.dataArray = self.firstData;
     
      
}

if ([sender isEqualToString:@"getProfitDay"]) {
     
      NSDictionary *dict = (NSDictionary *)data;
      [self.roundData removeAllObjects];
      if ([data isKindOfClass:[NSNull class]]) {
            
            NSLog(@"返回数据为空");
            dict = @{@"profitsYesterday":@"-",@"totalMonth":@"-",@"commissionNumber":@""};
            
      }
      
      NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask , YES)lastObject];
       path = [path stringByAppendingPathComponent:@"getProfitDay.data"];
       [dict writeToFile:path atomically:YES];
      
      if ([dict[@"commissionNumber"] isEqualToString:@"0"]) {
            [[[[[self tabBarController] tabBar] items] objectAtIndex:1] setBadgeValue:nil];
      }else{
             [[[[[self tabBarController] tabBar] items] objectAtIndex:1] setBadgeValue:dict[@"commissionNumber"]];
      
      }
      
     
      NSString *yestaday  = [NSString stringWithFormat:@"%f", [[dict objectForKey:@"profitsYesterday"] floatValue]/10000];
     [self.roundData addObject:yestaday];
      //@"commissionNumber"
            //   [self.roundData addObject:@"-"];
      NSString *totalMonth = [NSString stringWithFormat:@"%f", [[dict objectForKey:@"totalMonth"] floatValue]/10000];
      
     
            [self.roundData addObject:totalMonth];
      
      
            
            self.profitView.dataAry = self.roundData;
            
            if (self.gaugeView) {
                  
                  CGFloat percent = [dict[@"profitsYesterday"] floatValue]/10000;
            

                //  self.gaugeView.roundStr = [NSString stringWithFormat:@"%.2f",percent];
                  self.gaugeView.roundStr = [Tools getNumberTwo:[NSString stringWithFormat:@"%f",percent]];
             CGFloat p = (percent/120.0);
//                  p = - 0.30;
                  [self.gaugeView updatePercent:p*100 animation:YES];
            }
     
}

if ([sender isEqualToString:@"getLatestVersion"]) {
      
      NSDictionary *dict = (NSDictionary *)data;
      
      //            "UPVERSION": "1.0",
      //            "UPHTTPURL": "https://www.aaron.com",
      //            "ISMUST": "true",
      //            "UPITEMS": "\n\t首版\n\t",
      //            "ISUPDATE": "true"
      if ([dict[@"UPVERSION"] isEqualToString:[Tools getVersion]]) {
          //  [self showTipView:@"当前版本为最新版本"];
      }else{
            
            //                  CKAlertViewController *alertVC = [CKAlertViewController alertControllerWithTitle:@"发现新版本" message:@"1. 日夜赶工,修复了一堆bug.\n2. 跟着产品经理改来改去,增加了很多功能.\n3. 貌似性能提升了那么一点点." ];
            
            CKAlertViewController *alertVC = [CKAlertViewController alertControllerWithTitle:@"发现新版本" message:dict[@"UPITEMS"] ];
            alertVC.messageAlignment = NSTextAlignmentLeft;
            
            //  __weak typeof(self)welfSelf = self;
            CKAlertAction *cancel = [CKAlertAction actionWithTitle:@"稍后更新" handler:^(CKAlertAction *action) {
                  NSLog(@"点击了 %@ 按钮",action.title);
            }];
            
            CKAlertAction *update = [CKAlertAction actionWithTitle:@"立即更新" handler:^(CKAlertAction *action) {
                  NSLog(@"点击了 %@ 按钮",action.title);
                  
                  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:dict[@"UPHTTPURL"]]];
                  
//                  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-services://?action=download-manifest&url=https://raw.githubusercontent.com/Lianyinglei/Me/master/szds.plist"]];
                  
                  
            }];
            
            
            [alertVC addAction:cancel];
            [alertVC addAction:update];
            
            [self presentViewController:alertVC animated:NO completion:nil];
            
            
      }
}
      

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

}

- (void)errorRequest:(id)data withSender:(NSString *)sender{
      if ([sender isEqualToString:@"getProfitDay"]) {
            
            NSDictionary *dict = (NSDictionary *)data;
            [self.roundData removeAllObjects];
            
          
            dict = @{@"profitsYesterday":@"-",@"totalMonth":@"-",@"":@""};
            
            //@"commissionNumber"
            [self.roundData addObject:[dict objectForKey:@"profitsYesterday"]];
            //   [self.roundData addObject:@"-"];
           
            [self.roundData addObject:[dict objectForKey:@"totalMonth"]];
            
            self.profitView.dataAry = self.roundData;
            
            if (self.gaugeView) {
                  
                  
                  self.gaugeView.roundStr = dict[@"profitsYesterday"];
                  [self.gaugeView updatePercent:0 animation:YES];
            }

      }
}
- (void)customNavigationBar{

[super customNavigationBar];
UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
lab.text = @"首页";
lab.font = [UIFont systemFontOfSize:18];
lab.textAlignment = NSTextAlignmentCenter;
lab.textColor = [UIColor whiteColor];
self.navigationItem.titleView = lab;


}

- (void)clickRightView{

HomeRightViewController *rightVC = [[HomeRightViewController alloc] init];
[self.navigationController pushViewController:rightVC animated:YES];
}
//发电量表格
- (void)creatHeaderView{

UIScrollView *scrollView1 = [[UIScrollView alloc] initWithFrame:self.view.bounds];
scrollView1.contentSize = CGSizeMake(_width, _height+100);
[self.view addSubview:scrollView1];
self.scrollView1  = scrollView1;
self.scrollView1.showsHorizontalScrollIndicator = NO;
self.scrollView1.pagingEnabled = YES;
self.scrollView1.delegate = self;

//--------右侧视图---------


HomeRigthView *rightView = [[HomeRigthView alloc] initWithFrame:CGRectMake(_width, 0, _width, _height)];
rightView.backgroundColor = kUIColorFromRGB(0xd7dde4);
[self.scrollView1 addSubview:rightView];


// ProfitHeadView *headView = [[ProfitHeadView alloc] initWithFrame:CGRectMake(0, 0, _width, 130)];
HomeHeadView *headView = [[HomeHeadView alloc] initWithFrame:CGRectMake(0, 0, _width, 160)];

if (isTest) {
      
       headView.dataArray = @[@[@"305.72",@"92.6",@"305",@"446.95"],@[@"310.6",@"94.1",@"310",@"808.94"]];
}

[self.scrollView1 addSubview:headView];
self.headView = headView;






UIView *scrollView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headView.frame),_width,(self.view.height - 210-64)*0.45)];
// scrollView.contentSize = CGSizeMake(0, 0);
[self.scrollView1 addSubview:scrollView];
self.scrollView  = scrollView;
//      self.scrollView.showsHorizontalScrollIndicator = NO;
//      self.scrollView.pagingEnabled = YES;
//  self.scrollView.delegate = self;
self.scrollView.backgroundColor = kUIColorFromRGB(0xf4f4f4);
scrollView.userInteractionEnabled = YES;

KYWaterWaveView *waterView = [[KYWaterWaveView alloc] initWithFrame:CGRectMake(0, 20, self.scrollView.width, self.scrollView.height-20)];
[scrollView addSubview:waterView];
waterView.waveSpeed = 1.0;
waterView.waveAmplitude = 30.0;
waterView.waveColor = kUIColorFromRGB(0xe1e1e1);
waterView.alpha = 0.4;
[waterView wave];


UITapGestureRecognizer * PrivateLetterTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickRightView)];
PrivateLetterTap.numberOfTouchesRequired = 1; //手指数
PrivateLetterTap.numberOfTapsRequired = 1; //tap次数
[scrollView addGestureRecognizer:PrivateLetterTap];

    [self creatRoundView];

//日利润view
ProfitContentView *profitView = [[ProfitContentView alloc] initWithFrame:CGRectMake( CGRectGetMaxX(self.gaugeView.frame), self.gaugeView.y, _width -CGRectGetWidth(self.gaugeView.frame), self.gaugeView.height)];
 profitView.centerY = self.gaugeView.centerY+5;
// CGFloat width = _width;

if (_width == IPHONE5W) {
      
      profitView.y = 0;
}
if (_width == IPHONE6W) {
       profitView.centerY = self.gaugeView.centerY+10;
      
}if (_width == IPHONE6PW) {
      
       profitView.centerY = self.gaugeView.centerY+30;
}

[self.scrollView addSubview:profitView];
profitView.backgroundColor = [UIColor clearColor];
if (isTest) {
      
          profitView.dataAry = @[@"136.67",@"2540.32"];
}

//   profitView.dataAry = self.roundData.copy;
self.profitView = profitView;
profitView.profitAry = @[@"今   日",@"月累计"];
profitView.headStr = @"      日利润  (万元)";



UIPageControl *page = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scrollView.frame) , _width, 0)];
// page.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
page.backgroundColor = kUIColorFromRGB(0x4ac6ff);
[self.scrollView1 addSubview:page];
self.page = page;

//   self.page.numberOfPages = 2;
//   // self.page.currentPage = 0;
//   page.pageIndicatorTintColor = kUIColorFromRGB(0x53abd3);
page.currentPageIndicatorTintColor = [UIColor clearColor];


}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
CGFloat s = self.scrollView.frame.size.width;
// NSLog(@"------%zd",s);
if (scrollView.contentOffset.x >_width) {
      
           }
int page = (scrollView.contentOffset.x +0.5*s )/s;

self.page.currentPage = page;


}

//表格视图
- (void)creatViewList{

//      NSLog(@"self.view-----%f",self.view.height);
//      NSLog(@"heigth-----%f",_height);




//      ListView *listView = [[ListView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.page.frame)+10, _width, (self.view.height - 210 -64)*0.6)];
//      listView.dataAry = @[@"268.3",@"16.25",@"546.5",@"537.2",@"270.8",@"-98.11",@"115.4",@"5.58",@"93.18",@"8514"];
//      [self.scrollView1 addSubview:listView];

IndicatorContentView *contentView = [[IndicatorContentView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.page.frame), _width, (self.view.height - 210 -64)*0.55)];
contentView.delegate = self;
contentView.userInteractionEnabled = YES;
contentView.isHome = YES;
contentView.textAry = @[@[@"关键指标",@"能耗指标",@"机组指标",@"环保指标",@"燃料指标",@"重要参数"]];
contentView.imageAry = @[@[@"gjzb",@"nhzb",@"jzzb",@"hbzb",@"rlzb",@"zycs"]];

[self.scrollView1 addSubview:contentView];

}

#pragma mark -----indictorViewDeleaget -------
- (void)deseleCollectionCell:(NSIndexPath *)indexPath{

if (indexPath.section == 0) {
      if (indexPath.row == 0) {
            KeyViewController *keyVC = [[KeyViewController alloc] init];
            [self.navigationController pushViewController:keyVC animated:YES];
      }
      
      if (indexPath.row == 1) {
            CoalViewController *cocalVC = [[CoalViewController alloc] init];
            [self.navigationController pushViewController:cocalVC animated:YES];
      }if (indexPath.row == 2) {
            
            UnitViewController *unitVC = [[UnitViewController alloc] init];
            [self.navigationController pushViewController:unitVC animated:YES];
      }if (indexPath.row == 3) {
            
            ProViewController *proVC = [[ProViewController alloc] init];
            [self.navigationController pushViewController:proVC animated:YES];
      }
      if (indexPath.row == 4) {
            FuleViewController *fuleVC = [[FuleViewController alloc] init];
            [self.navigationController pushViewController:fuleVC animated:YES];
      }if (indexPath.row ==5) {
            ImportantViewController *importVC = [[ImportantViewController alloc] init];
            [self.navigationController pushViewController:importVC animated:YES];
      }
}
if (indexPath.section ==1) {
      
      [self showTipView:@"等待接入..."];
}
if (indexPath.section ==2 ) {
      if (indexPath.row == 0) {
            MyselfViewController *myselfVC = [[MyselfViewController alloc] init];
            [self.navigationController pushViewController:myselfVC animated:YES];
      }
      
      
}
}





- (void)creatRoundView{

HKPieChartView *progress1 =   [[HKPieChartView alloc]initWithFrame:CGRectMake(30, 10, self.scrollView.height -20 , self.scrollView.height-20)];
if (isTest) {
        [progress1 updatePercent:80.56 animation:YES];
      progress1.roundStr = @"136.67";
}

[self.scrollView addSubview:progress1];

self.gaugeView = progress1;


//      ZFProgressView *progress1 = [[ZFProgressView alloc] initWithFrame:CGRectMake(5, 5, self.scrollView.height -10 , self.scrollView.height-10)];
//       progress1.isHome = YES;
//      [self.scrollView addSubview:progress1];
//      self.gaugeView = progress1;
//      progress1.backgroundColor = [UIColor clearColor];
//      [progress1 setProgressStrokeColor:kUIColorFromRGB(0x00fcf3)];
//      [progress1 setBackgroundStrokeColor:kUIColorFromRGB(0x6bcffd)];
//      progress1.lineWidth = 7.0;
//      progress1.timeDuration = 1.0;
//      progress1.digitTintColor = [UIColor whiteColor];
//
//      [progress1 setProgress:0.7632 Animated:YES];



}


- (void)didReceiveMemoryWarning
{
[super didReceiveMemoryWarning];
// Dispose of any resources that can be recreated.
}


@end
