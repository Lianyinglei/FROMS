//
//  SecretTool.h
//  framework
//
//  Created by yoxnet on 16/4/18.
//  Copyright © 2016年 yoxnet. All rights reserved.
//

#import <Foundation/Foundation.h>

/***********************************
 *
 *
 *  加密解密工具
 *  目前有RSA加密（https可调用该方法链接）
 *
 *
 *
 *********************************/
@interface SecretTool : NSObject

//提取出的身份
@property(nonatomic,assign) SecIdentityRef identity;

#pragma mark - RSA 加密/解密算法


+(instancetype)secretPublicKeyWithData:(NSData *)data;



/**
 *
 *  加载公钥
 *
 *  @param data 提取出来公钥二进制数据
 *
 *
 *************/

-(void)loadPublicKeyWithData:(NSData *)data;

/**
 *
 *  加载公钥
 *
 *  @param filePath DER 公钥文件路径
 *
 *
 *************/
- (void)loadPublicKeyWithDERFilePath:(NSString *)filePath;

/**
 *
 *
 *  加载私钥
 *
 *  @param filePath P12 私钥文件路径
 *
 *  @param password P12 密码
 *
 *
 ***********************************/


- (void)loadPrivateKey:(NSString *)filePath password:(NSString *)password;

/**
 *
 *  RSA 加密数据
 *
 *  @param data 要加密的数据
 *
 *  @return 加密后的二进制数据
 *
 *
 *
 *********************************/
- (NSData *)RSAEncryptData:(NSData *)data;


/**
 *
 *  RSA 解密数据
 *
 *  @param data 要解密的数据
 *
 *  @return 解密后的二进制数据
 *
 *
 ******************/
- (NSData *)RSADecryptData:(NSData *)data;






@end
