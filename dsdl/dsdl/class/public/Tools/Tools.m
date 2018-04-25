//
//  Tools.m
//  POS
//
//  Created by 廉英雷 on 15/9/24.
//  Copyright © 2015年 廉英雷. All rights reserved.
//

#import "Tools.h"
#import "Reachability.h"
#import "UIDevice-Reachability.h"
#import "loadView.h"
#import "MBProgressHUD.h"
#import "sys/utsname.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#import <CommonCrypto/CommonDigest.h>
#import <Accelerate/Accelerate.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <ifaddrs.h> 
#import <arpa/inet.h>
#define  _height  [[UIScreen mainScreen] bounds].size.height

#define  _width   [[UIScreen mainScreen] bounds].size.width
@class MBProgressHUD;
@interface Tools ()

@property(nonatomic,strong)loadView * myLoadView;

@property (nonatomic, strong) MBProgressHUD  *hud;
@end

@implementation Tools

+(instancetype)shareTools;
{
      static Tools * tool;
      static dispatch_once_t tocken;
      dispatch_once(&tocken, ^{
            tool=[[Tools alloc]init];
      });
      return tool;
}




+ (BOOL)isNet{
      if (![UIDevice networkAvailable]){
      
            return NO;
      }else{
      
            return YES;
      }

}
+(NSString *)getUUID;
{
      NSUUID * uuid=[[UIDevice currentDevice] identifierForVendor];
      return [uuid UUIDString];
}
+(NSString *)getVersion
{
      NSString * version=[[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
      return version;
}

+ (float)getSystemVersion
{
      return [[[UIDevice currentDevice] systemVersion] floatValue];
      
}

+(NSString *)getModel{
      size_t size;
      sysctlbyname("hw.machine", NULL, &size, NULL, 0);
      char *machine = (char*)malloc(size);
      sysctlbyname("hw.machine", machine, &size, NULL, 0);
      NSString *deviceString = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
      
//      NSLog(@"设备编号-----%@",deviceString);
      NSString *iPhoneModel = @"";
      if ([deviceString isEqualToString:@"iPhone1,1"])    iPhoneModel = @"iPhone 1G";
      if ([deviceString isEqualToString:@"iPhone1,2"])    iPhoneModel = @"iPhone 3G";
      if ([deviceString isEqualToString:@"iPhone2,1"])    iPhoneModel = @"iPhone 3GS";
      if ([deviceString isEqualToString:@"iPhone3,1"])    iPhoneModel = @"iPhone 4";
      if ([deviceString isEqualToString:@"iPhone3,2"])    iPhoneModel = @"Verizon iPhone 4";
      if ([deviceString isEqualToString:@"iPhone4,1"])    iPhoneModel = @"iPhone 4S";
      if ([deviceString isEqualToString:@"iPhone5,2"])    iPhoneModel = @"iPhone 5";
      if ([deviceString isEqualToString:@"iPhone6,2"])    iPhoneModel = @"iPhone 5S";
      if ([deviceString isEqualToString:@"iPhone7,2"])    iPhoneModel = @"iphone 6";
      if ([deviceString isEqualToString:@"iPhone8,2"])    iPhoneModel = @"iPhone 6s";
      if ([deviceString isEqualToString:@"iPhone9,2"]) {
            iPhoneModel = @"iPhone 7";
      }if ([deviceString isEqualToString:@"iphone10,2"]) {
            iPhoneModel = @"iPhone 7s";
      }
      
      return iPhoneModel;
}

+ (NSString *) getDeviceType
{
      struct utsname systemInfo;
      uname(&systemInfo);
      NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
      //    NSBundle *bundle = [NSBundle mainBundle];
      //    NSString *path = [bundle pathForResource:@"DeviceTypeList" ofType:@"plist"];
      //    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
      
      //    NSString *newString = deviceString;
      //    if ([dic objectForKey:deviceString]) {
      //        newString = [dic objectForKey:deviceString];
      //    }
      
      return deviceString;
}


- (void)alert:(NSString *)title :(NSString *)text{
      NSMutableString * contentString=[[NSMutableString alloc]initWithString:title];
      if (text) {
            [contentString appendFormat:@"\n%@",text];
      }
      [SVProgressHUD showSuccessWithStatus:contentString];
}
//8.7 添加提示信息，几秒钟后自动消失
- (void)showAlertWithText:(NSString *)text
{

      UIFont *font = [UIFont systemFontOfSize:14];
      
      UILabel * label=[[UILabel alloc] init];
      // label.backgroundColor=[UIColor colorWithWhite:0.377 alpha:0.300];
      label.backgroundColor = [UIColor blackColor];
      label.text=text;
      label.textAlignment=NSTextAlignmentCenter;
      label.font=font;
      label.layer.cornerRadius=10;
      label.clipsToBounds=YES;
      label.alpha=0;
      label.textColor = [UIColor whiteColor];
     
      label.frame = CGRectMake(0, 0, [text sizeWithAttributes:@{NSFontAttributeName:font}].width+60, 40);
      label.center=CGPointMake(_width*0.5, _height*0.4);  
      
      UIWindow * window=[[UIApplication sharedApplication] keyWindow];
      [window addSubview:label];
      
      
      [UIView animateWithDuration:0.5 animations:^{
            label.alpha=1;
      } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:2.0 delay:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
                  label.alpha=0;
            } completion:^(BOOL finished) {
                  [label removeFromSuperview];
            }];
            
      }];
}

