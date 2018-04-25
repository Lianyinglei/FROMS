//
//  LoginViewCon.m
//  dsdl
//
//  Created by 廉英雷 on 16/12/9.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import "LoginViewCon.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "MainViewController.h"
#import "NSString+Category.h"

@interface LoginViewCon ()<UITextFieldDelegate>

@property (strong, nonatomic)  UITextField *userName;
@property (strong, nonatomic)  UITextField *password;
@property (strong, nonatomic)  UIButton *loginBtn;

@end

@implementation LoginViewCon

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
      [self creatView];
       [self touchs];
     
}

- (void)viewWillAppear:(BOOL)animated{

      [super viewWillAppear:animated];
      
}

- (void)creatView{
      self.view.backgroundColor = kUIColorFromRGB(0x0b2532);

      UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _width, _height-20)];
      [self.view addSubview:imgView];
      imgView.image = [UIImage imageNamed:@"backImage"];
      imgView.userInteractionEnabled = YES;
      
      UIImageView *headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(_width*0.5 -43, 124, 86, 86)];
      [imgView addSubview:headImgView];
      headImgView.image = [UIImage imageNamed:@"head-2.png"];
//
//      UIImageView *leftImgView = [[UIImageView alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(headImgView.frame)+60, 30, 30)];
//      [imgView addSubview:leftImgView];
//      leftImgView.image = [UIImage imageNamed:@"gonghao.png"];
      
      UITextField *searchFile = [[UITextField alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(headImgView.frame)+43, _width - 100, 40)];
      [imgView addSubview:searchFile];
      self.userName = searchFile;
     // [self.navigationController.navigationBar addSubview:searchFile];
      searchFile.backgroundColor = [UIColor whiteColor];
      // self.searchFile = searchFile;
      searchFile.delegate = self;
      //   searchFile.background = [UIImage imageNamed:@"textfield-bg"];
//      searchFile.layer.cornerRadius = 5;
//      searchFile.layer.masksToBounds = YES;
      
      searchFile.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
      searchFile.returnKeyType = UIReturnKeyGoogle;
      
      searchFile.placeholder = @"请输入工号";
      [searchFile setValue:kUIColorFromRGB(0x7f7f7f) forKeyPath:@"_placeholderLabel.textColor"];
      [searchFile setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
      
       // [[NSUserDefaults standardUserDefaults] setObject:self.userName.text forKey:@"userName"];
      
      NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
      if (name.length >0) {
            self.userName.text = name;
      }
      
      searchFile.leftViewMode = UITextFieldViewModeAlways;
      UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
      UIImageView *leftImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 24, 24)];
      [leftView addSubview:leftImg];
      searchFile.leftView.frame = CGRectMake(10, 20, 24, 24);
      leftImg.image = [UIImage imageNamed:@"layer"];
      searchFile.leftView = leftView;
      
      
      
      UITextField *searchFile2 = [[UITextField alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(searchFile.frame)+5, _width - 100, 40)];
      [imgView addSubview:searchFile2];
      self.password = searchFile2;
      // [self.navigationController.navigationBar addSubview:searchFile];
      searchFile2.backgroundColor = [UIColor whiteColor];
      // self.searchFile = searchFile;
     searchFile2.delegate = self;
      //   searchFile.background = [UIImage imageNamed:@"textfield-bg"];
