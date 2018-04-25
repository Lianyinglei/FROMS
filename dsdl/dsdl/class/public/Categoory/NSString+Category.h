//
//  NSString+Category.h
//  framework
//
//  Created by yoxnet on 16/3/31.
//  Copyright © 2016年 yoxnet. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SecretTool.h"

/**************************************
 *
 *
 *  为字符串扩展一些常用方法
 *
 *
 ********************/

@interface NSString (Security)


-(NSString *)to16MD5String;

-(NSString *)to32MD5String;

/**
 *
 *  RSA 加密字符串
 *
 *  @param tool 用来为字符串加密的对象
 *
 *  @return 加密后的 BASE64 编码字符串
 *
 *************************************/

- (NSString *)RSAEncryptStringWithSecretTool:(SecretTool *)tool;

/**
 *
 *  RSA 解密字符串
 *
 *  @param tool 用来解密的对象
 *
 *  @return 解密后的字符串
 *
 *
 **************************************************/

- (NSString *)RSADecryptStringWithSecretTool:(SecretTool *)tool;

@end


@interface NSString (Regular)


/**字符串中全部为数字*/
-(BOOL)isNumber;

/**以1开头的11位数字*/
-(BOOL)isMobileNumber;

/**6--16位数字和字母组合*/
-(BOOL)isPassword;

@end

@interface NSString(AutoSize)

- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;
- (CGSize)sizeWithFont:(UIFont *)font;


@end