/**
 * 校验银行账号（16位|19位数字）
 */
+(BOOL)isAccountNo:(NSString *)text;
{
      NSString* regex = @"^([0-9]{16}|[0-9]{19})$";
      NSPredicate* pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
      return [pred evaluateWithObject:text];
}

+ (BOOL) allNumber:(NSString *) text
{
      NSString* regex = @"^\\+?[1-9][0-9]*$";
      NSPredicate* pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
      return [pred evaluateWithObject:text];
}

+(BOOL)isPassword:(NSString*)text{//密码由6--16位字母和数字组成，不含空格
      /*
       ^[[0-9]|[a-z,A-Z]]{6,16}$
       */
      NSString* regex = @"^(?![0-9]{1,8}$)[\\S]{6,16}$";
      NSPredicate* pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
      
      if ([pred evaluateWithObject:text])
      {
            if ([self allNumber:text]) {
                  return NO;
            }
            if ([text rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"0123456789"]].location==NSNotFound) {
                  return NO;
            }
            return YES;
            
      }
      return NO;
      
}

//判断是不是验证码
+(BOOL)isAuthCode:(NSString *)authCode{
      NSString *regex = @"^\\d{4}$";
      NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];

      return [pred evaluateWithObject:authCode];
}
+(BOOL)stringIsMobile:(NSString *)mobil;
{
      //手机号以13， 15，18开头，八个 \d 数字字符 @"^1[3|4|5|7|8][0-9]{9}$"   @"^(1）\\d{10}$"
      NSString *phoneRegex = @"^1[3|4|5|7|8][0-9]{9}$";
      NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
      return [phoneTest evaluateWithObject:mobil];
}

+(BOOL)isEmail:(NSString*)text{
      //    NSString* regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
      NSString* regex = @"^[0-9a-z_][-_\\.0-9a-z-]{0,63}@([0-9a-z][0-9a-z-]*\\.)+[a-z]{2,4}$";
      NSPredicate* pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
      return [pred evaluateWithObject:text];
}

+(NSMutableAttributedString *)underLineString:(NSString *)stirng;
{
      NSMutableAttributedString * attributedString=[[NSMutableAttributedString alloc]initWithString:stirng];
      
      [attributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, stirng.length)];
      
      return attributedString;
      
}

#pragma mark----httpHeader


+(NSDictionary *)checkHttpHeader;
{
      NSDictionary * dict=@{@"Accept": [NSString stringWithFormat:@"application/vnd.ehking.kaptcha-v%@+json",[Tools getVersion]],
                            @"Content-type": [NSString stringWithFormat:@"application/vnd.ehking.kaptcha-v%@+json",[Tools getVersion]], //POST/PUT提交必选
                            @"User-Agent":[NSString stringWithFormat:@"IOS-Pos-v%@",[Tools getVersion]]};
      return dict;
}