//      searchFile2.layer.cornerRadius = 5;
//     searchFile2.layer.masksToBounds = YES;
      
      searchFile2.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
      searchFile2.returnKeyType = UIReturnKeyGoogle;
      searchFile2.secureTextEntry = YES;
      
      searchFile2.placeholder = @"请输入密码";
      [searchFile2 setValue:kUIColorFromRGB(0x7f7f7f) forKeyPath:@"_placeholderLabel.textColor"];
      [searchFile2 setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
      
      searchFile2.leftViewMode = UITextFieldViewModeAlways;
      UIView *leftView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
      UIImageView *leftImg2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 24, 24)];
      [leftView2 addSubview:leftImg2];
      searchFile2.leftView.frame = CGRectMake(10, 20, 24, 24);
      leftImg2.image = [UIImage imageNamed:@"layer2.png"];
      searchFile2.leftView = leftView2;
      
      
      UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(searchFile2.frame)+15, _width - 100, 33)];
      [imgView addSubview:loginBtn];
      self.loginBtn = loginBtn;
      
      [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
      [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
      loginBtn.backgroundColor =kUIColorFromRGB(0x033853);
      loginBtn.layer.cornerRadius = 15;
      loginBtn.layer.masksToBounds = YES;
      [loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];


}

//指纹识别
- (void)touchs{
      
            NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"tokenId"];
      NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
      NSString *passWord = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
            if (str.length >0 && name.length >0 && passWord.length >0) {
      
      
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
                                                      
                                                      
                                                      
                                                      NSDictionary *dict = @{@"loginName":name ,@"password":passWord};
                                                      
                                                      NSDictionary *headDict = @{@"Version":kCurrentVersion,@"PhoneType":[Tools getModel],@"uniqueID":[Tools getUUID]};
                                                      //  NSLog(@"head-----%@",headDict);
                                                      
                                                      [self.httpRequest postURL:appServer withUrl:@"login" withParam:dict httpHeader:headDict receiveTarget:@"TouchLogin"];
                                                     
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


- (void)login:(UIButton *)sender {
      
      if (isTest) {
            
            
                  MainViewController *mainVC = [MainViewController shareMainViewController];
            
                  UIWindow *window = [UIApplication sharedApplication].keyWindow;
                  [window makeKeyAndVisible];
                  window.rootViewController = mainVC;

      }else{
      
      
            NSDictionary *dict = @{@"loginName":self.userName.text,@"password":self.password.text};
            
            NSDictionary *headDict = @{@"Version":kCurrentVersion,@"PhoneType":[Tools getModel],@"uniqueID":[Tools getUUID]};
          //  NSLog(@"head-----%@",headDict);
           
            [self.httpRequest postURL:appServer withUrl:@"login" withParam:dict httpHeader:headDict receiveTarget:@"login"];
//            [self.httpRequest postURL:[appServer stringByAppendingString:@"login"] withParam:dict httpHeader:headDict receiveTarget:@"login"];
      }
      
      
      
//            if ([self isValide]) {
//                  NSDictionary *dict = @{@"loginName":self.userName.text,@"password":self.password.text};
//      
//                  [self.httpRequest postURL:@"http://192.168.1.161:8080/login" withParam:dict httpHeader:nil receiveTarget:@"login" ];
//      
//            }
      
      
      
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
            
            NSString *time = [Tools getNowDate];
            
            [[NSUserDefaults standardUserDefaults] setObject:time forKey:@"TIME"];
            
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            MainViewController *mainVC = [[MainViewController alloc] init];
            
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            [window makeKeyAndVisible];
            window.rootViewController = mainVC;
            
          
            
      }
      
      if ([sender isEqualToString:@"TouchLogin"]) {
            
            NSDictionary *dict = (NSDictionary *)data;
            NSString *str = dict[@"token"];
            NSLog(@"返回的token --- %@",str);
            [NSKeyedArchiver archiveRootObject:dict[@"token"] toFile:tokenIdFile];
            [[NSUserDefaults standardUserDefaults] setObject:dict[@"token"] forKey:@"tokenId"];
            
            
//            [[NSUserDefaults standardUserDefaults] setObject:self.userName.text forKey:@"userName"];
//            [[NSUserDefaults standardUserDefaults] setObject:self.password.text forKey:@"password"];
            
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            MainViewController *mainVC = [[MainViewController alloc] init];
            
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            [window makeKeyAndVisible];
            window.rootViewController = mainVC;
            
      }
}

- (void)errorRequest:(id)data withSender:(NSString *)sender{

      if ([sender isEqualToString:@"login"]) {
            
            NSDictionary *dict = (NSDictionary *)data;
            [self showTipView:dict[@"message"]];
      }
}

- (void)netFailedWithError:(NSError *)error{

      NSString *str = [error localizedDescription];
      NSLog(@"报错信息netFail-----%@",str);


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
