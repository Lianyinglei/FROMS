//
//  NSString+Extension.m
//
//
//  Created by apple on 14-10-18.
//  Copyright (c) 2014年 lian. All rights reserved.
//
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
#import "NSString+Extension.h"

@implementation NSString (Extension)
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    
    // 获得系统版本
   
        return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
   }

- (CGSize)sizeWithFont:(UIFont *)font
{
    return [self sizeWithFont:font maxW:MAXFLOAT];
}

@end
