//
//  LogViewController.m
//  dsdl
//
//  Created by 廉英雷 on 16/11/3.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import "LogViewController.h"
#import "IssueTimeView.h"
#import "LogContentView.h"
#import "LogdestailViewController.h"
#import "LogModel.h"
#import "MJExtension.h"

@interface LogViewController ()<LogContentViewDelegate>

@property(nonatomic, strong) UIDatePicker *DP1;

@property(nonatomic, weak) IssueTimeView *bottom;

@property(nonatomic, weak) LogContentView *contenView1;
//@property(nonatomic, weak) LogContentView *contenView2;
//@property(nonatomic, weak) LogContentView *contenView3;

@property (nonatomic, weak) UIView *headView;

@property (nonatomic, copy) NSString *indexStr;

@property (nonatomic, copy) NSString *dateStr;

@property (nonatomic, copy) NSString *cancelDateStr;

@end

@implementation LogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
      [self creatContentView];
      self.indexStr = @"2";
      NSDate *date = [[NSDate alloc] init];
      
      NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
      [dateFormatter setDateFormat:@"yyyy-MM-dd"];
      NSString *destDateString = [dateFormatter stringFromDate:date];
      self.dateStr = destDateString;
      self.cancelDateStr = self.dateStr;
      

      if (!isTest) {
             [self getLogList:self.indexStr withdate:self.dateStr];
      }else{
      
            LogModel *model = [[LogModel alloc] init];
            //crew = 1;
            //eamLogId = 1;
            //flight = 1;
            //id = 1;
            //jobTitle = 1;
            //langName = 1;
            //langValue = 1
            model.crew = @"1";
            model.eamLogId = @"1";
            model.flight = @"一班";
            model.jobTitle = @"四职";
            model.langName = @"李木";
            model.langValue = @"值长";
            model.status = @"0";
            model.date = @"2017-01-10";
            model.weather = @"晴";
             self.contenView1.dataAry = @[model,model].copy;
            
      }
     
}

- (void)viewWillAppear:(BOOL)animated{

      [super viewWillAppear:animated];
      self.tabBarController.tabBar.hidden  = NO;
}
- (void)customNavigationBar{
      [super customNavigationBar];
      
      self.view.backgroundColor = [UIColor whiteColor];
      UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
      lab.text = @"日志";
      lab.font = [UIFont systemFontOfSize:18];
      lab.textAlignment = NSTextAlignmentCenter;
      lab.textColor = [UIColor whiteColor];
      self.navigationItem.titleView = lab;
      
      UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"查询" style:UIBarButtonItemStyleDone target:self action:@selector(creatTimeView)];
      self.navigationItem.rightBarButtonItem = rightItem;
      
}

- (void)creatContentView{
      
      self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
      
      UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _width, 44)];
      [self.view addSubview:headView];
      self.headView = headView;
      headView.backgroundColor = kUIColorFromRGB(0x1f9d85);
      //先生成存放标题的数据
      NSArray *array = [NSArray arrayWithObjects:@"值长",@"1#机长",@"2#机长", nil];
      //初始化UISegmentedControl
      UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:array];
      //设置frame
      segment.frame = CGRectMake(10, 7,headView.width -20,30);
      segment.selectedSegmentIndex = 0;
      UIFont *font = [UIFont boldSystemFontOfSize:16.0f];
      NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                             forKey:NSFontAttributeName];
      
      [segment setTitleTextAttributes:attributes forState:UIControlStateNormal];
      
      
      segment.tintColor = [UIColor whiteColor];
      segment.backgroundColor = kUIColorFromRGB(0x1f9d85);
      //添加到视图
      [headView addSubview:segment];
      [segment addTarget:self action:@selector(didseletSegment:) forControlEvents:UIControlEventValueChanged];
      
      LogContentView *contentView = [[LogContentView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headView.frame)+10, _width, _height - 30-134)];
      [self.view addSubview:contentView];
      self.contenView1 = contentView;

//      contentView.backgroundColor = [UIColor redColor];
      contentView.delegate = self;
      
      
}

