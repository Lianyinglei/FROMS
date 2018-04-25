//
//  MyselfViewController.m
//  dsdl
//
//  Created by 廉英雷 on 16/11/3.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import "MyselfViewController.h"
#import "HeaderMeView.h"
#import "AboutMeCell.h"
#import "LoginViewCon.h"
#import "SetViewController.h"
#import "CKAlertViewController.h"
#import "PhotosViewController.h"
#import "YLUser.h"
#import "MJExtension.h"

@interface MyselfViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) NSArray *aryCount;

@property(nonatomic,strong) NSArray *imageAry;

@property (nonatomic, weak) HeaderMeView *headView;
@end

@implementation MyselfViewController


- (void)viewWillAppear:(BOOL)animated{


      [super viewWillAppear:animated];
      
      self.tabBarController.tabBar.hidden  = NO;
}
- (void)customNavigationBar{
      
      [super customNavigationBar];
      UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
      lab.text = @"个人中心";
      lab.font = [UIFont systemFontOfSize:18];
      lab.textAlignment = NSTextAlignmentCenter;
      lab.textColor = [UIColor whiteColor];
      self.navigationItem.titleView = lab;
      
      //      UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"利润" style:UIBarButtonItemStyleDone target:self action:@selector(clickRightView)];
      //      self.navigationItem.rightBarButtonItem = item;
      
      
}


- (NSArray *)aryCount{
      
      if (!_aryCount) {
            
            _aryCount = [[NSArray alloc] init];
            _aryCount = @[@[@"",@""],@[@"版本号",@"检测更新"]];
      }
      return _aryCount;
}

- (NSArray *)imageAry{
      
      if (!_imageAry) {
            _imageAry = @[@[@"bm.png",@"gw.png"],@[@"bbh.png",@"jcgx.png"]];
      }
      return _imageAry;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
      self.view.backgroundColor = kUIColorFromRGB(0xf2f2f2);
      
      UITableView *tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _width,300) style:UITableViewStylePlain];
      [self.view addSubview:tabView];
      tabView.delegate = self;
      tabView.dataSource = self;
      self.tableView = tabView;
     
      self.tableView.showsHorizontalScrollIndicator = YES;
      self.tableView.backgroundColor = kUIColorFromRGB(0xf2f2f2);
      self.tableView.rowHeight = 44;
      self.tableView.scrollEnabled = NO;
      //self.tableView.y = -64;
      
      self.tableView.tableHeaderView = [self headerView];
      self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

      //   self.view.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.8];
     // [self headerView];
      [self exitView];
      
      [self getData];
}

- (void)getData{

      if (isTest) {
             self.aryCount = @[@[@"管理员",@"超级管理员"],@[@"版本号",@"检测更新"]];
             [self.tableView reloadData];
      }
      
      
      if (![Tools isNetWork]) {
            
            self.aryCount = @[@[@"",@""],@[@"版本号",@"检测更新"]];
            [self.tableView reloadData];
            
      }else{
      
//             [self.httpRequest getURL:appServer withUrl:@"userInfo/getUser" withParam:@{@"token" :TOKENID} httpHeader:[Tools HttpHeader] receiveTarget:@"getUser"];
      }
     

}


- (void)exitView{
      
//      UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(_width*0.5 -50, CGRectGetMaxY(self.tableView.frame)+40, 100, 100)];
//      [self.view addSubview:imgView];
//      imgView.image = [UIImage imageNamed:@"grxx_icon.png"];
      UIButton *bottomBtn = [[UIButton alloc] initWithFrame:CGRectMake(20,_height -214, _width - 40, 44)];
      [self.view addSubview:bottomBtn];
      bottomBtn.backgroundColor = kUIColorFromRGB(0xcccccc);
      [bottomBtn setTitle:@"退出当前账号" forState:UIControlStateNormal];
      [bottomBtn setTitleColor:kUIColorFromRGB(0x333333) forState:UIControlStateNormal];
      bottomBtn.titleLabel.font = [UIFont systemFontOfSize:18];
      bottomBtn.layer.cornerRadius = 5;
      bottomBtn.layer.masksToBounds = YES;
      bottomBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
      [bottomBtn addTarget:self action:@selector(exitAccount) forControlEvents:UIControlEventTouchUpInside];


}

