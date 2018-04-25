//
//  LoginViewController.m
//  dsdl
//
//  Created by 廉英雷 on 16/11/21.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import "LoginViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "MainViewController.h"
#import "NSString+Category.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;


@property (weak, nonatomic) IBOutlet UIButton *openBtn;

@property (strong, nonatomic)  UITextField *userName1;
@property (strong, nonatomic)  UITextField *password1;
@property (strong, nonatomic)  UIButton *loginBtn1;

@end

@implementation LoginViewController
- (IBAction)openBtn:(UIButton *)sender {
      if (self.password.secureTextEntry) {
            [sender setImage:[UIImage imageNamed:@"open.png"] forState:UIControlStateNormal];
            self.password.secureTextEntry = NO;
            
      }else{
      
            [sender setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
            self.password.secureTextEntry = YES;
           

      }
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
      
      
      UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _width, _height)];
      [self.view addSubview:imgView];
     // imgView.backgroundColor = [UIColor redColor];
      imgView.image = [UIImage imageNamed:@"backImage.png"];
      imgView.contentMode =UIViewContentModeScaleAspectFill;
     
      [self.view sendSubviewToBack:imgView];
      [self touchs];
      
}


- (void)creatView{
      
      UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
      [self.view addSubview:imgView];
      imgView.image = [UIImage imageNamed:@"backColor"];
      imgView.userInteractionEnabled = YES;
      
      UIImageView *headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(_width*0.5 -75, 55, 150, 103)];
      [imgView addSubview:headImgView];
      headImgView.image = [UIImage imageNamed:@"heag.png"];
      
      UIImageView *leftImgView = [[UIImageView alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(headImgView.frame)+60, 30, 30)];
      [imgView addSubview:leftImgView];
      leftImgView.image = [UIImage imageNamed:@"gonghao.png"];
      
      self.userName1 = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftImgView.frame)+5, CGRectGetMaxY(headImgView.frame)+60, _width -90, 40)];
      [imgView addSubview:self.userName1];
      
      self.userName1.font = [UIFont systemFontOfSize:14];
      self.userName1.placeholder = @"请输入工号";
      self.userName1.clearButtonMode = UITextFieldViewModeWhileEditing;
      self.userName1.borderStyle = UITextBorderStyleNone;
      self.userName1.textAlignment = NSTextAlignmentLeft;
      

      
      UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxX(self.userName1.frame)+5, _width-40, 1)];
      lineView1.backgroundColor = kUIColorFromRGB(0xE5E5E5);
      [imgView addSubview:lineView1];
      
      
      
      
      UIImageView *leftImgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(lineView1.frame)+20, 30, 30)];
      [imgView addSubview:leftImgView2];
      leftImgView.image = [UIImage imageNamed:@"mima.png"];
      
      self.password1 = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftImgView.frame)+5, CGRectGetMaxY(headImgView.frame)+60, _width -120, 40)];
      [imgView addSubview:self.password1];
      
      self.password1.font = [UIFont systemFontOfSize:14];
      self.password1.placeholder = @"请输入密码";
      self.password1.textAlignment = NSTextAlignmentLeft;
      self.password1.borderStyle = UITextBorderStyleNone;
      
      UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.password1.frame), self.password1.y, 30, 30)];
      [imgView addSubview:rightBtn];
      [rightBtn setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
      
      UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(20, 20, _width-40, 1)];
      lineView2.backgroundColor = kUIColorFromRGB(0xE5E5E5);
      [imgView addSubview:lineView2];
      
      UIButton *loginBnt = [[UIButton alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(lineView2.frame)+55, _width - 60, 44)];
      [imgView addSubview:loginBnt];
      loginBnt.backgroundColor = kUIColorFromRGB(0x11adea);
      
      [loginBnt setTitle:@"登录" forState:UIControlStateNormal];
      [loginBnt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
      loginBnt.titleLabel.font = [UIFont systemFontOfSize:16];
      loginBnt.layer.cornerRadius = 5;
      loginBnt.layer.masksToBounds = YES;
      
      UIImageView *footImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 276, 265)];
      [imgView addSubview:footImgView];
      footImgView.image = [UIImage imageNamed:@"fadian.png"];
      
      
      
      
      
}

