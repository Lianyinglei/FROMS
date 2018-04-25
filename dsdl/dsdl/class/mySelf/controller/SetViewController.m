//
//  SetViewController.m
//  dsdl
//
//  Created by 廉英雷 on 16/12/29.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import "SetViewController.h"

#import "LoginViewCon.h"
#import "CKAlertViewController.h"
#import "SetTableViewCell.h"
#import "IndicatorViewController.h"
#import "BaseNavgationViewController.h"

@interface SetViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation SetViewController


- (void)customNavigationBar{
      
      [super customNavigationBar];
      UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
      lab.text = @"设置";
      lab.font = [UIFont systemFontOfSize:18];
      lab.textAlignment = NSTextAlignmentCenter;
      lab.textColor = [UIColor whiteColor];
      self.navigationItem.titleView = lab;
      
      //      UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"利润" style:UIBarButtonItemStyleDone target:self action:@selector(clickRightView)];
      //      self.navigationItem.rightBarButtonItem = item;
      
      
}


- (void)exitView{
      
      //      UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(_width*0.5 -50, CGRectGetMaxY(self.tableView.frame)+40, 100, 100)];
      //      [self.view addSubview:imgView];
      //      imgView.image = [UIImage imageNamed:@"grxx_icon.png"];
      UIButton *bottomBtn = [[UIButton alloc] initWithFrame:CGRectMake(20,_height - 128, _width - 40, 44)];
      [self.view addSubview:bottomBtn];
      bottomBtn.backgroundColor = kUIColorFromRGB(0x1f9d85);
      [bottomBtn setTitle:@"退出当前账号" forState:UIControlStateNormal];
      [bottomBtn setTitleColor:kUIColorFromRGB(0xffffff) forState:UIControlStateNormal];
      bottomBtn.titleLabel.font = [UIFont systemFontOfSize:18];
      bottomBtn.layer.cornerRadius = 5;
      bottomBtn.layer.masksToBounds = YES;
      bottomBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
      [bottomBtn addTarget:self action:@selector(exitAccount) forControlEvents:UIControlEventTouchUpInside];
      
      
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
      
      self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
      [self creatView];
      [self exitView];
}


- (void)creatView{
      UITableView *tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, _width, 88)];
      [self.view addSubview:tabView];
      self.tableView = tabView;
      self.tableView.delegate = self;
      self.tableView.dataSource = self;
      self.tableView.rowHeight = 44;
      self.tableView.scrollEnabled = NO;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
      return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
      
      SetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"setCell"];
      if (!cell) {
            
            cell = [[NSBundle mainBundle] loadNibNamed:@"SetTableViewCell" owner:self options:nil].lastObject;
      }
      cell.lineView.hidden = YES;
      if (indexPath.row == 0) {
            cell.leftLab.text = @"版本号";
            cell.numLab.text = [@"V" stringByAppendingString:[Tools getVersion]];
            cell.lineView.hidden = NO;
      }
      if (indexPath.row == 1) {
            
            cell.leftLab.text = @"检查更新";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
      }
      return cell;


}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

      if (indexPath.row == 1) {
            [self.httpRequest getURL:appServer withUrl:@"api/softUpdate/ios/getLatestVersion" withParam:nil httpHeader:[Tools HttpHeader] receiveTarget:@"getLatestVersion"];
//            [self.httpRequest getURL:[appServer stringByAppendingString:@"api/softUpdate/ios/getLatestVersion"] withParam:nil httpHeader:[Tools HttpHeader] receiveTarget:@"getLatestVersion"];
      }
      [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)successRequest:(id)data withSender:(NSString *)sender{

      if ([sender isEqualToString:@"layout"]) {
            
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"tokenId"];
//            
//            IndicatorViewController *indictorsVC = [[IndicatorViewController alloc] init];
//           
//            [self.navigationController popToViewController:indictorsVC animated:NO];
            
            self.tabBarController.selectedIndex = 0;
      
            
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            [window makeKeyAndVisible];
            LoginViewCon *loginVC = [[LoginViewCon alloc] init];
           // LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
            
            window.rootViewController = loginVC;

          //  [self showTipView:@"退出登录"];
      }

      
      if ([sender isEqualToString:@"getLatestVersion"]) {
            
            NSDictionary *dict = (NSDictionary *)data;
            
//            "UPVERSION": "1.0",
//            "UPHTTPURL": "https://www.aaron.com",
//            "ISMUST": "true",
//            "UPITEMS": "\n\t首版\n\t",
//            "ISUPDATE": "true"
            if ([dict[@"UPVERSION"] isEqualToString:[Tools getVersion]]) {
                  [self showTipView:@"当前版本为最新版本"];
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
                        [[UIApplication sharedApplication] openURL:dict[@"UPHTTPURL"]];
                  }];
                  
                  [alertVC addAction:cancel];
                  [alertVC addAction:update];
                  
                  [self presentViewController:alertVC animated:NO completion:nil];
                  
            
            }
            
      }
}
- (void)exitAccount{
      
      
      
                  NSDictionary *dict = @{@"tokenId":@"token"};
//            [self.httpRequest postURL:[appServer stringByAppendingString:@"/layout"] withParam:dict httpHeader:nil receiveTarget:@"layout"];
      [self.httpRequest getURL:appServer withUrl:@"layout" withParam:dict httpHeader:[Tools HttpHeader] receiveTarget:@"layout"];
//      [self.httpRequest getURL:[appServer stringByAppendingString:@"layout"] withParam:dict httpHeader:[Tools HttpHeader] receiveTarget:@"layout"];
      
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