- (void)exitAccount{
      
//     UIWindow *window = [UIApplication sharedApplication].keyWindow;
//      [window makeKeyAndVisible];
//      LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
//      window.rootViewController = loginVC;
//      NSDictionary *dict = @{@"tokenId":@"token"};
//      [self.httpRequest postURL:[appServer stringByAppendingString:@"/layout"] withParam:dict httpHeader:nil receiveTarget:@"layout"];

      if (!isTest) {
            NSDictionary *dict = @{@"tokenId":@"token"};
            //            [self.httpRequest postURL:[appServer stringByAppendingString:@"/layout"] withParam:dict httpHeader:nil receiveTarget:@"layout"];
            [self.httpRequest getURL:appServer withUrl:@"layout" withParam:dict httpHeader:[Tools HttpHeader] receiveTarget:@"layout"];
//            [self.httpRequest getURL:[appServer stringByAppendingString:@"layout"] withParam:dict httpHeader:[Tools HttpHeader] receiveTarget:@"layout"];
            
           
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            [window makeKeyAndVisible];
            LoginViewCon *loginVC = [[LoginViewCon alloc] init];
            // LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
            
            window.rootViewController = loginVC;

      }else{
      
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            [window makeKeyAndVisible];
            LoginViewCon *loginVC = [[LoginViewCon alloc] init];
            // LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
            
            window.rootViewController = loginVC;

      }
      
}

- (void)successRequest:(id)data withSender:(NSString *)sender{
      
      if ([sender isEqualToString:@"getUser"]) {
            
            NSDictionary *dict = (NSDictionary *)data;
            if ([data isKindOfClass:[NSNull class]]) {
                  self.aryCount = @[@[@"",@""],@[@"版本号",@"检测更新"]];
                 
            }else{
            
            YLUser *user = [YLUser mj_objectWithKeyValues:dict];
            
            self.headView.nameStr = user.name;
            
            self.headView.jobNumber = user.phone;
            
            self.aryCount = @[@[user.department,user.position],@[@"版本号",@"检测更新"]];
           
            }
             [self.tableView reloadData];
      }

      if ([sender isEqualToString:@"layout"]) {
            
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"tokenId"];
            //
            //            IndicatorViewController *indictorsVC = [[IndicatorViewController alloc] init];
            //
            //            [self.navigationController popToViewController:indictorsVC animated:NO];
            
            self.tabBarController.selectedIndex = 0;
            
            
//            UIWindow *window = [UIApplication sharedApplication].keyWindow;
//            [window makeKeyAndVisible];
//            LoginViewCon *loginVC = [[LoginViewCon alloc] init];
//            // LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
//            
//            window.rootViewController = loginVC;
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
                  
                  // CKAlertViewController *alertVC = [CKAlertViewController alertControllerWithTitle:@"发现新版本" message:@"1. 日夜赶工,修复了一堆bug.\n2. 跟着产品经理改来改去,增加了很多功能.\n3. 貌似性能提升了那么一点点." ];
                  
                  CKAlertViewController *alertVC = [CKAlertViewController alertControllerWithTitle:@"发现新版本" message:dict[@"UPITEMS"] ];
                  alertVC.messageAlignment = NSTextAlignmentLeft;
                  
                  //  __weak typeof(self)welfSelf = self;
                  CKAlertAction *cancel = [CKAlertAction actionWithTitle:@"稍后更新" handler:^(CKAlertAction *action) {
                        NSLog(@"点击了 %@ 按钮",action.title);
                  }];
                  
                  CKAlertAction *update = [CKAlertAction actionWithTitle:@"立即更新" handler:^(CKAlertAction *action) {
                        NSLog(@"点击了 %@ 按钮",action.title);
                        
                        [[UIApplication sharedApplication] openURL:
                         [NSURL URLWithString:dict[@"UPHTTPURL"]]];
                        
//                         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-services://?action=download-manifest&url=https://raw.githubusercontent.com/Lianyinglei/Me/master/szds.plist"]];
                        
                  }];
                  
                  [alertVC addAction:cancel];
                  [alertVC addAction:update];
                  
                  [self presentViewController:alertVC animated:NO completion:nil];
                  
                  
            }
            
      }

            //  [self showTipView:@"退出登录"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
      return 10;
}
- (UIView *)headerView{
      
      
      HeaderMeView *headerView = [[HeaderMeView alloc] initWithFrame:CGRectMake(0, 0, _width, 100)];
    //  headerView.backgroundColor = [UIColor colorWithRed:225/255.0 green:245/255.0 blue:254/255.0 alpha:1.0];
      headerView.backgroundColor = kUIColorFromRGB(0x1f9d85);
      
      self.headView = headerView;
      
      if ([self headerImage]) {
             self.headView.imgView.image = [self headerImage]; 
      }
    
      //增加点击事件
      UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerClcik)];
      [headerView addGestureRecognizer:tapGesture];

      
      return headerView;
    }

