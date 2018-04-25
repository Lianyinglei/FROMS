//
//  HttpRequest.m
//  framework
//
//  Created by yoxnet on 16/3/28.
//  Copyright © 2016年 yoxnet. All rights reserved.
//

#import "HttpRequest.h"
#define global_quque    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
 //宏定义主队列
 #define main_queue       dispatch_get_main_queue()
typedef void (^httpBlock)();

typedef void (^httpBlock2)();

@interface HttpRequest ()

@property(strong,nonatomic)NSString * urlString;

@property(strong,nonatomic)AFNetworkReachabilityManager * netManager;

@property (nonatomic, copy) NSString *urlStr;

@property (nonatomic, copy) httpBlock httpBlock;


@end


@implementation HttpRequest


-(instancetype)init
{
    if (self = [super init]) {
       
      _sessManager = [AFHTTPSessionManager manager];
        _sessManager.requestSerializer = [AFHTTPRequestSerializer serializer];
         
          
        AFJSONResponseSerializer * responseSerializer = [AFJSONResponseSerializer serializer];
//        responseSerializer.acceptableContentTypes = [responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
          
         responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
        _sessManager.responseSerializer = responseSerializer;
        _sessManager.requestSerializer.timeoutInterval = HttpRequestOutTime;
          
//AFJSONRequestSerializer *request = [AFJSONRequestSerializer serializer];
//          
//          _sessManager.requestSerializer = request;
     
         
          
          
        //安全一些配置
        self.sessManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
          
        /*
        self.sessManager.securityPolicy.allowInvalidCertificates = YES;
        self.sessManager.securityPolicy.validatesDomainName = NO;
        self.sessManager.securityPolicy.validatesCertificateChain = NO;
         */

    }
    return self;
}


- (void) getURL:(NSString *) baseUrlStr withUrl:(NSString *)urlStr
      withParam:(id)data
     httpHeader:(NSDictionary *)httpHeader
  receiveTarget:(NSString *)sender;
{
      
       __weak __typeof(self)weakSelf = self;
      
      httpBlock hb = ^(){
      
            // 秒后异步执行这里的代码...
            if ([weakSelf configHttpRequest:appServer withurl:urlStr param:data HttpHeader:httpHeader]) {
                  
                  // [self checkIp:url];
                  [weakSelf.sessManager GET:weakSelf.urlString parameters:data progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        
                        [weakSelf requestFinish:responseObject sender:sender];
                        
                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        
                        
                        [weakSelf netError:error sender:sender];
                        
                  }];
                  
            }

      };
      
      [self checkIp:baseUrlStr withurl:urlStr param:data HttpHeader:httpHeader wihtSender:sender withBlock:hb];
      
      
//         [self checkIp:baseUrlStr];
//      
//      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            
//            // 2秒后异步执行这里的代码...
//            if ([weakSelf configHttpRequest:appServer withurl:urlStr param:data HttpHeader:httpHeader]) {
//                  
//                  
//                  // [self checkIp:url];
//                  [weakSelf.sessManager GET:weakSelf.urlString parameters:data progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                        
//                        [weakSelf requestFinish:responseObject sender:sender];
//                        
//                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                        
//                        
//                        [weakSelf netError:error sender:sender];
//                        
//                  }];
//                  
//            }
//
//            
//      });
      
      
            

      
     
}