+(NSDictionary *)vipHttpHeader;
{
      NSDictionary * dict=@{@"Accept": [NSString stringWithFormat:@"application/vnd.ehking.member-v%@+json",[Tools getVersion]],
                            @"Content-type": [NSString stringWithFormat:@"application/vnd.ehking.member-v%@+json",[Tools getVersion]], //POST/PUT提交必选
                            @"User-Agent":[NSString stringWithFormat:@"IOS-Pos-v%@",[Tools getVersion]]};
      return dict;
}

+(NSDictionary *)LoginHttpHeader{

      NSDictionary * dict=@{@"Accept": [NSString stringWithFormat:@"application/vnd.ehking.cas-v%@+json",[Tools getVersion]],
                            @"Content-type": [NSString stringWithFormat:@"application/vnd.ehking.cas-v%@+json",[Tools getVersion]], //POST/PUT提交必选
                            @"User-Agent":[NSString stringWithFormat:@"IOS-Pos-v%@",[Tools getVersion]]};
      return dict;


}

+(NSDictionary *)HttpHeader{

      NSDictionary *dict = @{@"Version":kCurrentVersion,@"PhoneType":[Tools getModel],@"uniqueID":[Tools getUUID],@"token":TOKENID};
      return dict;
}

+ (NSString *)getNumberTwo:(NSString *)numStr{
      
//      numStr = @"1.234";
      
//      if ([numStr containsString:@"E"]) {
//            
////            NSString *str = @"-1.2808245E7";
//            NSRange eSite = [numStr rangeOfString:@"E"];
//            double fund = [[numStr substringWithRange:NSMakeRange(0, eSite.location)] doubleValue];  //把E前面的数截取下来当底数
//            double top = [[numStr substringFromIndex:eSite.location+2 ] doubleValue];   //把E后面的数截取下来当指数
//            double result = fund * pow(10.0, top);
//            NSLog(@"result:%f",result);
//          
//            CGFloat num = result *100;
//            
//            NSInteger numInt =(NSInteger) num;
//            
//            CGFloat numFloat = numInt/100.0;
//            
//            NSString *str = [NSString stringWithFormat:@"%f",numFloat];
//            
//            
//            return str;
//
//           // numStr = [NSString stringWithFormat:@"%e",result];
//      }
//     

      CGFloat num = [numStr floatValue] *100;
      
      NSInteger numInt = num;
      
      CGFloat numFloat = numInt/100.0;
      
      NSString *str = [NSString stringWithFormat:@"%g",numFloat];
     
      
      return str;
}
#pragma mark-----
-(void)startLoadingWithText:(NSString *)text;
{
      
      if (![UIDevice networkAvailable])
      {
            
            [[Tools shareTools] alert:@"网络请求失败" :@"请检查手机网络设置."];
            
            return;//如果没网，不出现加载框
            //        [[Tools shareTools] stopLoading];
      }
      
      
      if (!self.myLoadView) {
            self.myLoadView=[[loadView alloc]initWithFrame:CGRectMake(0, 0, _width, _height)];
      }
      
      self.myLoadView.frame=CGRectMake(0, 0, _width, _height);
      UIWindow * window=[[UIApplication sharedApplication] keyWindow];
      [window addSubview:self.myLoadView];
      [self.myLoadView startLoadWithTitle:text];
}
-(void)stopLoading;
{
      [self.myLoadView stopLoading];
      self.myLoadView.frame=CGRectMake(0, _height, _width, _height);
      
}

//+ (char *)UTF8_To_GB2312:(NSString*)utf8string
//{
//      NSStringEncoding encoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//      const char *gb2312 = [utf8string cStringUsingEncoding:encoding];
//      
//      return  gb2312;
//}

-(void)showHUD:(NSString *)title afterTime:(double)seconds failStr:(NSString *)str{
      
   //   self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
      self.hud.labelText = title;
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            
            if (_hud) {
                  [_hud hide:YES];
                  _hud = nil;
                  [self showTipView:str];
            }
      });
      
      
}