- (void)headerClcik{

      PhotosViewController *photoVC = [[PhotosViewController alloc] init];
      [self.navigationController pushViewController:photoVC animated:YES];
      
      __weak typeof(self) weakSelf = self;
      photoVC.photoVCBlock = ^(NSString *imgStr){
      
            weakSelf.headView.imgStr = imgStr;
      
      };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

      return self.aryCount.count;
     
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
      
      NSArray *ary = self.aryCount[section];
      return ary.count;
  
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
      
      static NSString *ID = @"cell";
      AboutMeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
      
      if (!cell) {
            
            cell = [[NSBundle mainBundle] loadNibNamed:@"AboutMeCell" owner:nil options:nil].lastObject;
            
            
      }
      cell.labdetial.hidden = YES;
      
      NSArray *ary = self.aryCount[indexPath.section];
      cell.cellLab.text =ary[indexPath.row];
      NSArray *imgAry = self.imageAry[indexPath.section];
      cell.imgView.image = [UIImage imageNamed:imgAry[indexPath.row]];
      
      cell.contentView.backgroundColor = [UIColor whiteColor];
      cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
      cell.selectionStyle = UITableViewCellSelectionStyleNone;
      cell.contentMode = UIViewContentModeScaleToFill;
      cell.accessoryType = UITableViewCellAccessoryNone;
      cell.lineView.hidden = YES;
      if (indexPath.row == 0) {
           // tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            cell.lineView.hidden = NO;
      }
      if (indexPath.section == 1 && indexPath.row == 0) {
            cell.labdetial.hidden = NO;
            cell.labdetial.text = [@"V" stringByAppendingString:[Tools getVersion]];
      }
      if (indexPath.section == 1 && indexPath.row == 1) {
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
      }
      
      //      UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _width, 80)];
      //      imgView.contentMode = UIViewContentModeScaleToFill;
      //     // imgView.image = [UIImage imageNamed:@"me1.png"];
      //      cell.selectedBackgroundView = imgView;
      
      return cell;
      
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

      if (!isTest) {
            if (indexPath.section == 1 && indexPath.row == 1) {
                  //            SetViewController *setVC = [[SetViewController alloc] init];
                  //            [self.navigationController pushViewController:setVC animated:YES];
                  
                  [self.httpRequest getURL:appServer withUrl:@"api/softUpdate/ios/getLatestVersion" withParam:nil httpHeader:[Tools HttpHeader] receiveTarget:@"getLatestVersion"];
//                  [self.httpRequest getURL:[appServer stringByAppendingString:@"api/softUpdate/ios/getLatestVersion"] withParam:nil httpHeader:[Tools HttpHeader] receiveTarget:@"getLatestVersion"];
            }

      }
      


}


- (UIImage *)headerImage{
      
      NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask , YES)lastObject];
      path = [path stringByAppendingPathComponent:@"headImage.png"];
      NSData *imgDate = [NSData dataWithContentsOfFile:path];
      UIImage *img = [UIImage imageWithData:imgDate];
      return img;
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
