//
//  Tools.h
//  POS
//
//  Created by 廉英雷 on 15/9/24.
//  Copyright © 2015年 廉英雷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tools : NSObject

+(instancetype)shareTools;

-(void)alert:(NSString *)title :(NSString *)text;


/**加载页*/
-(void)startLoadingWithText:(NSString *)text;
-(void)stopLoading;

/** 显示提示 */
- (void)showAlertWithText:(NSString *)text;
/**获取系统版本*/
+(NSString *)getVersion;

/**当前设备编号*/
+(NSString *)getUUID;

/**
 *  @brief 获取IOS系统版本号
 */
+ (float)getSystemVersion;

/**
 *  @brief 获取设备的类型，如：iPhone5S（联通)
 */
+ (NSString *) getDeviceType;

+(NSString *)getModel;


/**
 *  保留两位小数点，返回整数则为整数，返回小数保留2位小数
 *
 *  @param numStr <#numStr description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *) getNumberTwo:(NSString *)numStr;

/**字符串下划线*/
+(NSMutableAttributedString *)underLineString:(NSString *)stirng;
/**mobil是否是手机号*/
+(BOOL)stringIsMobile:(NSString *)mobil;
/**text是否是邮箱格式*/
+(BOOL)isEmail:(NSString*)text;
/**是否是有银行卡号*/
+(BOOL)isAccountNo:(NSString *)text;
/**是否验证码*/
+(BOOL)isAuthCode:(NSString *)authCode;


+(BOOL)isPassword:(NSString*)text;//密码由6--16位字母和数字组成

/**
 *  得到当前的日期
 *
 *  @return <#return value description#>
 */
+ (NSString *)getNowDate;


/**各种请求头*/
+(NSDictionary *)checkHttpHeader;
+(NSDictionary *)vipHttpHeader;
+(NSDictionary *)LoginHttpHeader;
+(NSDictionary *)HttpHeader;


//+ (char *)UTF8_To_GB2312:(NSString*)utf8string;

-(void)showHUD:(NSString *)title afterTime:(double)seconds failStr:(NSString *)str;

//隐藏加载
- (void)hideHUD;


- (void)showHUDDelayHid:(NSString *)title;


//隐藏加载显示加载完成提示
- (void)hideHUDWithTitle:(NSString *)title;

//显示提示
- (void)showTipView:(NSString *)tip;
- (void)dateTime;
/**取出缓存在本地的头像*/
- (UIImage *)headerImage;
//+ (NSString *)md5:(NSString *)str;
+(NSString *) md5: (NSString *) inPutText;

/**
 *  @brief image的毛玻璃效果
 *
 *  @param image 待处理的图片
 *  @param blur 效果区间 0.0-1.0
 *  @return 处理过的图片
 */
+ (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;


- (NSString *)getIPAddress;
- (NSString *)getWifiName;

+(NSString *)getNetWorkStates;

+(BOOL)isNetWork;
@end