- (void)showTipView:(NSString *)tip{


}
- (void)showHUDDelayHid:(NSString *)title {
    //  self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
      self.hud.labelText = title;
      
      [self performSelector:@selector(hideHUD) withObject:nil afterDelay:1];
}

//隐藏加载
- (void)hideHUD {
      if (_hud) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                  [_hud hide:YES];
                  _hud = nil;
            });
      }
      
      //[self.hud hide:YES];
      
}

//隐藏加载显示加载完成提示
- (void)hideHUDWithTitle:(NSString *)title
{
      self.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
      
      self.hud.mode = MBProgressHUDModeCustomView;
      
      self.hud.labelText = title;
      [self.hud hide:YES afterDelay:1];
      
}

- (void)dateTime{
      //实例化一个NSDateFormatter对象
      NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
      dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
      //设定时间格式,这里可以设置成自己需要的格式
      [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
      //用[NSDate date]可以获取系统当前时间
      NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
      
      NSLog(@"原来的-----%@",currentDateStr);
      //得到原日期和国际时间的偏移量
      NSDate *race = [dateFormatter dateFromString:currentDateStr];
      NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
      NSInteger sender = [timeZone secondsFromGMTForDate:race];
      NSDate *datetime = [race dateByAddingTimeInterval:sender];
      
      NSString *dateStr = [dateFormatter stringFromDate:datetime];
      NSLog(@"时间----%@",dateStr);
      
      NSLog(@"zuizhong的-----%@",currentDateStr);
   
      //输出格式为：2010-10-27 10:22:13
      
}

- (UIImage *)headerImage{
      
      NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask , YES)lastObject];
      path = [path stringByAppendingPathComponent:@"headImage.png"];
      NSData *imgDate = [NSData dataWithContentsOfFile:path];
      UIImage *img = [UIImage imageWithData:imgDate];
      return img;
}

//+ (NSString *)md5:(NSString *)str
//{
//      const char *cStr = [str UTF8String];
//      unsigned char result[32];
//      CC_MD5( cStr, (int)strlen(cStr), result );
//      
//      return [NSString stringWithFormat:
//              @"%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x",
//              result[0],result[1],result[2],result[3],
//              result[4],result[5],result[6],result[7],
//              result[8],result[9],result[10],result[11],
//              result[12],result[13],result[14],result[15],
//              result[16], result[17],result[18], result[19],
//              result[20], result[21],result[22], result[23],
//              result[24], result[25],result[26], result[27],
//              result[28], result[29],result[30], result[31]
//              ];
//}

+(NSString *) md5: (NSString *) inPutText
{
      const char *cStr = [inPutText UTF8String];
      unsigned char result[CC_MD5_DIGEST_LENGTH];
      CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
      
      return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
               result[0], result[1], result[2], result[3],
               result[4], result[5], result[6], result[7],
               result[8], result[9], result[10], result[11],
               result[12], result[13], result[14], result[15]
               ] lowercaseString];
}

//判断手机号
+ (BOOL)isMobileNumber:(NSString *)mobileNum {
      //移动号段正则表达式
      NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
      //联通号段正则表达式
      NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
      //电信号段正则表达式
      NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
      
      NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
      BOOL isMatch1 = [pred1 evaluateWithObject:mobileNum];
      NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
      BOOL isMatch2 = [pred2 evaluateWithObject:mobileNum];
      NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
      BOOL isMatch3 = [pred3 evaluateWithObject:mobileNum];
      
      if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
      }else{
            return NO;
      }
}

