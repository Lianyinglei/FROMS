//
//  AppDelegate.m
//  dsdl
//
//  Created by 廉英雷 on 16/11/2.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "MainViewController.h"
#import "LoginViewCon.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
      // Override point for customization after application launch.
      

      self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//      LoginViewController *loginVC = [[LoginViewController alloc] init];
      
//      MainViewController *mainVC = [MainViewController shareMainViewController];
    //  LoginViewController *loginVC = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
      
      LoginViewCon *loginVC = [[LoginViewCon alloc] init];
      self.window.rootViewController = loginVC;
      [self.window makeKeyAndVisible];
      return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
      // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
      // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
      // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
      // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
      // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
      NSString *time = [[NSUserDefaults standardUserDefaults] objectForKey:@"TIME"];
      
   [self formateDate:time];
      
     

      NSLog(@"进入前台界面了----");
      
}

- (void)formateDate:(NSString *)dateString
{

            // ------实例化一个NSDateFormatter对象
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//这里的格式必须和DateString格式一致
            
            NSDate * nowDate = [NSDate date];
            
            // ------将需要转换的时间转换成 NSDate 对象
            NSDate * needFormatDate = [dateFormatter dateFromString:dateString];
            
            // ------取当前时间和转换时间两个日期对象的时间间隔
            NSTimeInterval time = [nowDate timeIntervalSinceDate:needFormatDate];
            
            NSLog(@"转换的------time----%f",time);
            // ------再然后，把间隔的秒数折算成天数和小时数：
      
      
      if(time>=60*60*24){  //在两天内的
            
            self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
            
            LoginViewCon *loginVC = [[LoginViewCon alloc] init];
            self.window.rootViewController = loginVC;
            [self.window makeKeyAndVisible];
//            [dateFormatter setDateFormat:@"YYYY-MM-dd"];
//            NSString * need_yMd = [dateFormatter stringFromDate:needFormatDate];
//            NSString *now_yMd = [dateFormatter stringFromDate:nowDate];
//            
//            [dateFormatter setDateFormat:@"HH:mm"];
//            if ([need_yMd isEqualToString:now_yMd]) {
//                  //在同一天
//                  dateStr = [NSString stringWithFormat:@"今天 %@",[dateFormatter stringFromDate:needFormatDate]];
//            }else{
//                  //昨天
//                  dateStr = [NSString stringWithFormat:@"昨天 %@",[dateFormatter stringFromDate:needFormatDate]];
//            }
            
            
      }
      
            
//            NSString *dateStr = [[NSString alloc] init];
//            
//            if (time>=60) {  //1分钟以内的
//                  
//                  dateStr = @"刚刚";
//                  
//                  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//                  
//                  LoginViewCon *loginVC = [[LoginViewCon alloc] init];
//                  self.window.rootViewController = loginVC;
//                  [self.window makeKeyAndVisible];
//                  
//            }else if(time<=60*60){  //一个小时以内的
//                  
//                  int mins = time/60;
//                  dateStr = [NSString stringWithFormat:@"%d分钟前",mins];
//                  
//                  
//                
//                  
//            }else if(time>=60*60*24){  //在两天内的
//                  
//                  [dateFormatter setDateFormat:@"YYYY-MM-dd"];
//                  NSString * need_yMd = [dateFormatter stringFromDate:needFormatDate];
//                  NSString *now_yMd = [dateFormatter stringFromDate:nowDate];
//                  
//                  [dateFormatter setDateFormat:@"HH:mm"];
//                  if ([need_yMd isEqualToString:now_yMd]) {
//                        //在同一天
//                        dateStr = [NSString stringWithFormat:@"今天 %@",[dateFormatter stringFromDate:needFormatDate]];
//                  }else{
//                        //昨天
//                        dateStr = [NSString stringWithFormat:@"昨天 %@",[dateFormatter stringFromDate:needFormatDate]];
//                  }
//                  
//                  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//                  
//                  LoginViewCon *loginVC = [[LoginViewCon alloc] init];
//                  self.window.rootViewController = loginVC;
//                  [self.window makeKeyAndVisible];
//                  
//                  
//            }else {
      
//                  [dateFormatter setDateFormat:@"yyyy"];
//                  NSString * yearStr = [dateFormatter stringFromDate:needFormatDate];
//                  NSString *nowYear = [dateFormatter stringFromDate:nowDate];
//                  
//                  if ([yearStr isEqualToString:nowYear]) {
//                        //在同一年
//                        [dateFormatter setDateFormat:@"MM-dd"];
//                        dateStr = [dateFormatter stringFromDate:needFormatDate];
//                  }else{
//                        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//                        dateStr = [dateFormatter stringFromDate:needFormatDate];
//                  }
        //    }
            
          //  return dateStr;
      
      
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
      // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
      // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