- (void)didseletSegment:(UISegmentedControl *)seg{

      if (isTest) {
            LogModel *model = [[LogModel alloc] init];
            //crew = 1;
            //eamLogId = 1;
            //flight = 1;
            //id = 1;
            //jobTitle = 1;
            //langName = 1;
            //langValue = 1
            model.crew = @"1";
            model.eamLogId = @"1";
            model.flight = @"一班";
            model.jobTitle = @"四职";
            model.langName = @"李木";
            model.langValue = @"值长";
            model.status = @"0";
            model.date = @"2017-01-10";
            model.weather = @"晴";
            self.contenView1.dataAry = @[model,model].copy;
            
      }else{
      
            self.cancelDateStr = self.dateStr;
            switch (seg.selectedSegmentIndex) {
                  case 0:
                  {
                        //                  LogContentView *contentView = [[LogContentView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(seg.frame), _width, _height - 30)];
                        //                 // [self.view addSubview:contentView];
                        //                  self.contenView = contentView;
                        //                  contentView.delegate = self;
                        //                  [self.view addSubview:contentView];
                        //                  [self.contenView2 removeFromSuperview];
                        //                  [self.contenView3 removeFromSuperview];
                        
                        self.indexStr = @"2";
                        [self getLogList:self.indexStr withdate:self.dateStr];
                        
                        
                  }
                        break;
                  case 1:
                  {
                        
                        //                  LogContentView *contentView = [[LogContentView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headView.frame)+10, _width, _height - 44)];
                        //                  contentView.backgroundColor = [UIColor redColor];
                        //                  // [self.view addSubview:contentView];
                        //                  self.contenView2 = contentView;
                        //                  _contenView2.delegate = self;
                        //                  [self.view addSubview:_contenView2];
                        // [self.view addSubview];
                      
                        
                        self.indexStr = @"0";
                        [self getLogList:self.indexStr withdate:self.dateStr];
                        
                  }
                        break;
                  case 2:{
                        //                  LogContentView *contentView = [[LogContentView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headView.frame)+10, _width, _height - 44)];
                        //                  // [self.view addSubview:contentView];
                        //                  self.contenView3 = contentView;
                        //                  contentView.delegate = self;
                        //                  [self.view addSubview:contentView];
                        //                  UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(seg.frame), _width, _height - 30)];
                        //                  [self.view addSubview:backView];
                        //                  backView.backgroundColor = [UIColor redColor];
                        self.indexStr = @"1";
                        [self getLogList:self.indexStr withdate:self.dateStr];
                        
                        
                        
                        
                  }
                        
                  default:
                        break;
            }

      }
      
      
      NSInteger seleInteger = seg.selectedSegmentIndex;
      
      NSLog(@"-----Index %li", (long)seleInteger);
      

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)creatTimeView{
      
      //建立要承载2个Btn和DatePicker的View
      UIView *view = [[UIView alloc]init];
      
      view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
      view.userInteractionEnabled = YES;
      
      //建立取消确定Btn
      CGFloat btnW = 70;
      CGFloat btnH = 40;
      UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, btnW, btnH)];
      UIButton *certainF = [[UIButton alloc]initWithFrame:CGRectMake(_width - btnW, 0, btnW, btnH)];
      
      
      //Btn字体颜色，背景,大小
      [cancel setTitleColor:kUIColorFromRGB(0x999999) forState:UIControlStateNormal];
      [certainF setTitleColor:themeColor forState:UIControlStateNormal];
      
      
      cancel.titleLabel.font = [UIFont boldSystemFontOfSize:16];
      certainF.titleLabel.font = [UIFont boldSystemFontOfSize:16];
      
      cancel.backgroundColor = [UIColor clearColor];
      certainF.backgroundColor = [UIColor clearColor];
      
      [cancel setTitle:@"取消" forState:UIControlStateNormal];
      [certainF setTitle:@"完成" forState:UIControlStateNormal];
      
      //取消的点击方法
      [cancel addTarget:self action:@selector(clickCancelBtn) forControlEvents:UIControlEventTouchUpInside];
      
      //完成的点击方法
      [certainF addTarget:self action:@selector(clickCertainF) forControlEvents:UIControlEventTouchUpInside];
      
      [view addSubview:cancel];
      [view addSubview:certainF];
      
      //建立DatePicker
      UIDatePicker*DP = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, btnH, _width,(_width / 375) * 230)];
      DP.backgroundColor = [UIColor whiteColor];
      //显示年月日
      DP.datePickerMode = UIDatePickerModeDate;
      
      //设置为当天
      [DP setCalendar:[NSCalendar currentCalendar]];
      //设置属性
      
      
      [DP addTarget:self action:@selector(firstDateChanged:) forControlEvents:UIControlEventValueChanged ];//重点：UIControlEventValueChanged
      
      //设置显示格式
      //默认根据手机本地设置显示为中文还是其他语言
      NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文显示
      DP.locale = locale;
      
      
      self.DP1 = DP;
      [view addSubview:self.DP1];
      
      NSDate *date = self.DP1.date;
      
      NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
      [dateFormatter setDateFormat:@"yyyy-MM-dd"];
      NSString *destDateString = [dateFormatter stringFromDate:date];
      self.dateStr = destDateString;
     // NSLog(@"时间shishishi----%@",destDateString);

      
   //   [self.contentView addSubview:view];
      IssueTimeView *bottom = [IssueTimeView popViewWithContentView:view];
      bottom.dimBackground = YES;
      CGFloat viewH = (_width / 375) * 230 + btnH;
      [bottom showInRect:CGRectMake(0, _height - viewH, _width, viewH)];
      self.bottom = bottom;
      UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCancelBtn)];
      bottom.userInteractionEnabled = YES;
      [bottom addGestureRecognizer:tap];
      
}