+ (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur {
      if (blur < 0.f || blur > 1.f) {
            blur = 0.5f;
      }
      int boxSize = (int)(blur * 100);
      boxSize = boxSize - (boxSize % 2) + 1;
      
      CGImageRef img = image.CGImage;
      
      vImage_Buffer inBuffer, outBuffer;
      vImage_Error error;
      
      void *pixelBuffer;
      
      CGDataProviderRef inProvider = CGImageGetDataProvider(img);
      CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
      
      inBuffer.width = CGImageGetWidth(img);
      inBuffer.height = CGImageGetHeight(img);
      inBuffer.rowBytes = CGImageGetBytesPerRow(img);
      
      inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
      
      pixelBuffer = malloc(CGImageGetBytesPerRow(img) *
                           CGImageGetHeight(img));
      
      if(pixelBuffer == NULL)
            NSLog(@"No pixelbuffer");
      
      outBuffer.data = pixelBuffer;
      outBuffer.width = CGImageGetWidth(img);
      outBuffer.height = CGImageGetHeight(img);
      outBuffer.rowBytes = CGImageGetBytesPerRow(img);
      
      error = vImageBoxConvolve_ARGB8888(&inBuffer,
                                         &outBuffer,
                                         NULL,
                                         0,
                                         0,
                                         boxSize,
                                         boxSize,
                                         NULL,
                                         kvImageEdgeExtend);
      
      
      if (error) {
            NSLog(@"error from convolution %ld", error);
      }
      
      CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
      CGContextRef ctx = CGBitmapContextCreate(
                                               outBuffer.data,
                                               outBuffer.width,
                                               outBuffer.height,
                                               8,
                                               outBuffer.rowBytes,
                                               colorSpace,
                                               kCGBitmapAlphaInfoMask & kCGImageAlphaNoneSkipLast);
      CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
      UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
      
      //clean up
      CGContextRelease(ctx);
      CGColorSpaceRelease(colorSpace);
      
      free(pixelBuffer);
      CFRelease(inBitmapData);
      
      CGColorSpaceRelease(colorSpace);
      CGImageRelease(imageRef);
      
      return returnImage;
}

- (NSString *)getWifiName
{
      NSString *wifiName = @"Not Found";
      
      CFArrayRef myArray = CNCopySupportedInterfaces();
      
      if (myArray != nil) {
            
            CFDictionaryRef myDict =CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
            
            if (myDict != nil) {
                  
                  NSDictionary *dict = (NSDictionary*)CFBridgingRelease(myDict);
                  
                  wifiName = [dict valueForKey:@"SSID"];
                  
            }
      }
      return wifiName;
}
      
//获取WIFIIP的方法
- (NSString *)getIPAddress
{
      NSString *address = @"error";
      struct ifaddrs *interfaces = NULL;
      struct ifaddrs *temp_addr = NULL;
      int success = 0;
      
      // retrieve the current interfaces - returns 0 on success
      success = getifaddrs(&interfaces);
      if (success == 0) {
            // Loop through linked list of interfaces
            temp_addr = interfaces;
            while (temp_addr != NULL) {
                  if( temp_addr->ifa_addr->sa_family == AF_INET) {
                        // Check if interface is en0 which is the wifi connection on the iPhone
                        if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                              // Get NSString from C String
                              address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                        }
                  }
                  
                  temp_addr = temp_addr->ifa_next;
            }
      }
      
      // Free memory
      freeifaddrs(interfaces);
      
      return address;
}

+(NSString *)getNetWorkStates{
      UIApplication *app = [UIApplication sharedApplication];
      NSArray *children = [[[app valueForKeyPath:@"statusBar"]valueForKeyPath:@"foregroundView"]subviews];
      NSString *state = [[NSString alloc]init];
      int netType = 0;
      //获取到网络返回码
      for (id child in children) {
            if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
                  //获取到状态栏
                  netType = [[child valueForKeyPath:@"dataNetworkType"]intValue];
                  
                  switch (netType) {
                        case 0:
                              state = @"无网络";
                              //无网模式
                              break;
                        case 1:
                              state = @"2G";
                              break;
                        case 2:
                              state = @"3G";
                              break;
                        case 3:
                              state = @"4G";
                              break;
                        case 5:
                        {
                              state = @"WIFI";
                        }
                              break;
                        default:
                              break;
                  }
            }
      }
      //根据状态选择 
      return state; 
}

+(BOOL)isNetWork{

      if (![UIDevice networkAvailable])
      {
            
            [[Tools shareTools] alert:@"网络请求失败" :@"请检查手机网络设置."];
            
            
            return NO;
      }else{
      
            return YES;
      }

}

+ (NSString *)getNowDate{
      
      NSDate *date = [NSDate date];
      NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
      [formatter setTimeStyle:NSDateFormatterShortStyle];
      [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
      NSString *time = [formatter stringFromDate:date];
      return time;
}

@end