- (void)customNavigationBar{

      self.loginBtn.layer.cornerRadius = 5;
      self.loginBtn.layer.masksToBounds = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//指纹识别
- (void)touchs{
      
      NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"tokenId"];
      if (str.length >0) {
      if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
            // 支持指纹识别
            LAContext* context = [[LAContext alloc] init];
            if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil]) {
                  // 指纹识别可用
                  [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                          localizedReason:@"请使用指纹登陆"
                                    reply:^(BOOL success, NSError* error) {
                                          if (success) {
                                                
                                                NSLog(@"识别成功");
                                                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                                      //用户选择其他验证方式，切换主线程处理
                                                      MainViewController *mainVC = [MainViewController shareMainViewController];
                                                      
                                                      UIWindow *window = [UIApplication sharedApplication].keyWindow;
                                                      [window makeKeyAndVisible];
                                                      window.rootViewController = mainVC;
                                                }];
                                                
                                              
                                                
                                          }
                                          else {
                                                if (error.code == kLAErrorUserFallback) {
                                                      NSLog(@"用户点击了输入密码");
                                                      [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                                             [self showTipView:@"用户点击了输入密码"];
                                                      }];
                                                     
                                                }
                                                else if (error.code == kLAErrorUserCancel) {
                                                      NSLog(@"用户点击了取消");
                                                }
                                                else {
                                                      [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                                             [[Tools shareTools] showAlertWithText:@"识别失败"];
                                                      }];
                                                      
                                                     
                                                      NSLog(@"识别失败");
                                                }
                                          }
                                          
                                    }];
            }
      }
      
      }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

      [self.view endEditing:YES];
}
//输入格式是否正确
- (BOOL)isValide{
      
      
      if(!self.userName.text ||self.userName.text.length == 0){
            
            [self showTipView:@"账号不能为空"];
            
            return NO;
            
      }else  if (![self.userName.text isMobileNumber]) {
            
            [self showTipView:@"账号不正确"];
            return NO;
            
      }
      
      if(!self.password.text ||self.password.text.length == 0){
            
            [self showTipView:@"密码不能为空"];
            
            return NO;
            
      }else if (![self.password.text isPassword]){
            
            [self showTipView:@"密码错误"];
            
            return NO;
      }
      
      return YES;
}


- (IBAction)login:(UIButton *)sender {
      
      
//      MainViewController *mainVC = [MainViewController shareMainViewController];
//      
//      UIWindow *window = [UIApplication sharedApplication].keyWindow;
//      [window makeKeyAndVisible];
//      window.rootViewController = mainVC;
      
//      NSDictionary *dict = @{@"loginName":self.userName.text,@"password":self.password.text};
//     
//      NSDictionary *headDict = @{@"Version":kCurrentVersion,@"PhoneType":[Tools getModel],@"uniqueID":[Tools getUUID]};
//      NSLog(@"head-----%@",headDict);
//      [self.httpRequest postURL:[appServer stringByAppendingString:@"login"] withParam:dict httpHeader:headDict receiveTarget:@"login"];
      
      if ([self isValide]) {
//            NSDictionary *dict = @{@"loginName":self.userName.text,@"password":self.password.text};
            
//            [self.httpRequest postURL:@"http://192.168.1.161:8080/login" withParam:dict httpHeader:nil receiveTarget:@"login" ];

      }
    
      
      
}

- (void)successRequest:(id)data withSender:(NSString *)sender{

      if ([sender isEqualToString:@"login"]) {
            NSDictionary *dict = (NSDictionary *)data;
            NSString *str = dict[@"token"];
            NSLog(@"返回的token --- %@",str);
            [NSKeyedArchiver archiveRootObject:dict[@"token"] toFile:tokenIdFile];
            [[NSUserDefaults standardUserDefaults] setObject:dict[@"token"] forKey:@"tokenId"];
            [[NSUserDefaults standardUserDefaults] setObject:self.userName.text forKey:@"userName"];
            [[NSUserDefaults standardUserDefaults] setObject:self.password.text forKey:@"password"];
           
            [[NSUserDefaults standardUserDefaults] synchronize];

            MainViewController *mainVC = [MainViewController shareMainViewController];
            
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            [window makeKeyAndVisible];
            window.rootViewController = mainVC;
            
      }
}


/*
 #pragma mark - Navigation
 
 首页：首页由两部分构成，首页顶端为发电量、负荷率、综合厂用电率、供电煤耗组成；分别对应昨日数据与今日事实数据折线图对比。首页下部展示厂内1#机组及2#机组重要参数，包含有功功率、主汽压力、主汽温度、再热文档、给水温度、真空、排烟温度、氧量、锅炉热效率和汽机热耗。
 指标：关键指标，包含发电量、供电量。厂用电指标，包含综合厂用电量和综合厂用电率。煤耗指标，包含发电标准煤耗、供电标准煤耗。机组稳定性指标，包含机组运行时间、机组利用小时、平均负荷、负荷率、背压。供热指标，包含供热量。机组性能指标，包含气机热耗、发电煤耗、供电煤耗锅炉效率。环保指标，包含SOx、NOx、烟尘、脱硫效率、脱硝效率。机组性能指标，包含汽机热耗、发电煤耗、供电煤耗、锅炉效率。
 值机长日志：从EAM系统通过接口获取每日值长、机长日志，提供移动端及时查询展示功能。
 我的信息：个人信息、代办信息，代办信息仅介入EAM系统物资审批指定节点审批
 
 
 编号	阶段任务名称	开始日期	结束日期	备注
 1.		现场调研
 2.		初步技术方案
 3.		合同签订
 4.		详细设计（含通讯软件开发、人机界面开发）
 5.		接口调试
 6.		人机界面调试1
 7.		初步验收


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
