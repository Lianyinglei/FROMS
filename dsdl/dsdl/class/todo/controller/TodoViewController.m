//
//  TodoViewController.m
//  dsdl
//
//  Created by 廉英雷 on 16/11/17.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import "TodoViewController.h"
#import "TodoTableViewCell.h"
#import "TodoDesViewController.h"
#import "TodoModel.h"
#import "MJExtension.h"

@interface TodoViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) UITableView *tabView;

@property (nonatomic ,strong) NSMutableArray *dataArray;

@property (nonatomic, assign) NSInteger badgeNum;

@property (nonatomic, strong) NSIndexPath *indexPath;
@end

@implementation TodoViewController

- (void)viewDidLoad {
      
    [super viewDidLoad];
      self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
      self.navigationItem.title = @"待办";
      [self creatView];
      UITabBarItem *item = [self.tabBarController.tabBar.items objectAtIndex:1];
      NSString *badgeNum = item.badgeValue;
      self.badgeNum = [badgeNum integerValue];
      // Do any additional setup after loading the view.
     
     // [[self.tabBarController.tabBar.items objectAtIndex:1] setBadgeValue:nil];
      
      if (!isTest) {
            
             [self getData];
           
            
      }else{
      
            for (int i = 0;i<2; i++) {
                  TodoModel *model = [[TodoModel alloc] init];
                  model.taskDescribe = @"任务描述";
                  model.createTime = @"2017-01-11 15:08";
                  [self.dataArray addObject:model];
      }
      }
      
}


- (void)viewWillAppear:(BOOL)animated{
      [super viewWillAppear:animated];
      self.tabBarController.tabBar.hidden = NO;
      
}

- (void)customNavigationBar{
      [super customNavigationBar];
      UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
      lab.text = @"待办";
      lab.font = [UIFont systemFontOfSize:17];
      lab.textAlignment = NSTextAlignmentCenter;
      lab.textColor = [UIColor whiteColor];
      self.navigationItem.titleView = lab;
    //  self.tabBarController.tabBarItem.badgeValue = @"2";
      
     

}


- (NSMutableArray *)dataArray{

      if (!_dataArray) {
            _dataArray = [NSMutableArray array];
      }
    
      return _dataArray;
}
- (void)getData{

      [self.httpRequest getURL:appServer withUrl:@"commission/getCommissionList" withParam:nil httpHeader:[Tools HttpHeader] receiveTarget:@"getCommissionList"];
//      [self.httpRequest getURL:[appServer stringByAppendingString:@"commission/getCommissionList"] withParam:nil httpHeader:[Tools HttpHeader] receiveTarget:@"getCommissionList"];
}

- (void)creatView{

      UITableView *tabView  = [[UITableView alloc] initWithFrame:self.view.bounds];
      [self.view addSubview:tabView];
      
      self.tabView  = tabView;
      self.tabView.delegate = self;
      self.tabView.dataSource = self;
      self.tabView.rowHeight = 70;
      self.tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

      return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
      
   TodoTableViewCell *cell
      = [tableView dequeueReusableCellWithIdentifier:@"todoCell"];
      if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"TodoTableViewCell" owner:self options:nil].lastObject;
      }
      cell.isRead.layer.cornerRadius = 5;
      cell.isRead.layer.masksToBounds = YES;
      
//      if (indexPath.row%2) {
//            cell.isRead.backgroundColor=[UIColor redColor];
//            
//      }else{
//      
//            cell.isRead.backgroundColor = [UIColor clearColor];
//      }
      
      TodoModel *todoModel = self.dataArray[indexPath.row];
      cell.textLab.text = todoModel.taskDescribe;
     // cell.dateLab.text = [todoModel.date stringByAppendingString:todoModel.createTime];
      cell.dateLab.text = todoModel.createTime;
      cell.textLab.textColor = kUIColorFromRGB(0x333333);
      cell.dateLab.textColor = kUIColorFromRGB(0x999999);
//      cell.isRead.hidden = NO;
      //0是未读1是已读
      if ([todoModel.isRead isEqualToString:@"0"]) {
            
            cell.isRead.hidden = NO;
            
      }else{
      
            cell.isRead.hidden = YES;
      }
      
      return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
      
      
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
      
      self.indexPath = indexPath;
       [tableView deselectRowAtIndexPath:indexPath animated:YES];
       TodoModel *todoModel = self.dataArray[indexPath.row];
      TodoTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
     
      
      if (cell.isRead.hidden) {
            
//            TodoDesViewController *todovc = [[TodoDesViewController alloc] init];
//           
//            todovc.descrStr = todoModel.id;
//            [self.navigationController pushViewController:todovc animated:YES];
      }else{
      
            self.httpRequest.sessManager.requestSerializer = [AFJSONRequestSerializer serializer];
          
             [self.httpRequest postURL:appServer withUrl:@"commission/updateIsRead" withParam:@{@"id":todoModel.id} httpHeader:[Tools HttpHeader] receiveTarget:@"updateIsRead"];
            
            
      }
    
       cell.isRead.hidden = YES;
      __weak typeof(self)weakSelf = self;
      TodoDesViewController *todovc = [[TodoDesViewController alloc] init];
      
      todovc.descrStr = todoModel.id;
      todovc.todoDesVCBlock = ^( ){
      
            NSLog(@"---");
            if (weakSelf.dataArray.count >0) {
                  
            
            [weakSelf.dataArray removeObjectAtIndex:weakSelf.indexPath.row];
           [weakSelf.tabView deleteRowsAtIndexPaths:[NSArray arrayWithObject:weakSelf.indexPath] withRowAnimation:YES];
            
//            [weakSelf.tabView reloadData];
            }
      };
      
  [self.navigationController pushViewController:todovc animated:YES];
      
     
}

- (void)errorRequest:(id)data withSender:(NSString *)sender{

      if ([sender isEqualToString:@"updateIsRead"]) {
            NSDictionary *dict = (NSDictionary *)data;
            [[Tools shareTools] alert:dict[@"message"] :nil];
            
      }
}

- (void)successRequest:(id)data withSender:(NSString *)sender{
      
      if ([sender isEqualToString:@"getCommissionList"]) {
            
            
            NSArray *ary = (NSArray *)data;
            if (ary.count == 0) {
                  
                  [self showTipView:@"暂无待办事项"];
                  
                  
            }
            
                  [self.dataArray removeAllObjects];
                  self.dataArray =  [TodoModel mj_objectArrayWithKeyValuesArray:ary];
                  [self.tabView reloadData];
            
           
            
      }
      
      if ([sender isEqualToString:@"updateIsRead"]) {
            
            [self.tabView deselectRowAtIndexPath:self.indexPath animated:YES];
//            TodoModel *todoModel = self.dataArray[self.indexPath.row];
            TodoTableViewCell *cell = [self.tabView cellForRowAtIndexPath:self.indexPath];
            cell.isRead.hidden = YES;
           

            self.badgeNum--;
            if (self.badgeNum <= 0) {
                  [[self.tabBarController.tabBar.items objectAtIndex:1] setBadgeValue:nil];
            }else{
            
                  [[self.tabBarController.tabBar.items objectAtIndex:1] setBadgeValue:[NSString stringWithFormat:@"%ld",(long)self.badgeNum]];
            }
          
//            TodoDesViewController *todovc = [[TodoDesViewController alloc] init];
//            
//            todovc.descrStr = todoModel.id;
//            [self.navigationController pushViewController:todovc animated:YES];
            
            //  [[[[[self tabBarController] tabBar] items] objectAtIndex:1] setBadgeValue:@"2"];
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
