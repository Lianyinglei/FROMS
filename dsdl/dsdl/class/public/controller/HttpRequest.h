//
//  HttpRequest.h
//  framework
//
//  Created by yoxnet on 16/3/28.
//  Copyright © 2016年 yoxnet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@protocol HttpRequestDelegate <NSObject>

/********************************
 *
 *      请求完成后的代理回调函数
 *
 *******************************/
@optional
-(void)successRequest:(id)data withSender:(NSString *)sender;

-(void)errorRequest:(id)data withSender:(NSString *)sender;

-(void) netFailedWithError:(NSError *)error;


@end


#define HttpRequestOutTime 10

@interface HttpRequest : NSObject

/************************************************
 *
 *  工程中所有网络请求的对外接口
 *  目前依赖于/Public/libs/AFNetworking 3.x开源库
 *
 ************************************************/

@property (weak, nonatomic) id<HttpRequestDelegate>delegate;

@property(strong,nonatomic)AFHTTPSessionManager *sessManager;

- (void) getURL:(NSString *) baseUrlStr withUrl:(NSString *)urlStr
 withParam:(id)data
     httpHeader:(NSDictionary *)httpHeader
  receiveTarget:(NSString *)sender;


- (void) postURL:(NSString *) baseUrlStr withUrl:(NSString *)urlStr
  withParam:(id)data
      httpHeader:(NSDictionary *)httpHeader
   receiveTarget:(NSString *)sender;

/** 上传图片的接口*/

- (void)postURL:(NSString *)url withData:(NSData *)dataImage withParam:(id)data httpHeader:(NSDictionary *)httpHeader receiveTarget:(NSString *)sender;


//上传图片接口
/***************************
 *
 *  images 上传图片的数组，会统一转成jpeg格式上传到服务器
 *  name    与后台保持一致，图片的数组名或者文件夹名，不能为nil
 *
 *
 ***************************/
-(void)postURL:(NSString *)url
     withParam:(id)data
  updateImages:(NSArray<UIImage *> *)images
    imagesName:(NSString *)name
    httpHeader:(NSDictionary *)httpHeader
 receiveTarget:(NSString *)sender;

@end