- (void)checkIp:(NSString *)url withurl:(NSString *)urlStr param:(id)data HttpHeader:(NSDictionary *)dict wihtSender:(NSString *)sender withBlock:(httpBlock)httpBlock{

      NSString *strUrl = [url stringByAppendingString:@"api/softUpdate/ios/getLatestVersion"];
      strUrl  = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
      // __weak __typeof(self)weakSelf = self;
      if ([[Tools getNetWorkStates] isEqualToString:@"WIFI"]) {
            
            
            //http://192.168.1.161:8080/api/softUpdate/ios/getLatestVersion
            
            [self.sessManager GET:strUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  
                  appServer = url;
                  NSLog(@"fanhu---------");
                //  self.httpBlock();
                  httpBlock();
                  
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  
                  //  NSString *str = [error localizedDescription];
                  NSLog(@"之前的url-----%@",url);
                  if ([url isEqualToString:baseUrl]) {
                        appServer = appInternal;
                        
                  }else{
                        
                        appServer = baseUrl;
                  }
                  
                  NSLog(@"请求成功。。。切换ip地址为:%@",appServer);
                  
                    httpBlock();
            }];
            
            //     NSLog(@"------请求成功。。。切换ip地址为:%@",appServer);
            
            //
            
      }else{
            
            //4g情况下改为外网IP
            //  appServer = @"http://58.18.33.194:9002/";
            appServer = baseUrl;
            
               httpBlock();
            
      }
      

}

- (void)checkIp:(NSString *)url{

    //  __weak __typeof(self)weakSelf = self;
     // self.urlStr = url;
      NSString *strUrl = [url stringByAppendingString:@"api/softUpdate/ios/getLatestVersion"];
      strUrl  = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
      // __weak __typeof(self)weakSelf = self;
      if ([[Tools getNetWorkStates] isEqualToString:@"WIFI"]) {

            //http://192.168.1.161:8080/api/softUpdate/ios/getLatestVersion
            
      [self.sessManager GET:strUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 
                  appServer = url;
                  NSLog(@"fanhu---------");
           
                  
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  
                //  NSString *str = [error localizedDescription];
                  NSLog(@"之前的url-----%@",url);
                  if ([url isEqualToString:baseUrl]) {
                        appServer =appInternal;
                        
                  }else{
                  
                        appServer = baseUrl;
                  }
                  
                   NSLog(@"请求成功。。。切换ip地址为:%@",appServer);
               
                  
            }];
            
        //     NSLog(@"------请求成功。。。切换ip地址为:%@",appServer);
          
           //
            
      }else{
            
            //4g情况下改为外网IP
            //  appServer = @"http://58.18.33.194:9002/";
             appServer = baseUrl;
           
            
      }
      
     
      
}


- (void)postURL:(NSString *)baseUrlStr withUrl:(NSString *)urlStr withParam:(id)data httpHeader:(NSDictionary *)httpHeader receiveTarget:(NSString *)sender{

       __weak __typeof(self)weakSelf = self;
      
     httpBlock hb = ^(){
            if ([weakSelf configHttpRequest:appServer withurl:urlStr param:data HttpHeader:httpHeader]) {
                  
                  NSLog(@"请求的url----%@",weakSelf.urlString);
                  
                  [weakSelf.sessManager POST:weakSelf.urlString parameters:data progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        
                        [weakSelf requestFinish:responseObject sender:sender];
                        
                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        
                        [weakSelf netError:error sender:sender];
                        
                  }];
                  
            }

            
      };
//
//      
      [self checkIp:baseUrlStr withurl:urlStr param:data HttpHeader:httpHeader wihtSender:sender withBlock:hb];
//
//                  [self checkIp:baseUrlStr];
//      
//      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            
//            // 2秒后异步执行这里的代码...
//            
//            if ([self configHttpRequest:appServer withurl:urlStr param:data HttpHeader:httpHeader]) {
//                  
//                  NSLog(@"请求的url----%@",self.urlString);
//                  
//                  [self.sessManager POST:self.urlString parameters:data progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                        
//                        [weakSelf requestFinish:responseObject sender:sender];
//                        
//                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                        
//                        [weakSelf netError:error sender:sender];
//                        
//                  }];
//                  
//            }
//
//            
//      });
      
          }


