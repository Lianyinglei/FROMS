//
//  YCXMenu.h
//  YCXMenuDemo
//
//  Created by YCX on 15/5/6.
//  Copyright (c) 2015年 YCX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YCXMenuItem.h"

typedef void(^YCXMenuSelectedItem)(NSInteger index, YCXMenuItem *item);

typedef enum {
    YCXMenuBackgrounColorEffectSolid      = 0, //!<背景显示效果.纯色
    YCXMenuBackgrounColorEffectGradient   = 1, //!<背景显示效果.渐变叠加
} YCXMenuBackgrounColorEffect;

@interface YCXMenu : NSObject



+ (void)showMenuInView:(UIView *)view fromRect:(CGRect)rect menuItems:(NSArray *)menuItems selected:(YCXMenuSelectedItem)selectedItem;

+ (void)dismissMenu;


+(BOOL)getShowFlag;

// 主题色
+ (UIColor *)tintColor;
+ (void)setTintColor:(UIColor *)tintColor;

// 标题字体
+ (UIFont *)titleFont;
+ (void)setTitleFont:(UIFont *)titleFont;

// 背景效果
+ (YCXMenuBackgrounColorEffect)backgrounColorEffect;
+ (void)setBackgrounColorEffect:(YCXMenuBackgrounColorEffect)effect;

// 是否显示阴影
+ (BOOL)hasShadow;
+ (void)setHasShadow:(BOOL)flag;

@end
