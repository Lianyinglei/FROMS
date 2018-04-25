//
//  LogdestailViewController.m
//  dsdl
//
//  Created by 廉英雷 on 16/11/17.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import "LogdestailViewController.h"
#import "LogLab.h"
#import "NSString+Extension.h"
#import "LeftLine.h"
#import "LogDestaiContentView.h"
#import "LogModel.h"
#import "MJExtension.h"
#import "LogDestailModel.h"
#import "LogDesContenView.h"
#import "LogFrameModel.h"

@interface LogdestailViewController ()<UITextViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) LogLab *logView;

@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, weak) LogDesContenView *logContentView;




@property (nonatomic, assign) CGFloat ScrollH;;
@end

@implementation LogdestailViewController

- (LogLab *)logView{

      if (!_logView) {
            _logView = [[NSBundle mainBundle] loadNibNamed:@"LogLab" owner:self options:nil].lastObject;
      }
      return _logView;
}

- (void)customNavigationBar{
      [super customNavigationBar];
      
      self.view.backgroundColor = [UIColor whiteColor];
      UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
      lab.text = @"日志详情";
      lab.font = [UIFont systemFontOfSize:17];
      lab.textAlignment = NSTextAlignmentCenter;
      lab.textColor = [UIColor whiteColor];
      self.navigationItem.titleView = lab;
}

- (void)viewWillAppear:(BOOL)animated{


      [super viewWillAppear:animated];
      self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
      self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    
 
   //   [self creatContentView];
      
      
   //   [self getData];
      
     
      LogDesContenView *logDestailContentView = [[LogDesContenView alloc] initWithFrame:self.view.bounds];
      [self.view addSubview:logDestailContentView];
      self.logContentView = logDestailContentView;
      
     
      if (!isTest) {
             [self getData];
      }else{
      
            LogDestailModel *desMode = [[LogDestailModel alloc] init];
            
            desMode.no = @"02";
            desMode.contentDescribe = @"申请中";
            desMode.executeExplain = @"四职";
            desMode.extended = @"一班";
            desMode.extendedReason = @"1";
            desMode.headDate = @"2017-01-11";
            desMode.weather = @"晴";
            self.logContentView.headArray = @[desMode].copy;
            
            //"content": "dsafdsafdsafsa",
            //"contentDescribe": "1",
            //"execute": "Y",
            //"executeExplain": "1",
            //"extended": "1",
            //"extendedReason": "1",
            //"flight": "1",
            //"id": "1",
            //"no": "1",
            //"type": "1"
            
            //"context": "Aaron测试数据",
            //"id": "1",
            //"notepadPerson": "1",
            //"type": "1"


            LogDestailModel *leftModel = [[LogDestailModel alloc] init];
            leftModel.contentDescribe = @"年快快到了，开始准备年会了";
            leftModel.no = @"02";
            leftModel.executeExplain = @"Y";
            leftModel.extended = @"延期";
            leftModel.extendedReason = @"年终事物较多";
            
            leftModel.dateTime = @"16:35";
            leftModel.context = @"审计开始";
            
            self.logContentView.rightDataAry = @[leftModel,leftModel].copy;
            self.logContentView.leftDataAry = @[leftModel,leftModel].copy;
      
      }
     
}


- (void)getData{
      
      NSString *urlStr = @"getLogDetail/";
      urlStr = [urlStr stringByAppendingString:self.logId];

      [self.httpRequest getURL:appServer withUrl:urlStr withParam:nil httpHeader:[Tools HttpHeader] receiveTarget:@"getLogDetail/1"];
      
//      [self.httpRequest getURL:urlStr withParam:nil httpHeader:[Tools HttpHeader] receiveTarget:@"getLogDetail/1"];
      
}


- (void)successRequest:(id)data withSender:(NSString *)sender{

      if ([sender isEqualToString:@"getLogDetail/1"]) {
            
            NSDictionary *dict = (NSDictionary *)data;
            if (![dict isKindOfClass:[NSNull class]]) {
                  
            
            LogModel *logModel = [LogModel mj_objectWithKeyValues:dict];
            
            LogDestailModel *desMode = [[LogDestailModel alloc] init];
            
            
//            LogFrameModel *framleModle = [[LogFrameModel alloc] init];
            
            desMode.no = logModel.langName;
            desMode.contentDescribe = logModel.status;
            desMode.executeExplain = logModel.jobTitle;
            desMode.extended = logModel.flight;
            desMode.extendedReason = logModel.crewName;
            desMode.headDate = logModel.date;
            desMode.weather = logModel.weather;
                  
            
           // framleModle.logDestailModel = desMode;
            
           // NSMutableArray *headArray = [NSMutableArray array];
//            [headArray addObject:logModel.langName];//值长名称
//            [headArray addObject:logModel.status];//状态
//            [headArray addObject:logModel.jobTitle];//职别
//            [headArray addObject:logModel.flight];//班次
//            [headArray addObject:logModel.crew];//机组
//            [headArray addObject:logModel.weather];//天气
//            [headArray addObject:logModel.date];
            
            
            
        
            self.logContentView.headArray = @[desMode].copy;
            
          //  NSMutableArray *ary1 = [LogDestailModel mj_objectArrayWithKeyValuesArray:logModel.regularWorks];
            
               self.logContentView.rightDataAry = [LogDestailModel mj_objectArrayWithKeyValuesArray:dict[@"notes"]];
            self.logContentView.leftDataAry = [LogDestailModel mj_objectArrayWithKeyValuesArray:dict[@"regularWorks"]];
            
            
            
//            NSMutableArray *headArray = [NSMutableArray array];
//            [headArray addObject:dict[@"langName"]];//值长名称
//            [headArray addObject:dict[@"status"]];//状态
//            [headArray addObject:dict[@"jobTitle"]];//职别
//            [headArray addObject:dict[@"flight"]];//班次
//            [headArray addObject:dict[@"crew"]];//机组
//            [headArray addObject:dict[@"weather"]];//天气
            }else{
            
                 
                  [[Tools shareTools] alert:@"数据为空,请联系工作人员" :nil];
            }
            
      }
}

- (void)agreeBtnClick{

      
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//路径
- (void)test2{
      //1
      // CGContextRef context = UIGraphicsGetCurrentContext();
      //2
      UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 100, 100, 100)];
      [path moveToPoint:CGPointMake(50, 50)];
      [path addLineToPoint:CGPointMake(115, 115)];
      [[UIColor redColor] setStroke];
      path.lineWidth = 3.0;
      [path stroke];
      
      
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