- (void)postURL:(NSString *)url withData:(NSData *)dataImage withParam:(id)data httpHeader:(NSDictionary *)httpHeader receiveTarget:(NSString *)sender{
      
      __weak __typeof(self)weakSelf = self;
      
    //  [self configHttpRequest:url param:data HttpHeader:httpHeader];
      
           [self.sessManager POST:self.urlString parameters:data constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileData:dataImage name:@"img" fileName:@"img.png" mimeType:@"image/png"];
      } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [weakSelf requestFinish:responseObject sender:sender];
      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [weakSelf netError:error sender:sender];
            NSLog(@"%@",[error localizedDescription]);
      }];

}


-(void)postURL:(NSString *)url
     withParam:(id)data
  updateImages:(NSArray<UIImage *> *)images
    imagesName:(NSString *)name
    httpHeader:(NSDictionary *)httpHeader
 receiveTarget:(NSString *)sender;
{
//      if ([self configHttpRequest:url param:data HttpHeader:httpHeader]) {
//            
//            __weak __typeof(self)weakSelf = self;
//            
//            [self.sessManager POST:self.urlString parameters:data constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//                  
//                  for (int i = 0; i < images.count; i ++ ) {
//                        
//                        UIImage * image = images[i];
//                        
//                        [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 1) name:name fileName:@"file.jpg" mimeType:@"image/jpg"];
//                        
//                  }
//                  
//            } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                  
//                  [weakSelf requestFinish:responseObject sender:sender];
//                  
//                  
//            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                  
//                  [weakSelf netError:error sender:sender];
//                  
//            }];
//            
//      }
}

#pragma mark---------private

-(BOOL)configHttpRequest:(NSString *)baseUrlStr withurl:(NSString *)urlStr param:(id)data HttpHeader:(NSDictionary *)dict
{
      [[Tools shareTools] startLoadingWithText:@"加载中"];
      //加载https ssl 验证
      //[self.sessManager setSecurityPolicy:nil];
        /****
         *
         *      如有必要可在此添加监测网络情况
         *
         ********/
//    NSLog(@"%ld",[AFNetworkReachabilityManager sharedManager].networkReachabilityStatus);
      if (![UIDevice networkAvailable])
      {
            
            [[Tools shareTools] alert:@"网络请求失败" :@"请检查手机网络设置."];
            
            
            [[Tools shareTools] stopLoading];
            
            
            return NO;
      }
      NSString *url = [baseUrlStr stringByAppendingString:urlStr];
    
        self.urlString=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
      
     // self.urlString = url;
        
        NSLog(@"request url====%@",self.urlString);
        NSLog(@"request param == %@",data);
    
        if (dict) {
            
            [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            
                [self.sessManager.requestSerializer setValue:obj forHTTPHeaderField:key];
            }];
            NSLog(@"httpHeader======%@",self.sessManager.requestSerializer.HTTPRequestHeaders);
        }
   
    return YES;
}


#pragma mark ---- 数据解析

-(void)requestFinish:(id)responseData sender:(NSString *)sender
{
      [[Tools shareTools] stopLoading];
    NSLog(@"response----%@",responseData);

    //解析
    
    if(!self.delegate)return;

   if([responseData isKindOfClass:[NSDictionary class]]){
       
       NSMutableDictionary * responseDict = [(NSDictionary *)responseData mutableCopy];
       
       if ([responseDict[@"success"] boolValue]) {
           
             if ([responseDict[@"data"] isKindOfClass:[NSNull class]]) {
                   [[Tools shareTools] showAlertWithText:@"数据未更新，请联系IT人员支持"];
                  
             }
           [self.delegate successRequest:responseDict[@"data"] withSender:sender];
           
       }else{
    
          [responseDict removeObjectForKey:@"success"];
           
           [self.delegate errorRequest:responseDict withSender:sender];
           
       }
       
   }else{
       
       [self.delegate successRequest:responseData withSender:sender];
       
   }
   
}

-(void)netError:(NSError *)error sender:(NSString *)sender
{
      [[Tools shareTools] stopLoading];
    if(self.delegate&&[self.delegate respondsToSelector:@selector(netFailedWithError:)])
    {
        [self.delegate netFailedWithError:error];
    }
}


@end
