//
//  NSDate+Extension.m
//  WeiBo
//
//  Created by apple on 15/7/17.
//  Copyright (c) 2015年 icsast. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)


- (BOOL)isYesterdayWithTargetDate:(NSDate *)targetDate{
    //当前时间
    NSDate *currentDate = self;
//    NSDate *currentDate = [NSDate date];
    
    //格式化器
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //重新定义时间格式化字符串-->只格式化年月日  后边的时分秒去掉，更方便的比较是否是昨天
    formatter.dateFormat = @"yyyy-MM-dd";
    
    //转成dateStr。，不带时分秒
    NSString *currentDateStr = [formatter stringFromDate:currentDate];
    NSString *targetDateStr = [formatter stringFromDate:targetDate];
    
    //再把dateStr 转成date，也不带时分秒(00:00:00)
    currentDate = [formatter dateFromString:currentDateStr];
    targetDate = [formatter dateFromString:targetDateStr];
    
    //初始化一个日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    //把时间进行对比。对比的天数(NSCalendarUnitDay)
    NSDateComponents *components = [calendar components:NSCalendarUnitDay fromDate:targetDate toDate:currentDate options:0];
    
    //只要components里面的day为1的话，就是代表差一天，在没有时分秒的情况，就代表昨天
    if (components.day==1) {
        return YES;
    }
    return NO;
}


- (BOOL)isThisYearWithTargetDate:(NSDate *)targetDate{
    
    //获取当前的时间
    NSDate *nowDate = self;
    
    //初始化一个时间格式化器，指定格式化字符串
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy";
    
    //获取现在时间与目标时间的年份字符串
    NSString *nowDateStr = [formatter stringFromDate:nowDate];
    NSString *targetDateStr = [formatter stringFromDate:targetDate];
    
    //进入对比，把对比结果直接返回
    return [nowDateStr isEqualToString:targetDateStr];
}


- (BOOL)isTodayWithTargetDate:(NSDate *)targetDate{
    //获取当前的时间
    NSDate *nowDate = self;
    
    //初始化一个时间格式化器，指定格式化字符串
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    
    //获取现在时间与目标时间的年份字符串
    NSString *nowDateStr = [formatter stringFromDate:nowDate];
    NSString *targetDateStr = [formatter stringFromDate:targetDate];
    
    //进入对比，把对比结果直接返回
    return [nowDateStr isEqualToString:targetDateStr];
}



@end
