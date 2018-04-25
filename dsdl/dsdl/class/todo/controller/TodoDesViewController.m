//
//  TodoDesViewController.m
//  dsdl
//
//  Created by 廉英雷 on 16/11/17.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import "TodoDesViewController.h"
#import "TodoContentView.h"
#import "TodoDesModel.h"
#import "MJExtension.h"
#import "TodoHeadModel.h"

@interface TodoDesViewController ()



@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, weak) TodoContentView *todoContentView;
@end

@implementation TodoDesViewController

- (void)viewWillAppear:(BOOL)animated{
      [super viewWillAppear:animated];
      self.tabBarController.tabBar.hidden = YES;

}

- (void)customNavigationBar{

      [super customNavigationBar];
      
      UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
      lab.text = @"待办详情";
      lab.font = [UIFont systemFontOfSize:17];
      lab.textAlignment = NSTextAlignmentCenter;
      lab.textColor = [UIColor whiteColor];
      self.navigationItem.titleView = lab;
      
     
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
      self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
      
      [self creatContenView];

      if (!isTest) {
             [self getData];
      }else{
      
           
            TodoHeadModel *headModel = [[TodoHeadModel alloc] init];
            headModel.applyDepartment = @"部门二";
            headModel.applyMajor = @"申请专业";
            headModel.no = @"02";
            headModel.planTotal = @"1000";
            headModel.applyPerson = @"张水";
            headModel.applyTime = @"2017-01-11";
            headModel.budgetProject = @"办年会活动";
            headModel.describe = @"公司开始筹备年会活动";
            headModel.status = @"申请中";
            headModel.type = @"消费";
            headModel.taskDescribe = @"年会快开始了";
            NSMutableArray *headAry = [NSMutableArray array];
            [headAry addObject:headModel];
            self.todoContentView.headAry = headAry;
            
            
            
            TodoDesModel *desModel = [[TodoDesModel alloc] init];
            desModel.demandTotal = @"10";
            desModel.lineCost = @"25";
            desModel.no = @"03";
            desModel.suppliesName = @"年会物资";
            desModel.unitCost = @"15";
            desModel.unit = @"1";
            desModel.warehouse = @"库房一";
            self.todoContentView.dataAry = @[desModel,desModel].copy;
      
      }
     
}


- (void)creatContenView{

      TodoContentView *contentView = [[TodoContentView alloc] initWithFrame:self.view.bounds];
      [self.view addSubview:contentView];
      
      __weak typeof(self)welfSelf = self;
      contentView.contentBlock = ^(NSString *str,NSString *agree){
            
            
            [self.view endEditing:YES];
            
//            [self showTipView:@"提交成功"];
//            
//            self.todoDesVCBlock();
//            
//            [self.navigationController popViewControllerAnimated:YES];
            
            NSDictionary *dict = @{@"id":welfSelf.descrStr,@"opinion":str};
           // [welfSelf.httpRequest.sessManager setValue:@"application/json" forKey:@"Content-Type"];
            
            welfSelf.httpRequest.sessManager.requestSerializer = [AFJSONRequestSerializer serializer];
            [welfSelf.httpRequest postURL:appServer withUrl:@"ccommission/updateCommission" withParam:dict httpHeader:[Tools HttpHeader] receiveTarget:@"updateCommission"];
            
//            //是否已读状态
//            [welfSelf.httpRequest postURL:appServer withUrl:@"commission/updateIsRead" withParam:@{@"id":self.descrStr} httpHeader:[Tools HttpHeader] receiveTarget:@"updateIsRead"];
            
//            [welfSelf.httpRequest postURL:[appServer stringByAppendingString:@"commission/updateIsRead"] withParam:@{@"id":self.descrStr} httpHeader:[Tools HttpHeader] receiveTarget:@"updateIsRead"];
          
            
      };
      
      self.todoContentView = contentView;

}

//-(void)errorRequest:(id)data withSender:(NSString *)sender{
//      
//      NSDictionary *dict = (NSDictionary *)data;
//      // [self showTipView:dict[@"errmsg"]];
//      NSLog(@"报错信息errorRequest---%@",dict[@"errmsg"]);
//      
//}
//- (void)netFailedWithError:(NSError *)error{
//      NSString *str = [error localizedDescription];
//      NSLog(@"报错信息netFail-----%@",str);
//
//}

- (void)getData{

      NSString *urlStr = @"commission/getCommissionDetail/";
      urlStr = [urlStr stringByAppendingString:self.descrStr];
      [self.httpRequest getURL:appServer withUrl:urlStr withParam:nil httpHeader:[Tools HttpHeader] receiveTarget:@"getCommissionDetail"];
//      [self.httpRequest getURL:urlStr withParam:nil httpHeader:[Tools HttpHeader] receiveTarget:@"getCommissionDetail"];
      
//      [self.httpRequest jsonPostURL:[appServer stringByAppendingString:@"/commission/updateIsRead"] withParam:@{@"id":@"1",@"opinion":@"我没意见"} httpHeader:[Tools HttpHeader] receiveTarget:@"updateIsRead"];
      
//      //是否已读状态
//      [self.httpRequest postURL:appServer withUrl:@"commission/updateIsRead" withParam:@{@"id":self.descrStr} httpHeader:[Tools HttpHeader] receiveTarget:@"updateIsRead"];
      
}

- (void)successRequest:(id)data withSender:(NSString *)sender

{
           // NSArray *ary = (NSArray *)data;
      
      if ([sender isEqualToString:@"getCommissionDetail"]) {
           
//            NSArray *ary = (NSArray *)data;
            NSDictionary *dict = (NSDictionary *)data;
            if (![data isKindOfClass:[NSNull class]]) {
//                   NSDictionary *dict = data[0];
                  //表头数据
       NSMutableArray *detailsHeadAry = [TodoHeadModel mj_objectArrayWithKeyValuesArray:dict[@"details"]];
                  
            for (TodoHeadModel *model in detailsHeadAry) {
                  model.taskDescribe = dict[@"taskDescribe"];
                  }
                  self.todoContentView.headAry = detailsHeadAry;
                  
                  //列表数据
                  NSMutableArray *detailsAry = [TodoDesModel mj_objectArrayWithKeyValuesArray:dict[@"affiliateds"]];
                  
                  self.todoContentView.dataAry = detailsAry;
                  
            }else{
            
            
            }
            
           

      }
      
      if ([sender isEqualToString:@"updateCommission"]) {
            
            [self showTipView:@"提交成功"];
            
            self.todoDesVCBlock();
            
            [self.navigationController popViewControllerAnimated:YES];
//            //是否已读状态
//            [self.httpRequest postURL:appServer withUrl:@"commission/updateIsRead" withParam:@{@"id":self.descrStr} httpHeader:[Tools HttpHeader] receiveTarget:@"updateIsRead"];
            
      }
      if ([sender isEqualToString:@"updateIsRead"]) {
            NSLog(@"状态已读");
            
         //   [self.navigationController popViewControllerAnimated:YES];
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