-(void)firstDateChanged:(id)sender
{
      
      UIDatePicker *control = (UIDatePicker*)sender;
      NSDate* date = control.date;
      // NSDate *selected = [datePicker date];
      NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
      [dateFormatter setDateFormat:@"yyyy-MM-dd"];
      NSString *destDateString = [dateFormatter stringFromDate:date];
      NSLog(@"时间----%@",destDateString);
      self.dateStr = destDateString;
      
     
//      self.issTimeStr = destDateString;
//      MySelfTableViewCell *dateCell = [self.tabView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
//      dateCell.labdetial.text = destDateString;
      
}


-(void)clickCancelBtn
{
      
      self.dateStr = self.cancelDateStr;
      [self.bottom removeFromSuperview];
      
}

#pragma mark ----完成按钮------
-(void)clickCertainF{
      
       [self getLogList:self.indexStr withdate:self.dateStr];
      
//      MySelfTableViewCell *dateCell = [self.tabView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
//      dateCell.labdetial.text = self.issTimeStr;
      
      [self.bottom removeFromSuperview];
      
}

- (void)deseleLogCollectionCell:(NSIndexPath *)indexPath withId:(NSString *)logId{

      
      LogdestailViewController *logDesVC = [[LogdestailViewController alloc] init];
      logDesVC.logId = logId;
      [self.navigationController pushViewController:logDesVC animated:YES];
}


//获取数据

- (void)getLogList:(NSString *)crew withdate:(NSString *)date{

      
      //NSString *token = TOKENID;
      NSLog(@"token---%@",TOKENID);
      NSDictionary *headDict = @{@"token":TOKENID,@"Content-Type":@"application/json"};
      NSDictionary  *dict = @{@"crew":crew,@"date":date};
      
      self.httpRequest.sessManager.requestSerializer = [AFJSONRequestSerializer serializer];
      [self.httpRequest postURL:appServer withUrl:@"getLogList" withParam:dict httpHeader:headDict receiveTarget:@"getLogList"];
      
//      [self.httpRequest postURL:[appServer stringByAppendingString:@"getLogList"] withParam:dict httpHeader:headDict receiveTarget:@"getLogList"];
//      [self.httpRequest jsonPostURL: [appServer stringByAppendingString:@"getLogList"] withParam:dict httpHeader:headDict receiveTarget:@"getLogList"];
      
//      [self.httpRequest postURL:@"http://192.168.1.161:8080/getLogList" withParam:dict httpHeader:headDict receiveTarget:@"getLogList"];
      
}

- (void)successRequest:(id)data withSender:(NSString *)sender{
      if ([sender isEqualToString:@"getLogList"]) {
            
            NSArray *dictAry = (NSArray *)data;
           // NSArray *ary = dict[@"regularWorks"];
            if (dictAry.count == 0) {
                 
                   [self showTipView:@"暂无日志"];
            }
            
                  NSMutableArray *logAry = [LogModel mj_objectArrayWithKeyValuesArray:dictAry];
                  NSLog(@"返回的数据-----%@",logAry);
                  self.contenView1.dataAry = logAry;
            
           
            
            
      }

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
